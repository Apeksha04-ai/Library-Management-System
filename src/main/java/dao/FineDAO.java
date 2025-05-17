package dao;

import model.Fine;
import util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FineDAO {
    
    /**
     * Get total fines collected
     * @return The total fine amount
     * @throws SQLException If a database error occurs
     */
    public BigDecimal getTotalFines() throws SQLException {
        String sql = "SELECT SUM(fine_amount) AS total_fines FROM Fine WHERE return_date IS NOT NULL";
        BigDecimal totalFines = BigDecimal.ZERO;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                BigDecimal dbValue = rs.getBigDecimal("total_fines");
                if (dbValue != null) {
                    totalFines = dbValue;
                }
            }
        }
        
        return totalFines;
    }
    
    /**
     * Get all unpaid fines
     * @return A list of unpaid fines
     * @throws SQLException If a database error occurs
     */
    public List<Fine> getUnpaidFines() throws SQLException {
        String sql = "SELECT * FROM Fine WHERE return_date IS NOT NULL AND fine_amount > 0 AND payment_date IS NULL";
        List<Fine> fines = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Fine fine = new Fine();
                fine.setFineID(rs.getInt("fine_ID"));
                fine.setIssueDate(rs.getDate("issue_date"));
                fine.setDueDate(rs.getDate("due_date"));
                fine.setReturnDate(rs.getDate("return_date"));
                fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                
                fines.add(fine);
            }
        }
        
        return fines;
    }
    
    /**
     * Get outstanding fines for a specific user
     * @param userId The user ID
     * @return The total outstanding fine amount
     * @throws SQLException If a database error occurs
     */
    public BigDecimal getOutstandingFines(int userId) throws SQLException {
        String sql = "SELECT SUM(f.fine_amount) AS total_fines FROM Fine f " +
                     "JOIN Borrow b ON f.borrow_ID = b.borrow_ID " +
                     "WHERE b.user_ID = ? AND f.return_date IS NOT NULL AND f.fine_amount > 0";
        
        BigDecimal totalFines = BigDecimal.ZERO;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    BigDecimal dbValue = rs.getBigDecimal("total_fines");
                    if (dbValue != null) {
                        totalFines = dbValue;
                    }
                }
            }
        }
        
        return totalFines;
    }
    
    /**
     * Pay a fine
     * @param fineId The ID of the fine
     * @return True if payment was successful, false otherwise
     * @throws SQLException If a database error occurs
     */
    public boolean payFine(int fineId) throws SQLException {
        String sql = "UPDATE Fine SET fine_amount = 0 WHERE fine_ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, fineId);
            
            return stmt.executeUpdate() > 0;
        }
    }
} 