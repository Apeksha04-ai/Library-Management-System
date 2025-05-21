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

@WebServlet("/librarian/return-history")
public class ReturnHistoryServlet extends HttpServlet {
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
        System.out.println("ReturnHistoryServlet: method called");
        
        // Get the current session, creating one if needed
        HttpSession session = SessionUtil.getOrCreateSession(request);
        
        // Check if user is logged in and is a librarian
        User user = SessionUtil.getLoggedInUser(request);
        System.out.println("ReturnHistoryServlet: user is null? " + (user == null));
        
        if (user == null) {
            System.out.println("ReturnHistoryServlet: User not logged in, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        System.out.println("ReturnHistoryServlet: User role is: " + user.getRole());
        if (!user.getRole().equalsIgnoreCase("librarian")) {
            System.out.println("ReturnHistoryServlet: User is not a librarian, redirecting to access denied page");
            response.sendRedirect(request.getContextPath() + "/views/accessDenied.jsp");
            return;
        }
        
        try {
            // Get return history (all returned books)
            List<Borrow> returnHistory = borrowDAO.getReturnHistory();
            System.out.println("ReturnHistoryServlet: Retrieved " + returnHistory.size() + " return records");
            
            // Set the return history in the request
            request.setAttribute("returnHistory", returnHistory);
            
            // Forward to the JSP
            request.getRequestDispatcher("/views/librarian/return-history.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.out.println("ReturnHistoryServlet: Error retrieving return history - " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error retrieving return history: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/librarian/dashboard.jsp");
        }
    }
} 