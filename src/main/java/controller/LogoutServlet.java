package controller;

import java.io.IOException;
import java.util.Date;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.SessionUtil;

/**
 * Servlet to handle user logout
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

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
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Record session duration
            Date loginTime = (Date) session.getAttribute("loginTime");
            if (loginTime != null) {
                long sessionDuration = System.currentTimeMillis() - loginTime.getTime();

                // Log the session duration (could be saved to database if needed)
                System.out.println("User session duration: " + (sessionDuration / 1000) + " seconds");

                // Update last active time in database for the user
                User user = SessionUtil.getLoggedInUser(request);
                if (user != null) {
                    userDAO.updateLastActivity(user.getUserID(), new Date());
                }
            }

            // Add logout timestamp to audit log if needed
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail != null) {
                System.out.println("User logged out: " + userEmail + " at " + new Date());
                // Could add to database log here
            }

            // Clear session attributes
            session.removeAttribute("user");
            session.removeAttribute("userID");
            session.removeAttribute("userEmail");
            session.removeAttribute("userRole");
            session.removeAttribute("loginTime");
            session.removeAttribute("lastActivityTime");

            // Invalidate session
            session.invalidate();
        }

        // Clear remember me cookies
        SessionUtil.clearRememberMeCookies(response);

        // Add logout message to a temporary session
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("logoutMessage", "You have been successfully logged out.");
        newSession.setMaxInactiveInterval(60); // Message will be available for 60 seconds

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    }
}