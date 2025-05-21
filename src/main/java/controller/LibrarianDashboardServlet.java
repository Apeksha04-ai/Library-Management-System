package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import dao.BookDAO;
import dao.BorrowDAO;
import dao.FineDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/librarian/dashboard")
public class LibrarianDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private BorrowDAO borrowDAO;
    private FineDAO fineDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        borrowDAO = new BorrowDAO();
        fineDAO = new FineDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("LibrarianDashboardServlet: method called");
        
        // Get the current session, creating one if needed
        HttpSession session = SessionUtil.getOrCreateSession(request);
        
        // Check if user is logged in and is a librarian
        User user = SessionUtil.getLoggedInUser(request);
        System.out.println("LibrarianDashboardServlet: user is null? " + (user == null));
        
        if (user == null) {
            System.out.println("LibrarianDashboardServlet: User not logged in, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        System.out.println("LibrarianDashboardServlet: User role is: " + user.getRole());
        if (!user.getRole().equalsIgnoreCase("librarian")) {
            System.out.println("LibrarianDashboardServlet: User is not a librarian, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        try {
            // 1. Get total books
            int totalBooks = bookDAO.getTotalBooks();
            System.out.println("LibrarianDashboardServlet: Total books from database: " + totalBooks);
            request.setAttribute("totalBooks", totalBooks);
            
            // 2. Get active borrowings count
            List<Borrow> activeBorrows = borrowDAO.getActiveBorrows();
            int activeBorrowingsCount = activeBorrows.size();
            System.out.println("LibrarianDashboardServlet: Active borrowings count: " + activeBorrowingsCount);
            request.setAttribute("activeBorrowingsCount", activeBorrowingsCount);
            
            // 3. Get overdue books count
            int overdueCount = 0;
            Date today = new Date();

            try {
                // Use the dedicated method to retrieve overdue books
                List<Borrow> overdueBooks = borrowDAO.getOverdueBooks();
                overdueCount = overdueBooks.size();

                // Log the details of each overdue book for debugging
                for (Borrow borrow : overdueBooks) {
                    System.out.println("LibrarianDashboardServlet: Found overdue book: " + borrow.getBook().getTitle() + 
                                      ", Due Date: " + borrow.getDueDate() + ", Today: " + today);
                }
            } catch (SQLException e) {
                System.out.println("LibrarianDashboardServlet: Error getting overdue books - " + e.getMessage());
                e.printStackTrace();
                
                // Fallback to the previous method if the new one fails
                for (Borrow borrow : activeBorrows) {
                    if (borrow.getDueDate() != null && borrow.getDueDate().before(today)) {
                        overdueCount++;
                        System.out.println("LibrarianDashboardServlet: Found overdue book: " + borrow.getBook().getTitle() + 
                                          ", Due Date: " + borrow.getDueDate() + ", Today: " + today);
                    }
                }
            }
            
            System.out.println("LibrarianDashboardServlet: Overdue books count: " + overdueCount);
            request.setAttribute("overdueCount", overdueCount);
            
            // 4. Get total fines
            BigDecimal totalFines = fineDAO.getTotalFines();
            System.out.println("LibrarianDashboardServlet: Total fines: " + totalFines);
            request.setAttribute("totalFines", totalFines);
            
            // 5. Get book categories
            Map<String, Integer> categoryData = bookDAO.getBooksByCategory();
            request.setAttribute("categoryData", categoryData);
            
            // 6. Get recent activities (borrowings and returns)
            List<Borrow> recentActivity = borrowDAO.getRecentActivity(5); // Get last 5 activities
            request.setAttribute("recentActivity", recentActivity);
            
            // 7. Set the user's name
            request.setAttribute("userName", user.getName());
            
            // Forward to the dashboard JSP
            request.getRequestDispatcher("/views/librarian/dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.out.println("LibrarianDashboardServlet: SQLException - " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error loading dashboard data: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        }
    }
} 