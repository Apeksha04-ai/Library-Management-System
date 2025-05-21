package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import dao.BorrowDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/librarian/return-book")
public class ReturnBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BorrowDAO borrowDAO;
    
    @Override
    public void init() throws ServletException {
        borrowDAO = new BorrowDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ReturnBookServlet: method called");
        
        // Get the current session, creating one if needed
        HttpSession session = SessionUtil.getOrCreateSession(request);
        
        // Check if user is logged in and is a librarian
        User user = SessionUtil.getLoggedInUser(request);
        System.out.println("ReturnBookServlet: user is null? " + (user == null));
        
        if (user == null) {
            System.out.println("ReturnBookServlet: User not logged in, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        System.out.println("ReturnBookServlet: User role is: " + user.getRole());
        if (!user.getRole().equalsIgnoreCase("librarian")) {
            System.out.println("ReturnBookServlet: User is not a librarian, redirecting to login page");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        try {
            // Get parameters
            String borrowIdParam = request.getParameter("borrowId");
            String returnDateParam = request.getParameter("returnDate");
            String fineAmountParam = request.getParameter("fineAmount");
            
            System.out.println("ReturnBookServlet: borrowId=" + borrowIdParam + ", returnDate=" + returnDateParam + ", fineAmount=" + fineAmountParam);
            
            if (borrowIdParam == null || borrowIdParam.trim().isEmpty()) {
                session.setAttribute("errorMessage", "No borrow ID provided");
                response.sendRedirect(request.getContextPath() + "/librarian/borrowed-books");
                return;
            }
            
            // Parse parameters
            int borrowId = Integer.parseInt(borrowIdParam);
            
            // Parse return date
            Date returnDate = null;
            if (returnDateParam != null && !returnDateParam.trim().isEmpty()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                returnDate = dateFormat.parse(returnDateParam);
            } else {
                returnDate = new Date(); // Current date if not provided
            }
            
            // Parse fine amount
            BigDecimal fineAmount = BigDecimal.ZERO;
            if (fineAmountParam != null && !fineAmountParam.trim().isEmpty()) {
                fineAmount = new BigDecimal(fineAmountParam);
            }
            
            // Update return date and fine amount
            boolean success = borrowDAO.returnBook(borrowId, returnDate, fineAmount);
            
            if (success) {
                session.setAttribute("successMessage", "Book returned successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to return book. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("ReturnBookServlet: NumberFormatException - " + e.getMessage());
            session.setAttribute("errorMessage", "Invalid ID format: " + e.getMessage());
        } catch (ParseException e) {
            System.out.println("ReturnBookServlet: ParseException - " + e.getMessage());
            session.setAttribute("errorMessage", "Invalid date format: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("ReturnBookServlet: SQLException - " + e.getMessage());
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("ReturnBookServlet: Exception - " + e.getMessage());
            session.setAttribute("errorMessage", "Error returning book: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Redirect to borrowed books page
        response.sendRedirect(request.getContextPath() + "/librarian/borrowed-books");
    }
} 