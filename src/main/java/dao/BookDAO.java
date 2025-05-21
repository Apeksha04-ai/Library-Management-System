package dao;

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
        Map<Integer, Book> bookMap = new HashMap<>();
        String sql = "SELECT b.*, a.author_name FROM Book b " +
                    "LEFT JOIN Book_Author ba ON b.book_ID = ba.book_ID " +
                    "LEFT JOIN Author a ON ba.author_ID = a.author_ID";
        
        try (Connection conn = DBConnection.getConnection()) {
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                System.out.println("Executing query: " + sql);
                while (rs.next()) {
                    int bookId = rs.getInt("book_ID");
                    
                    // If we've already seen this book, just add the author
                    if (bookMap.containsKey(bookId)) {
                        Book existingBook = bookMap.get(bookId);
                        String authorName = rs.getString("author_name");
                        if (authorName != null) {
                            Author author = new Author();
                            author.setAuthorName(authorName);
                            existingBook.addAuthor(author);
                        }
                    } else {
                        // Otherwise create a new book
                        Book book = new Book();
                        book.setId(bookId);
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
                        
                        // Add author information if available
                        String authorName = rs.getString("author_name");
                        if (authorName != null) {
                            Author author = new Author();
                            author.setAuthorName(authorName);
                            book.addAuthor(author);
                        }
                        
                        bookMap.put(bookId, book);
                        System.out.println("Loaded book: ID=" + book.getId() + ", Title=" + book.getTitle() + ", Image=" + book.getCoverImage());
                    }
                }
            }
        }
        return new ArrayList<>(bookMap.values());
    }

    /**
     * Get a book by its ID
     * @param id The ID of the book to retrieve
     * @return The Book object if found, null otherwise
     */
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
                    String imageUrl = rs.getString("image_url");
                    if (imageUrl != null && imageUrl.startsWith("/uploads/books/")) {
                        book.setCoverImage(imageUrl.substring("/uploads/books/".length()));
                    } else {
                        book.setCoverImage(imageUrl);
                    }
                    book.setAvailable(rs.getString("availability_status").equals("Available"));
                    return book;
                }
            }
        }
        return null;
    }

    /**
     * Update an existing book in the database
     * @param book The book object containing updated information
     * @return true if update was successful, false otherwise
     */
    public boolean updateBook(Book book) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Update Book table
            String updateBookSql = "UPDATE Book SET isbn = ?, title = ?, category = ?, " +
                                 "quantity = ?, publication_date = ?, " +
                                 (book.getCoverImage() != null ? "image_url = ?, " : "") +
                                 "availability_status = ? " +
                                 "WHERE book_ID = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(updateBookSql)) {
                int paramIndex = 1;
                stmt.setString(paramIndex++, book.getIsbn());
                stmt.setString(paramIndex++, book.getTitle());
                stmt.setString(paramIndex++, book.getCategory());
                stmt.setInt(paramIndex++, book.getQuantity());
                stmt.setDate(paramIndex++, new java.sql.Date(book.getPublicationDate().getTime()));
                
                if (book.getCoverImage() != null) {
                    stmt.setString(paramIndex++, "/uploads/books/" + book.getCoverImage());
                }
                
                stmt.setString(paramIndex++, book.getQuantity() > 0 ? "Available" : "Unavailable");
                stmt.setInt(paramIndex, book.getId());
                
                int bookRowsAffected = stmt.executeUpdate();
                
                if (bookRowsAffected > 0) {
                    // Update Book_Author table
                    // First delete existing relationship
                    String deleteAuthorSql = "DELETE FROM Book_Author WHERE book_ID = ?";
                    try (PreparedStatement deleteStmt = conn.prepareStatement(deleteAuthorSql)) {
                        deleteStmt.setInt(1, book.getId());
                        deleteStmt.executeUpdate();
                    }
                    
                    // Insert new relationship
                    String insertAuthorSql = "INSERT INTO Book_Author (book_ID, author_ID) VALUES (?, ?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertAuthorSql)) {
                        insertStmt.setInt(1, book.getId());
                        insertStmt.setInt(2, book.getAuthorId());
                        insertStmt.executeUpdate();
                    }
                    
                    conn.commit();
                    return true;
                }
            }
            
            conn.rollback();
            return false;
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Deletes a book from the database
     * 
     * @param bookId the ID of the book to delete
     * @return true if the book was successfully deleted, false otherwise
     */
    public boolean deleteBook(int bookId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        System.out.println("BookDAO.deleteBook: Attempting to delete book ID " + bookId);
        
        try {
            conn = DBConnection.getConnection();
            System.out.println("BookDAO.deleteBook: Database connection established");
            
            // First check if the book is currently borrowed
            String checkBorrowedQuery = "SELECT COUNT(*) FROM Fine WHERE book_ID = ? AND return_date IS NULL";
            System.out.println("BookDAO.deleteBook: Checking if book is borrowed with query: " + checkBorrowedQuery);
            stmt = conn.prepareStatement(checkBorrowedQuery);
            stmt.setInt(1, bookId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                int borrowCount = rs.getInt(1);
                System.out.println("BookDAO.deleteBook: Book borrow count: " + borrowCount);
                
                if (borrowCount > 0) {
                    System.out.println("BookDAO.deleteBook: Book is currently borrowed, cannot delete");
                    return false;
                }
            }
            
            // Close the first statement and result set
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            
            conn.setAutoCommit(false);
            System.out.println("BookDAO.deleteBook: Beginning transaction");
            
            try {
                // Thanks to ON DELETE CASCADE constraints in our schema, we can delete directly from the Book table
                // This will automatically delete related records in Book_Author and Fine tables
                
                String deleteBookSql = "DELETE FROM Book WHERE book_ID = ?";
                System.out.println("BookDAO.deleteBook: Deleting book with query: " + deleteBookSql);
                stmt = conn.prepareStatement(deleteBookSql);
                stmt.setInt(1, bookId);
                
                int rowsAffected = stmt.executeUpdate();
                System.out.println("BookDAO.deleteBook: Book rows affected: " + rowsAffected);
                
                conn.commit();
                System.out.println("BookDAO.deleteBook: Transaction committed");
                return rowsAffected > 0;
            } catch (SQLException e) {
                conn.rollback();
                System.out.println("BookDAO.deleteBook: Error in transaction, rolled back: " + e.getMessage());
                e.printStackTrace();
                return false;
            }
            
        } catch (SQLException e) {
            System.out.println("BookDAO.deleteBook: SQLException occurred: " + e.getMessage());
            try {
                if (conn != null) {
                    conn.rollback();
                    System.out.println("BookDAO.deleteBook: Transaction rolled back");
                }
            } catch (SQLException ex) {
                System.out.println("BookDAO.deleteBook: Error during rollback: " + ex.getMessage());
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                    System.out.println("BookDAO.deleteBook: Connection closed");
                }
            } catch (SQLException e) {
                System.out.println("BookDAO.deleteBook: Error closing resources: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    public Map<String, Integer> getBooksByCategory() throws SQLException {
        Map<String, Integer> categoryCount = new HashMap<>();
        String sql = "SELECT category, COUNT(*) as count FROM Book WHERE quantity > 0 GROUP BY category ORDER BY count DESC LIMIT 3";
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
        String sql = "SELECT SUM(quantity) as total FROM Book WHERE quantity > 0";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                int total = rs.getInt("total");
                return total > 0 ? total : 0; // Ensure we don't return a negative value
            }
        }
        return 0;
    }

    public List<Book> searchBooks(String query) throws SQLException {
        Map<Integer, Book> bookMap = new HashMap<>();
        String sql = "SELECT b.*, a.author_name FROM Book b " +
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
                    int bookId = rs.getInt("book_ID");
                    
                    // If we've already seen this book, just add the author
                    if (bookMap.containsKey(bookId)) {
                        Book existingBook = bookMap.get(bookId);
                        String authorName = rs.getString("author_name");
                        if (authorName != null) {
                            Author author = new Author();
                            author.setAuthorName(authorName);
                            existingBook.addAuthor(author);
                        }
                    } else {
                        // Otherwise create a new book
                        Book book = new Book();
                        book.setId(bookId);
                        book.setIsbn(rs.getString("isbn"));
                        book.setTitle(rs.getString("title"));
                        book.setCategory(rs.getString("category"));
                        book.setPublicationDate(rs.getDate("publication_date"));
                        book.setQuantity(rs.getInt("quantity"));
                        
                        // Handle image URL - just store the filename
                        String imageUrl = rs.getString("image_url");
                        if (imageUrl != null && imageUrl.startsWith("/uploads/books/")) {
                            book.setCoverImage(imageUrl.substring("/uploads/books/".length()));
                        } else {
                            book.setCoverImage(imageUrl);
                        }
                        
                        book.setAvailable(rs.getString("availability_status").equals("Available"));
                        
                        // Add author information if available
                        String authorName = rs.getString("author_name");
                        if (authorName != null) {
                            Author author = new Author();
                            author.setAuthorName(authorName);
                            book.addAuthor(author);
                        }
                        
                        bookMap.put(bookId, book);
                    }
                }
            }
        }
        return new ArrayList<>(bookMap.values());
    }
} 