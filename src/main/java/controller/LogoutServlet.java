package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.SessionUtil;

import java.io.IOException;

/**
 * Servlet to handle user logout
 */
@WebServlet("/logoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        performLogout(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        performLogout(request, response);
    }
    
    /**
     * Perform logout operations
     */
    private void performLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        // Clear session
        SessionUtil.invalidateUserSession(request);
        
        // Clear remember me cookies
        SessionUtil.clearRememberMeCookies(request, response);
        
        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    }
} 