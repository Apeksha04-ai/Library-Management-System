package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.BorrowDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Borrow;
import model.User;
import util.SessionUtil;

@WebServlet("/librarian/borrowed-books")
public class BorrowedBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BorrowDAO borrowDAO;
    
    @Override
    public void init() throws ServletException {
        borrowDAO = new BorrowDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("BorrowedBooksServlet: method called");
        
        // Get the current session, creating one if needed
        HttpSession session = SessionUtil.getOrCreateSession(request);
        
        // Check if user is logged in and is a librarian
        User user = SessionUtil.getLoggedInUser(request);
        System.out.println("BorrowedBooksServlet: user is null? " + (user == null));
        
        if (user == null) {
            System.out.println("BorrowedBooksServlet: User not logged in, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        System.out.println("BorrowedBooksServlet: User role is: " + user.getRole());
        if (!user.getRole().equalsIgnoreCase("librarian")) {
            System.out.println("BorrowedBooksServlet: User is not a librarian, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        try {
            // Get all active borrows
            List<Borrow> activeBorrows = borrowDAO.getActiveBorrows();
            System.out.println("BorrowedBooksServlet: Retrieved " + activeBorrows.size() + " active borrows");
            
            // Set the borrows in the request
            request.setAttribute("borrows", activeBorrows);
            
            // Forward to the JSP
            request.getRequestDispatcher("/views/librarian/borrowed-books.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.out.println("BorrowedBooksServlet: Error retrieving borrows - " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error retrieving borrowed books: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/librarian/dashboard.jsp");
        }
    }
} 