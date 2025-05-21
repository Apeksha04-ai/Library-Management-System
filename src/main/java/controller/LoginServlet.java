package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.PasswordUtil;


/**
 * Servlet to handle user login
 */
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is already logged in
        if (SessionUtil.isLoggedIn(request)) {
            // Redirect to appropriate dashboard based on role
            redirectToDashboard(request, response, SessionUtil.getLoggedInUser(request));
            return;
        }
        
        // Handle remember me auto-login
        String rememberMe = SessionUtil.getCookieValue(request, SessionUtil.REMEMBER_ME_COOKIE);
        String email = SessionUtil.getCookieValue(request, SessionUtil.USER_EMAIL_COOKIE);
        
        if (rememberMe != null && email != null) {
            User user = userDAO.getUserByEmail(email);
            if (user != null) {
                // Auto-login successful
                SessionUtil.createUserSession(request, user);
                redirectToDashboard(request, response, user);
                return;
            }
        }
        
        // Forward to login page if not logged in
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get login parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean rememberMe = "on".equals(request.getParameter("rememberMe"));
        
        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        // Get user by email
        User user = userDAO.getUserByEmail(email);
        
        // Verify password if user exists
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            // Login successful, create session
            SessionUtil.createUserSession(request, user);
            
            // Update last login time
            userDAO.updateLastLogin(user.getUserID());
            
            // Set remember me cookie if requested
            if (rememberMe) {
                SessionUtil.setRememberMeCookie(response, user, true);
            }
            
            // Redirect to appropriate dashboard
            redirectToDashboard(request, response, user);
        } else {
            // Login failed
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
    
    /**
     * Redirect to appropriate dashboard based on user role
     */
    private void redirectToDashboard(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        String contextPath = request.getContextPath();
        
        if ("Librarian".equals(user.getRole())) {
            response.sendRedirect(contextPath + "/librarian/dashboard");
        } else if ("Student".equals(user.getRole())) {
            response.sendRedirect(contextPath + "/student/dashboard");
        } else {
            // Default fallback
            response.sendRedirect(contextPath + "/views/login.jsp");
        }
    }
} 