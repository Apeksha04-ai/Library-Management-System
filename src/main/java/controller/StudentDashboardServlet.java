package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import dao.BorrowDAO;
import dao.FineDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Borrow;
import model.User;
import util.SessionUtil;

@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BorrowDAO borrowDAO;
    private FineDAO fineDAO;
    
    @Override
    public void init() throws ServletException {
        borrowDAO = new BorrowDAO();
        fineDAO = new FineDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("StudentDashboardServlet: method called");
        
        // Get logged in user
        User user = SessionUtil.getLoggedInUser(request);
        
        if (user == null) {
            System.out.println("StudentDashboardServlet: User not logged in, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        if (!user.getRole().equalsIgnoreCase("student")) {
            System.out.println("StudentDashboardServlet: User is not a student, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        try {
            int userId = user.getUserID();
            
            // Get currently borrowed books count
            List<Borrow> activeBooks = borrowDAO.getActiveBorrowsByUserId(userId);
            request.setAttribute("currentlyBorrowed", activeBooks.size());
            
            // Count overdue books
            Date today = new Date();
            int overdueCount = 0;
            for (Borrow borrow : activeBooks) {
                if (borrow.getDueDate() != null && borrow.getDueDate().before(today)) {
                    overdueCount++;
                }
            }
            request.setAttribute("overdueBooks", overdueCount);
            
            // Get total borrowed books count (current + history)
            // This is a placeholder - you might need to implement a method in BorrowDAO
            // to get the total count of borrowed books by a user
            List<Borrow> allBorrows = borrowDAO.getBorrowsByUserId(userId);
            request.setAttribute("totalBorrowed", allBorrows.size());
            
            // Get outstanding fines
            BigDecimal outstandingFines = fineDAO.getOutstandingFines(userId);
            request.setAttribute("outstandingFines", outstandingFines != null ? outstandingFines : BigDecimal.ZERO);
            
            // Get recent activities (last few borrows/returns)
            List<Borrow> recentActivity = borrowDAO.getRecentBorrowsByUserId(userId, 5);
            request.setAttribute("recentActivity", recentActivity);
            
            // Add user to request (in case it's not already in the session)
            request.setAttribute("user", user);
            
            // Forward to the JSP
            request.getRequestDispatcher("/views/student/dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.out.println("StudentDashboardServlet: SQLException - " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error loading dashboard data: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        } catch (Exception e) {
            System.out.println("StudentDashboardServlet: Exception - " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error loading dashboard: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        }
    }
} 