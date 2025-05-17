package dao;

import model.*;
import util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BorrowDAO {
    
    /**
     * Add a new borrow record
     * @param borrow The borrow object to add
     * @param bookId The ID of the book being borrowed
     * @return True if borrow record added successfully, false otherwise
     */
    public boolean addBorrow(Borrow borrow, int bookId) {
        String insertBorrowSql = "INSERT INTO Borrow (user_ID, borrow_date) VALUES (?, ?)";
        String insertFineSql = "INSERT INTO Fine (borrow_ID, book_ID, issue_date, due_date) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            
            try {
                // Insert into Borrow table
                try (PreparedStatement stmt = conn.prepareStatement(insertBorrowSql, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, borrow.getUser().getUserID());
                    stmt.setDate(2, new java.sql.Date(borrow.getBorrowDate().getTime()));
                    
                    int affectedRows = stmt.executeUpdate();
                    if (affectedRows > 0) {
                        try (ResultSet rs = stmt.getGeneratedKeys()) {
                            if (rs.next()) {
                                int borrowId = rs.getInt(1);
                                borrow.setBorrowID(borrowId);
                                
                                // Insert into Fine table with initial dates
                                try (PreparedStatement fineStmt = conn.prepareStatement(insertFineSql)) {
                                    fineStmt.setInt(1, borrowId);
                                    fineStmt.setInt(2, bookId);
                                    fineStmt.setDate(3, new java.sql.Date(borrow.getBorrowDate().getTime()));
                                    fineStmt.setDate(4, new java.sql.Date(borrow.getDueDate().getTime()));
                                    fineStmt.executeUpdate();
                                }
                                
                                conn.commit();
                                return true;
                            }
                        }
                    }
                }
                
                conn.rollback();
                return false;
                
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get all borrows for a user
     * @param userId The user ID
     * @return List of borrows
     */
    public List<Borrow> getBorrowsByUserId(int userId) {
        List<Borrow> borrows = new ArrayList<>();
        String sql = "SELECT b.*, f.*, bk.title as book_title, bk.isbn, a.author_name " +
                    "FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "JOIN Book bk ON f.book_ID = bk.book_ID " +
                    "LEFT JOIN Book_Author ba ON bk.book_ID = ba.book_ID " +
                    "LEFT JOIN Author a ON ba.author_ID = a.author_ID " +
                    "WHERE b.user_ID = ? " +
                    "ORDER BY b.borrow_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Borrow borrow = new Borrow();
                    borrow.setBorrowID(rs.getInt("borrow_ID"));
                    borrow.setBorrowDate(rs.getDate("borrow_date"));
                    borrow.setDueDate(rs.getDate("due_date"));
                    borrow.setReturnDate(rs.getDate("return_date"));
                    
                    // Set book details
                    Book book = new Book();
                    book.setId(rs.getInt("book_ID"));
                    book.setTitle(rs.getString("book_title"));
                    book.setIsbn(rs.getString("isbn"));
                    
                    // Set author if exists
                    String authorName = rs.getString("author_name");
                    if (authorName != null) {
                        Author author = new Author();
                        author.setAuthorName(authorName);
                        List<Author> authors = new ArrayList<>();
                        authors.add(author);
                        book.setAuthors(authors);
                    }
                    
                    borrow.setBook(book);
                    
                    // Create and add fine if exists
                    if (rs.getInt("fine_ID") > 0) {
                        Fine fine = new Fine();
                        fine.setFineID(rs.getInt("fine_ID"));
                        fine.setIssueDate(rs.getDate("issue_date"));
                        fine.setDueDate(rs.getDate("due_date"));
                        fine.setReturnDate(rs.getDate("return_date"));
                        fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                        borrow.addFine(fine);
                    }
                    
                    borrows.add(borrow);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return borrows;
    }
    
    /**
     * Get all active borrows (not returned)
     * @return List of active borrows
     * @throws SQLException If there is a database error
     */
    public List<Borrow> getActiveBorrows() throws SQLException {
        List<Borrow> borrows = new ArrayList<>();
        String sql = "SELECT b.*, f.*, u.name as user_name, u.email as user_email, bk.title as book_title " +
                    "FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "JOIN User u ON b.user_ID = u.user_ID " +
                    "JOIN Book bk ON f.book_ID = bk.book_ID " +
                    "WHERE f.return_date IS NULL " +
                    "ORDER BY b.borrow_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            System.out.println("BorrowDAO.getActiveBorrows: Executing query for active borrows");
            
            while (rs.next()) {
                Borrow borrow = new Borrow();
                borrow.setBorrowID(rs.getInt("borrow_ID"));
                borrow.setBorrowDate(rs.getDate("borrow_date"));
                borrow.setDueDate(rs.getDate("due_date"));
                
                // Create user object
                User user = new User();
                user.setUserID(rs.getInt("user_ID"));
                user.setName(rs.getString("user_name"));
                user.setEmail(rs.getString("user_email"));
                borrow.setUser(user);
                
                // Create book object
                Book book = new Book();
                book.setId(rs.getInt("book_ID"));
                book.setTitle(rs.getString("book_title"));
                borrow.setBook(book);
                
                // Create and add fine if exists
                if (rs.getInt("fine_ID") > 0) {
                    Fine fine = new Fine();
                    fine.setFineID(rs.getInt("fine_ID"));
                    fine.setIssueDate(rs.getDate("issue_date"));
                    fine.setDueDate(rs.getDate("due_date"));
                    fine.setReturnDate(rs.getDate("return_date"));
                    fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                    borrow.addFine(fine);
                }
                
                borrows.add(borrow);
            }
            
            System.out.println("BorrowDAO.getActiveBorrows: Found " + borrows.size() + " active borrows");
            return borrows;
        }
    }
    
    /**
     * Return a borrowed book
     * @param borrowId The borrow ID
     * @param returnDate The return date
     * @param fineAmount The fine amount if any
     * @return True if return successful, false otherwise
     * @throws SQLException If there is a database error
     */
    public boolean returnBook(int borrowId, Date returnDate, BigDecimal fineAmount) throws SQLException {
        String updateSql = "UPDATE Fine SET return_date = ?, fine_amount = ? WHERE borrow_ID = ? AND return_date IS NULL";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(updateSql)) {
            
            System.out.println("BorrowDAO.returnBook: Returning book for borrowId=" + borrowId + ", returnDate=" + returnDate + ", fineAmount=" + fineAmount);
            
            stmt.setDate(1, new java.sql.Date(returnDate.getTime()));
            stmt.setBigDecimal(2, fineAmount);
            stmt.setInt(3, borrowId);
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("BorrowDAO.returnBook: Rows affected: " + rowsAffected);
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("BorrowDAO.returnBook: SQLException - " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Check if a user has already borrowed a book and hasn't returned it
     * @param userId The user ID
     * @param bookId The book ID
     * @return True if the user has an active borrow for this book
     */
    public boolean hasActiveBorrow(int userId, int bookId) {
        String sql = "SELECT COUNT(*) FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "WHERE b.user_ID = ? AND f.book_ID = ? AND f.return_date IS NULL";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, bookId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get all active (not returned) borrows for a specific user
     * @param userId The user ID
     * @return List of active borrows
     */
    public List<Borrow> getActiveBorrowsByUserId(int userId) {
        List<Borrow> borrows = new ArrayList<>();
        String sql = "SELECT b.*, f.*, bk.title as book_title, bk.isbn, a.author_name " +
                    "FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "JOIN Book bk ON f.book_ID = bk.book_ID " +
                    "LEFT JOIN Book_Author ba ON bk.book_ID = ba.book_ID " +
                    "LEFT JOIN Author a ON ba.author_ID = a.author_ID " +
                    "WHERE b.user_ID = ? AND f.return_date IS NULL " +
                    "ORDER BY b.borrow_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Borrow borrow = new Borrow();
                    borrow.setBorrowID(rs.getInt("borrow_ID"));
                    borrow.setBorrowDate(rs.getDate("borrow_date"));
                    borrow.setDueDate(rs.getDate("due_date"));
                    
                    // Set book details
                    Book book = new Book();
                    book.setId(rs.getInt("book_ID"));
                    book.setTitle(rs.getString("book_title"));
                    book.setIsbn(rs.getString("isbn"));
                    
                    // Set author if exists
                    String authorName = rs.getString("author_name");
                    if (authorName != null) {
                        Author author = new Author();
                        author.setAuthorName(authorName);
                        List<Author> authors = new ArrayList<>();
                        authors.add(author);
                        book.setAuthors(authors);
                    }
                    
                    borrow.setBook(book);
                    
                    // Add fine if exists
                    if (rs.getInt("fine_ID") > 0) {
                        Fine fine = new Fine();
                        fine.setFineID(rs.getInt("fine_ID"));
                        fine.setIssueDate(rs.getDate("issue_date"));
                        fine.setDueDate(rs.getDate("due_date"));
                        fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                        borrow.addFine(fine);
                    }
                    
                    borrows.add(borrow);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return borrows;
    }
    
    /**
     * Get recent borrows and returns for dashboard
     * @param limit Number of records to return
     * @return List of recent borrows and returns
     * @throws SQLException If there is a database error
     */
    public List<Borrow> getRecentActivity(int limit) throws SQLException {
        List<Borrow> activity = new ArrayList<>();
        String sql = "SELECT b.*, f.*, u.name as user_name, u.email as user_email, " +
                    "bk.book_ID, bk.title as book_title " +
                    "FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "JOIN User u ON b.user_ID = u.user_ID " +
                    "JOIN Book bk ON f.book_ID = bk.book_ID " +
                    "ORDER BY COALESCE(f.return_date, b.borrow_date) DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Borrow borrow = new Borrow();
                    borrow.setBorrowID(rs.getInt("borrow_ID"));
                    borrow.setBorrowDate(rs.getDate("borrow_date"));
                    borrow.setDueDate(rs.getDate("due_date"));
                    borrow.setReturnDate(rs.getDate("return_date"));
                    
                    // Create user object
                    User user = new User();
                    user.setUserID(rs.getInt("user_ID"));
                    user.setName(rs.getString("user_name"));
                    user.setEmail(rs.getString("user_email"));
                    borrow.setUser(user);
                    
                    // Create book object
                    Book book = new Book();
                    book.setId(rs.getInt("book_ID"));
                    book.setTitle(rs.getString("book_title"));
                    borrow.setBook(book);
                    
                    // Create and add fine if exists
                    if (rs.getInt("fine_ID") > 0) {
                        Fine fine = new Fine();
                        fine.setFineID(rs.getInt("fine_ID"));
                        fine.setIssueDate(rs.getDate("issue_date"));
                        fine.setDueDate(rs.getDate("due_date"));
                        fine.setReturnDate(rs.getDate("return_date"));
                        fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                        borrow.addFine(fine);
                    }
                    
                    activity.add(borrow);
                }
            }
        }
        
        return activity;
    }
    
    /**
     * Get all returned books (return history)
     * @return List of returned books
     * @throws SQLException If there is a database error
     */
    public List<Borrow> getReturnHistory() throws SQLException {
        List<Borrow> returnedBooks = new ArrayList<>();
        String sql = "SELECT b.*, f.*, u.name as user_name, u.email as user_email, " +
                    "bk.book_ID, bk.title as book_title, a.author_name " +
                    "FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "JOIN User u ON b.user_ID = u.user_ID " +
                    "JOIN Book bk ON f.book_ID = bk.book_ID " +
                    "LEFT JOIN Book_Author ba ON bk.book_ID = ba.book_ID " +
                    "LEFT JOIN Author a ON ba.author_ID = a.author_ID " +
                    "WHERE f.return_date IS NOT NULL " +
                    "ORDER BY f.return_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            System.out.println("BorrowDAO.getReturnHistory: Executing query");
            
            while (rs.next()) {
                Borrow borrow = new Borrow();
                borrow.setBorrowID(rs.getInt("borrow_ID"));
                borrow.setBorrowDate(rs.getDate("borrow_date"));
                borrow.setDueDate(rs.getDate("due_date"));
                borrow.setReturnDate(rs.getDate("return_date"));
                
                // Create user object
                User user = new User();
                user.setUserID(rs.getInt("user_ID"));
                user.setName(rs.getString("user_name"));
                user.setEmail(rs.getString("user_email"));
                borrow.setUser(user);
                
                // Create book object
                Book book = new Book();
                book.setId(rs.getInt("book_ID"));
                book.setTitle(rs.getString("book_title"));
                
                // Add author if available
                String authorName = rs.getString("author_name");
                if (authorName != null) {
                    Author author = new Author();
                    author.setAuthorName(authorName);
                    book.addAuthor(author);
                }
                borrow.setBook(book);
                
                // Create and add fine if exists
                if (rs.getInt("fine_ID") > 0) {
                    Fine fine = new Fine();
                    fine.setFineID(rs.getInt("fine_ID"));
                    fine.setIssueDate(rs.getDate("issue_date"));
                    fine.setDueDate(rs.getDate("due_date"));
                    fine.setReturnDate(rs.getDate("return_date"));
                    fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                    borrow.addFine(fine);
                }
                
                returnedBooks.add(borrow);
            }
            
            System.out.println("BorrowDAO.getReturnHistory: Found " + returnedBooks.size() + " returned books");
            return returnedBooks;
        }
    }
    
    /**
     * Get recent borrows and returns for a specific user
     * @param userId The user ID
     * @param limit Number of records to return
     * @return List of recent borrows/returns for the user
     * @throws SQLException If there is a database error
     */
    public List<Borrow> getRecentBorrowsByUserId(int userId, int limit) throws SQLException {
        List<Borrow> activity = new ArrayList<>();
        String sql = "SELECT b.*, f.*, u.name as user_name, u.email as user_email, " +
                    "bk.book_ID, bk.title as book_title, a.author_name " +
                    "FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "JOIN User u ON b.user_ID = u.user_ID " +
                    "JOIN Book bk ON f.book_ID = bk.book_ID " +
                    "LEFT JOIN Book_Author ba ON bk.book_ID = ba.book_ID " +
                    "LEFT JOIN Author a ON ba.author_ID = a.author_ID " +
                    "WHERE b.user_ID = ? " +
                    "ORDER BY COALESCE(f.return_date, b.borrow_date) DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Borrow borrow = new Borrow();
                    borrow.setBorrowID(rs.getInt("borrow_ID"));
                    borrow.setBorrowDate(rs.getDate("borrow_date"));
                    borrow.setDueDate(rs.getDate("due_date"));
                    borrow.setReturnDate(rs.getDate("return_date"));
                    
                    // Create user object
                    User user = new User();
                    user.setUserID(rs.getInt("user_ID"));
                    user.setName(rs.getString("user_name"));
                    user.setEmail(rs.getString("user_email"));
                    borrow.setUser(user);
                    
                    // Create book object
                    Book book = new Book();
                    book.setId(rs.getInt("book_ID"));
                    book.setTitle(rs.getString("book_title"));
                    
                    // Add author if available
                    String authorName = rs.getString("author_name");
                    if (authorName != null) {
                        Author author = new Author();
                        author.setAuthorName(authorName);
                        book.addAuthor(author);
                    }
                    borrow.setBook(book);
                    
                    // Create and add fine if exists
                    if (rs.getInt("fine_ID") > 0) {
                        Fine fine = new Fine();
                        fine.setFineID(rs.getInt("fine_ID"));
                        fine.setIssueDate(rs.getDate("issue_date"));
                        fine.setDueDate(rs.getDate("due_date"));
                        fine.setReturnDate(rs.getDate("return_date"));
                        fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                        borrow.addFine(fine);
                    }
                    
                    activity.add(borrow);
                }
            }
            
            return activity;
        }
    }
    
    /**
     * Get all overdue borrows for a specific user
     * @param userId The user ID
     * @return List of overdue borrows
     * @throws SQLException If a database error occurs
     */
    public List<Borrow> getOverdueBorrowsByUserId(int userId) throws SQLException {
        List<Borrow> overdueBorrows = new ArrayList<>();
        String sql = "SELECT b.*, f.*, bk.title as book_title, bk.isbn, a.author_name " +
                    "FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "JOIN Book bk ON f.book_ID = bk.book_ID " +
                    "LEFT JOIN Book_Author ba ON bk.book_ID = ba.book_ID " +
                    "LEFT JOIN Author a ON ba.author_ID = a.author_ID " +
                    "WHERE b.user_ID = ? AND CURRENT_DATE > f.due_date AND f.return_date IS NULL " +
                    "ORDER BY f.due_date ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Borrow borrow = new Borrow();
                    borrow.setBorrowID(rs.getInt("borrow_ID"));
                    borrow.setBorrowDate(rs.getDate("borrow_date"));
                    borrow.setDueDate(rs.getDate("due_date"));
                    
                    // Set book details
                    Book book = new Book();
                    book.setId(rs.getInt("book_ID"));
                    book.setTitle(rs.getString("book_title"));
                    book.setIsbn(rs.getString("isbn"));
                    
                    // Set author if exists
                    String authorName = rs.getString("author_name");
                    if (authorName != null) {
                        Author author = new Author();
                        author.setAuthorName(authorName);
                        List<Author> authors = new ArrayList<>();
                        authors.add(author);
                        book.setAuthors(authors);
                    }
                    
                    borrow.setBook(book);
                    
                    // Add fine if exists
                    if (rs.getInt("fine_ID") > 0) {
                        Fine fine = new Fine();
                        fine.setFineID(rs.getInt("fine_ID"));
                        fine.setIssueDate(rs.getDate("issue_date"));
                        fine.setDueDate(rs.getDate("due_date"));
                        fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                        borrow.addFine(fine);
                    }
                    
                    overdueBorrows.add(borrow);
                }
            }
        }
        
        return overdueBorrows;
    }
    
    /**
     * Get all overdue books (books that are past their due date and not returned)
     * @return List of overdue borrows
     * @throws SQLException If there is a database error
     */
    public List<Borrow> getOverdueBooks() throws SQLException {
        List<Borrow> overdueBooks = new ArrayList<>();
        String sql = "SELECT b.*, f.*, u.name as user_name, u.email as user_email, bk.title as book_title " +
                    "FROM Borrow b " +
                    "JOIN Fine f ON b.borrow_ID = f.borrow_ID " +
                    "JOIN User u ON b.user_ID = u.user_ID " +
                    "JOIN Book bk ON f.book_ID = bk.book_ID " +
                    "WHERE f.return_date IS NULL AND f.due_date < CURRENT_DATE " +
                    "ORDER BY f.due_date ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            System.out.println("BorrowDAO.getOverdueBooks: Executing query for overdue books");
            
            while (rs.next()) {
                Borrow borrow = new Borrow();
                borrow.setBorrowID(rs.getInt("borrow_ID"));
                borrow.setBorrowDate(rs.getDate("borrow_date"));
                borrow.setDueDate(rs.getDate("due_date"));
                
                // Create user object
                User user = new User();
                user.setUserID(rs.getInt("user_ID"));
                user.setName(rs.getString("user_name"));
                user.setEmail(rs.getString("user_email"));
                borrow.setUser(user);
                
                // Create book object
                Book book = new Book();
                book.setId(rs.getInt("book_ID"));
                book.setTitle(rs.getString("book_title"));
                borrow.setBook(book);
                
                // Create and add fine if exists
                if (rs.getInt("fine_ID") > 0) {
                    Fine fine = new Fine();
                    fine.setFineID(rs.getInt("fine_ID"));
                    fine.setIssueDate(rs.getDate("issue_date"));
                    fine.setDueDate(rs.getDate("due_date"));
                    fine.setReturnDate(rs.getDate("return_date"));
                    fine.setFineAmount(rs.getBigDecimal("fine_amount"));
                    borrow.addFine(fine);
                }
                
                overdueBooks.add(borrow);
            }
            
            System.out.println("BorrowDAO.getOverdueBooks: Found " + overdueBooks.size() + " overdue books");
            return overdueBooks;
        }
    }
} 