package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.util.List;
import dao.AuthorDAO;
import model.Author;

@WebServlet("/librarian/author")
public class AuthorServlet extends HttpServlet {
    private AuthorDAO authorDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        authorDAO = new AuthorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Author> authors = authorDAO.getAllAuthors();
            request.setAttribute("authors", authors);
            request.getRequestDispatcher("/views/librarian/author.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in AuthorServlet.doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading authors: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            // Get form data
            String authorName = request.getParameter("authorName");
            String birthDateStr = request.getParameter("birthDate");
            String nationality = request.getParameter("nationality");
            String awards = request.getParameter("awards");
            String biography = request.getParameter("biography");

            // Validate required fields
            if (authorName == null || authorName.trim().isEmpty()) {
                out.write("{\"success\": false, \"message\": \"Author name is required\"}");
                return;
            }

            // Create Author object
            Author author = new Author();
            author.setAuthorName(authorName.trim());
            
            // Parse and set birth date if provided
            if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
                try {
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date birthDate = sdf.parse(birthDateStr);
                    author.setBirthDate(birthDate);
                } catch (Exception e) {
                    out.write("{\"success\": false, \"message\": \"Invalid birth date format\"}");
                    return;
                }
            }
            
            author.setNationality(nationality);
            author.setAwards(awards);
            author.setBiography(biography);

            // Save author to database
            if (authorDAO.addAuthor(author)) {
                out.write("{\"success\": true, \"message\": \"Author added successfully\", \"authorId\": " + author.getId() + "}");
            } else {
                out.write("{\"success\": false, \"message\": \"Failed to add author\"}");
            }
        } catch (Exception e) {
            System.err.println("Error in AuthorServlet.doPost: " + e.getMessage());
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Error adding author: " + e.getMessage() + "\"}");
        }
    }
} 