package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.User;
import util.PasswordUtil;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 * Servlet to handle user registration
 */
@WebServlet("/registerServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1 MB
    maxFileSize = 5 * 1024 * 1024,    // 5 MB
    maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    private String uploadDir;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        uploadDir = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "profiles";
        
        // Create upload directory if it doesn't exist
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to registration page
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get registration parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");
        
        // Validate input
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {
            
            request.setAttribute("error", "All required fields must be filled");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Handle profile picture upload
        String imageUrl = null;
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = email.replace("@", "_at_") + "_" + System.currentTimeMillis() + getFileExtension(filePart);
            Path filePath = Paths.get(uploadDir, fileName);
            
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
                imageUrl = "uploads/profiles/" + fileName;
            } catch (Exception e) {
                request.setAttribute("error", "Error uploading profile picture: " + e.getMessage());
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                return;
            }
        }
        
        // Create user object
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setRole(role);
        user.setPhone(phone);
        user.setImageUrl(imageUrl);
        
        // Add user to database
        boolean success = userDAO.addUser(user);
        
        if (success) {
            // Registration successful - instead of auto-login, set a success message and redirect to login
            request.getSession().setAttribute("registrationSuccess", "Registration successful. Please log in with your credentials.");
            
            // Redirect to login page
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        } else {
            // Registration failed
            request.setAttribute("error", "Error registering user. Please try again.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
    
    /**
     * Get file extension from Part
     */
    private String getFileExtension(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                int lastDot = fileName.lastIndexOf('.');
                if (lastDot > 0) {
                    return fileName.substring(lastDot);
                }
                break;
            }
        }
        return ".jpg"; // Default extension
    }
} 