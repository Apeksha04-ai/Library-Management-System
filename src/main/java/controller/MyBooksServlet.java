package controller;

import java.io.IOException;
import java.util.List;

import dao.BorrowDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/student/my-books")
public class MyBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BorrowDAO borrowDAO;
    
    @Override
    public void init() throws ServletException {
        borrowDAO = new BorrowDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User user = SessionUtil.getLoggedInUser(request);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        try {
            // Get active (not returned) borrows for the user
            List<Borrow> activeBooks = borrowDAO.getActiveBorrowsByUserId(user.getUserID());
            request.setAttribute("activeBooks", activeBooks);
            
            // Forward to the JSP page
            request.getRequestDispatcher("/views/student/my-books.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error loading your borrowed books: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/student/dashboard.jsp");
        }
    }
} 