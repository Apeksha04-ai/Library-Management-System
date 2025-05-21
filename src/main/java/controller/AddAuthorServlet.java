package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.text.SimpleDateFormat;
import java.util.Date;
import dao.AuthorDAO;

@WebServlet(name = "AddAuthorServlet", urlPatterns = {"/librarian/add-author"})
public class AddAuthorServlet extends HttpServlet {
    private AuthorDAO authorDAO;
    
    public void init() {
        authorDAO = new AuthorDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get form data
            String authorName = request.getParameter("authorName");
            String birthDateStr = request.getParameter("birthDate");
            String nationality = request.getParameter("nationality");
            String awards = request.getParameter("awards");
            String biography = request.getParameter("biography");

            // Validate required fields
            if (authorName == null || authorName.trim().isEmpty()) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Author name is required\"}");
                return;
            }

            // Create Author object
            Author author = new Author();
            author.setAuthorName(authorName.trim());
            
            // Parse and set birth date if provided
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date birthDate = sdf.parse(birthDateStr);
                author.setBirthDate(birthDate);
            }
            
            // Set optional fields
            author.setNationality(nationality != null ? nationality.trim() : null);
            author.setAwards(awards != null ? awards.trim() : null);
            author.setBiography(biography != null ? biography.trim() : null);
            
            // Save author to database
            if (authorDAO.addAuthor(author)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Author added successfully\", \"authorId\": " + author.getId() + "}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to add author\"}");
            }
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
} 