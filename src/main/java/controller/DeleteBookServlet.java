package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.DBConnection;

@WebServlet("/librarian/delete-book")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle GET requests by delegating to doPost
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests by delegating to the common method
        processRequest(request, response);
    }
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("DeleteBookServlet: method called");
        
        // Get the current session, creating one if needed
        HttpSession session = SessionUtil.getOrCreateSession(request);
        
        // Check if user is logged in and is a librarian
        User user = SessionUtil.getLoggedInUser(request);
        System.out.println("DeleteBookServlet: user is null? " + (user == null));
        
        if (user == null) {
            System.out.println("DeleteBookServlet: User not logged in, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        System.out.println("DeleteBookServlet: User role is: " + user.getRole());
        if (!user.getRole().equalsIgnoreCase("librarian")) {
            System.out.println("DeleteBookServlet: User is not a librarian, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        System.out.println("DeleteBookServlet: User is logged in as: " + user.getEmail());
        
        try {
            // Get book ID from request parameter (could be from GET or POST)
            String bookIdParam = request.getParameter("id");
            if (bookIdParam == null) {
                // Try the bookId parameter name as well
                bookIdParam = request.getParameter("bookId");
            }
            
            System.out.println("DeleteBookServlet: bookId parameter = " + bookIdParam);
            
            if (bookIdParam == null || bookIdParam.trim().isEmpty()) {
                session.setAttribute("errorMessage", "No book ID provided");
                // Forward to the ViewBooksServlet instead of redirecting to the JSP
                System.out.println("DeleteBookServlet: No book ID provided, forwarding to ViewBooksServlet");
                request.getRequestDispatcher("/librarian/view-books").forward(request, response);
                return;
            }
            
            int bookId = Integer.parseInt(bookIdParam);
            System.out.println("DeleteBookServlet: Parsed book ID = " + bookId + " (type: int)");
            
            // Delete the book
            boolean success = bookDAO.deleteBook(bookId);
            System.out.println("DeleteBookServlet: deleteBook result = " + success);
            
            if (success) {
                session.setAttribute("successMessage", "Book deleted successfully!");
            } else {
                // Check if the book is currently borrowed
                try {
                    String sql = "SELECT COUNT(*) FROM Fine WHERE book_ID = ? AND return_date IS NULL";
                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setInt(1, bookId);
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next() && rs.getInt(1) > 0) {
                                session.setAttribute("errorMessage", "Cannot delete book because it is currently borrowed. Please ensure all copies are returned first.");
                            } else {
                                session.setAttribute("errorMessage", "Failed to delete book. There might be a database constraint or issue.");
                            }
                        }
                    }
                } catch (SQLException e) {
                    System.out.println("DeleteBookServlet: Error checking if book is borrowed: " + e.getMessage());
                    session.setAttribute("errorMessage", "Failed to delete book: " + e.getMessage());
                }
            }
            
        } catch (NumberFormatException e) {
            System.out.println("DeleteBookServlet: NumberFormatException - " + e.getMessage());
            session.setAttribute("errorMessage", "Invalid book ID format");
        } catch (Exception e) {
            System.out.println("DeleteBookServlet: Exception - " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error deleting book: " + e.getMessage());
        }
        
        // Forward to the ViewBooksServlet instead of redirecting to the JSP
        System.out.println("DeleteBookServlet: Operation complete, forwarding to ViewBooksServlet");
        request.getRequestDispatcher("/librarian/view-books").forward(request, response);
    }
} 