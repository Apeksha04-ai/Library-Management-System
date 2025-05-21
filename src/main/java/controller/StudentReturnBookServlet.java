package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

import dao.BorrowDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.SessionUtil;

@WebServlet("/student/return-book")
public class StudentReturnBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BorrowDAO borrowDAO;
    
    @Override
    public void init() throws ServletException {
        borrowDAO = new BorrowDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = SessionUtil.getLoggedInUser(request);
        
        if (user == null) {
            session.setAttribute("error", "Please log in to return books");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        try {
            // Get the borrow ID from the request
            String borrowIdParam = request.getParameter("borrowId");
            System.out.println("StudentReturnBookServlet: Processing return for borrowId=" + borrowIdParam);
            
            if (borrowIdParam == null || borrowIdParam.isEmpty()) {
                session.setAttribute("error", "Invalid request: No borrow ID provided");
                response.sendRedirect(request.getContextPath() + "/student/my-books");
                return;
            }
            
            int borrowId = Integer.parseInt(borrowIdParam);
            
            // Return the book with current date and no fine (librarian will handle fines)
            Date returnDate = new Date();
            boolean success = borrowDAO.returnBook(borrowId, returnDate, BigDecimal.ZERO);
            
            if (success) {
                session.setAttribute("success", "Book returned successfully. Thank you!");
            } else {
                session.setAttribute("error", "Failed to return book. Please try again or contact a librarian.");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("StudentReturnBookServlet: NumberFormatException - " + e.getMessage());
            session.setAttribute("error", "Invalid borrow ID format");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("StudentReturnBookServlet: Exception - " + e.getMessage());
            session.setAttribute("error", "Error returning book: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Redirect back to my-books page
        response.sendRedirect(request.getContextPath() + "/student/my-books");
    }
} 