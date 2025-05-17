package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.PasswordUtil;

/**
 * Servlet to handle password changes
 */
@WebServlet("/changePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        System.out.println("Password change request received");
        
        // Check if user is logged in
        if (currentUser == null) {
            System.out.println("No user found in session");
            session.setAttribute("errorMessage", "Your session has expired. Please log in again to change your password.");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        System.out.println("Processing password change for user ID: " + currentUser.getUserID());
        
        // Get password information
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            System.out.println("Missing required password fields");
            session.setAttribute("errorMessage", "Please fill in all password fields to complete the password change.");
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
            return;
        }
        
        // Verify current password
        System.out.println("Verifying current password");
        if (!PasswordUtil.checkPassword(currentPassword, currentUser.getPassword())) {
            System.out.println("Current password verification failed");
            session.setAttribute("errorMessage", "The current password you entered is incorrect. Please try again.");
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
            return;
        }
        
        // Check if new passwords match
        if (!newPassword.equals(confirmPassword)) {
            System.out.println("New passwords do not match");
            session.setAttribute("errorMessage", "The new passwords you entered don't match. Please make sure they are identical.");
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
            return;
        }
        
        // Check password strength
        if (newPassword.length() < 8) {
            System.out.println("New password is too short");
            session.setAttribute("errorMessage", "Your new password must be at least 8 characters long for security purposes.");
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
            return;
        }
        
        // Check if new password is same as current password
        if (PasswordUtil.checkPassword(newPassword, currentUser.getPassword())) {
            System.out.println("New password is same as current password");
            session.setAttribute("errorMessage", "Your new password must be different from your current password.");
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
            return;
        }
        
        // Hash the new password
        System.out.println("Hashing new password");
        String hashedPassword = PasswordUtil.hashPassword(newPassword);
        
        // Update user password
        currentUser.setPassword(hashedPassword);
        
        // Update in database
        System.out.println("Attempting to update password in database");
        boolean success = userDAO.updateUserPassword(currentUser.getUserID(), hashedPassword);
        
        if (success) {
            System.out.println("Password updated successfully");
            // Update session with updated user
            session.setAttribute("user", currentUser);
            session.setAttribute("successMessage", "Your password has been successfully updated! Please use your new password the next time you log in.");
        } else {
            System.out.println("Failed to update password in database");
            session.setAttribute("errorMessage", "We encountered a technical issue while updating your password. Please try again later or contact support if the problem persists.");
        }
        
        // Redirect back to profile page
        response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
    }
} 