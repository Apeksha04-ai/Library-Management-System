package dao;

import model.Book;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookDAO {
    
    public boolean addBook(Book book) throws SQLException {
        String insertBookSql = "INSERT INTO Book (isbn, title, quantity, publication_date, category, image_url, availability_status) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertBookAuthorSql = "INSERT INTO Book_Author (book_ID, author_ID) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Insert into Book table
                try (PreparedStatement stmt = conn.prepareStatement(insertBookSql, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setString(1, book.getIsbn());
                    stmt.setString(2, book.getTitle());
                    stmt.setInt(3, book.getQuantity());
                    stmt.setDate(4, new java.sql.Date(book.getPublicationDate().getTime()));
                    stmt.setString(5, book.getCategory());
                    stmt.setString(6, book.getCoverImage() != null ? "/uploads/books/" + book.getCoverImage() : null);
                    stmt.setString(7, book.getQuantity() > 0 ? "Available" : "Unavailable");

                    int affectedRows = stmt.executeUpdate();
                    if (affectedRows > 0) {
                        try (ResultSet rs = stmt.getGeneratedKeys()) {
                            if (rs.next()) {
                                int bookId = rs.getInt(1);
                                book.setId(bookId);
                                
                                // Insert into Book_Author table
                                try (PreparedStatement authorStmt = conn.prepareStatement(insertBookAuthorSql)) {
                                    authorStmt.setInt(1, bookId);
                                    authorStmt.setInt(2, book.getAuthorId());
                                    authorStmt.executeUpdate();
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
        }
    }

    public List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM Book";
        
        try (Connection conn = DBConnection.getConnection()) {
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                System.out.println("Executing query: " + sql);
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("book_ID"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setTitle(rs.getString("title"));
                    book.setCategory(rs.getString("category"));
                    book.setPublicationDate(rs.getDate("publication_date"));
                    book.setQuantity(rs.getInt("quantity"));
                    String imageUrl = rs.getString("image_url");
                    if (imageUrl != null && imageUrl.startsWith("/uploads/books/")) {
                        book.setCoverImage(imageUrl.substring("/uploads/books/".length()));
                    } else {
                        book.setCoverImage(imageUrl);
                    }
                    book.setAvailable(rs.getString("availability_status").equals("Available"));
                    
                    // Get author ID from Book_Author table
                    try (PreparedStatement authorStmt = conn.prepareStatement(
                            "SELECT author_ID FROM Book_Author WHERE book_ID = ?")) {
                        authorStmt.setInt(1, book.getId());
                        try (ResultSet authorRs = authorStmt.executeQuery()) {
                            if (authorRs.next()) {
                                book.setAuthorId(authorRs.getInt("author_ID"));
                            }
                        }
                    }
                    
                    books.add(book);
                    System.out.println("Loaded book: ID=" + book.getId() + ", Title=" + book.getTitle() + ", Image=" + book.getCoverImage());
                }
            }
        }
        return books;
    }

    public Book getBookById(int id) throws SQLException {
        String sql = "SELECT b.*, ba.author_ID FROM Book b " +
                    "LEFT JOIN Book_Author ba ON b.book_ID = ba.book_ID " +
                    "WHERE b.book_ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("book_ID"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthorId(rs.getInt("author_ID"));
                    book.setCategory(rs.getString("category"));
                    book.setPublicationDate(rs.getDate("publication_date"));
                    book.setQuantity(rs.getInt("quantity"));
                    book.setCoverImage(rs.getString("image_url"));
                    book.setAvailable(rs.getString("availability_status").equals("Available"));
                    return book;
                }
            }
        }
        return null;
    }

    public boolean updateBook(Book book) throws SQLException {
        String updateBookSql = "UPDATE Book SET isbn=?, title=?, quantity=?, publication_date=?, " +
                             "category=?, image_url=?, availability_status=? WHERE book_ID=?";
        String updateBookAuthorSql = "UPDATE Book_Author SET author_ID=? WHERE book_ID=?";
        
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Update Book table
                try (PreparedStatement stmt = conn.prepareStatement(updateBookSql)) {
                    stmt.setString(1, book.getIsbn());
                    stmt.setString(2, book.getTitle());
                    stmt.setInt(3, book.getQuantity());
                    stmt.setDate(4, new java.sql.Date(book.getPublicationDate().getTime()));
                    stmt.setString(5, book.getCategory());
                    stmt.setString(6, book.getCoverImage());
                    stmt.setString(7, book.getQuantity() > 0 ? "Available" : "Unavailable");
                    stmt.setInt(8, book.getId());
                    
                    if (stmt.executeUpdate() > 0) {
                        // Update Book_Author table
                        try (PreparedStatement authorStmt = conn.prepareStatement(updateBookAuthorSql)) {
                            authorStmt.setInt(1, book.getAuthorId());
                            authorStmt.setInt(2, book.getId());
                            authorStmt.executeUpdate();
                        }
                        conn.commit();
                        return true;
                    }
                }
                conn.rollback();
                return false;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    public boolean deleteBook(int id) throws SQLException {
        // First delete from Book_Author table
        String deleteBookAuthorSql = "DELETE FROM Book_Author WHERE book_ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(deleteBookAuthorSql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
        
        // Then delete from Book table
        String deleteBookSql = "DELETE FROM Book WHERE book_ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(deleteBookSql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public Map<String, Integer> getBooksByCategory() throws SQLException {
        Map<String, Integer> categoryCount = new HashMap<>();
        String sql = "SELECT category, COUNT(*) as count FROM Book GROUP BY category ORDER BY count DESC LIMIT 3";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                categoryCount.put(rs.getString("category"), rs.getInt("count"));
            }
        }
        return categoryCount;
    }

    public int getTotalBooks() throws SQLException {
        String sql = "SELECT SUM(quantity) as total FROM Book";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public List<Book> searchBooks(String query) throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, ba.author_ID FROM Book b " +
                    "LEFT JOIN Book_Author ba ON b.book_ID = ba.book_ID " +
                    "LEFT JOIN Author a ON ba.author_ID = a.author_ID " +
                    "WHERE LOWER(b.title) LIKE ? OR LOWER(a.author_name) LIKE ? OR b.isbn LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + query.toLowerCase() + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("book_ID"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthorId(rs.getInt("author_ID"));
                    book.setCategory(rs.getString("category"));
                    book.setPublicationDate(rs.getDate("publication_date"));
                    book.setQuantity(rs.getInt("quantity"));
                    book.setCoverImage(rs.getString("image_url"));
                    book.setAvailable(rs.getString("availability_status").equals("Available"));
                    books.add(book);
                }
            }
        }
        return books;
    }
} 