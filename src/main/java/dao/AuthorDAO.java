package dao;

import model.Author;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuthorDAO {
    
    public boolean addAuthor(Author author) throws SQLException {
        String sql = "INSERT INTO Author (author_name, birth_date, nationality, awards, biography) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, author.getAuthorName());
            if (author.getBirthDate() != null) {
                stmt.setDate(2, new java.sql.Date(author.getBirthDate().getTime()));
            } else {
                stmt.setNull(2, Types.DATE);
            }
            stmt.setString(3, author.getNationality());
            stmt.setString(4, author.getAwards());
            stmt.setString(5, author.getBiography());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        author.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        }
        return false;
    }

    public List<Author> getAllAuthors() throws SQLException {
        List<Author> authors = new ArrayList<>();
        String sql = "SELECT * FROM Author ORDER BY author_name";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Author author = new Author();
                author.setId(rs.getInt("author_ID"));
                author.setAuthorName(rs.getString("author_name"));
                author.setBirthDate(rs.getDate("birth_date"));
                author.setNationality(rs.getString("nationality"));
                author.setAwards(rs.getString("awards"));
                author.setBiography(rs.getString("biography"));
                authors.add(author);
            }
            
            return authors;
        }
    }

    public Author getAuthorById(int id) throws SQLException {
        String sql = "SELECT * FROM Author WHERE author_ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Author author = new Author();
                    author.setId(rs.getInt("author_ID"));
                    author.setAuthorName(rs.getString("author_name"));
                    author.setBirthDate(rs.getDate("birth_date"));
                    author.setNationality(rs.getString("nationality"));
                    author.setAwards(rs.getString("awards"));
                    author.setBiography(rs.getString("biography"));
                    return author;
                }
            }
        }
        return null;
    }

    public boolean updateAuthor(Author author) throws SQLException {
        String sql = "UPDATE Author SET author_name=?, birth_date=?, nationality=?, awards=?, biography=? WHERE author_ID=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, author.getAuthorName());
            if (author.getBirthDate() != null) {
                stmt.setDate(2, new java.sql.Date(author.getBirthDate().getTime()));
            } else {
                stmt.setNull(2, Types.DATE);
            }
            stmt.setString(3, author.getNationality());
            stmt.setString(4, author.getAwards());
            stmt.setString(5, author.getBiography());
            stmt.setInt(6, author.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteAuthor(int id) throws SQLException {
        String sql = "DELETE FROM Author WHERE author_ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
} 