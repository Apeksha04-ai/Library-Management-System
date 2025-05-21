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

/**
 * Servlet to handle user profile updates
 */
@WebServlet("/updateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
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

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Get updated user information from form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Basic validation
        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Name and email are required!");
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }

        try {
            // Check if email is being changed and if it's already in use
            if (!email.equals(currentUser.getEmail())) {
                if (userDAO.emailExists(email)) {
                    request.setAttribute("errorMessage", "Email address is already in use!");
                    request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
                    return;
                }
            }

            // Update the user object
            currentUser.setName(name);
            currentUser.setEmail(email);
            currentUser.setPhone(phone);

            // Update in database
            boolean updated = userDAO.updateUser(currentUser);

            if (updated) {
                // Update session attribute with updated user
                session.setAttribute("user", currentUser);
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            }

            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
        }
    }
} 