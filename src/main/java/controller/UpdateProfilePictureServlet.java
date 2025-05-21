package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * Servlet to handle profile picture updates
 */
@WebServlet("/updateProfilePictureServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1 MB
    maxFileSize = 5 * 1024 * 1024,    // 5 MB
    maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class UpdateProfilePictureServlet extends HttpServlet {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        // Get the uploaded file
        Part filePart = request.getPart("profilePicture");
        
        // Check if a file was uploaded
        if (filePart == null || filePart.getSize() <= 0) {
            session.setAttribute("errorMessage", "No file was uploaded");
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
            return;
        }
        
        // Validate file type
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            session.setAttribute("errorMessage", "Only image files are allowed");
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
            return;
        }
        
        // Generate file name and path
        String fileName = currentUser.getEmail().replace("@", "_at_") + "_" + System.currentTimeMillis() + getFileExtension(filePart);
        Path filePath = Paths.get(uploadDir, fileName);
        
        // Save the file
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
            
            // Update image URL in user object
            String imageUrl = "uploads/profiles/" + fileName;
            currentUser.setImageUrl(imageUrl);
            
            // Update in database
            boolean success = userDAO.updateUserImage(currentUser.getUserID(), imageUrl);
            
            if (success) {
                // Update session with updated user
                session.setAttribute("user", currentUser);
                session.setAttribute("successMessage", "Profile picture updated successfully");
            } else {
                session.setAttribute("errorMessage", "Failed to update profile picture. Please try again.");
            }
            
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error uploading profile picture: " + e.getMessage());
        }
        
        // Redirect back to profile page
        response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
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