package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dao.AuthorDAO;
import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Author;
import model.Book;

@WebServlet("/librarian/add-book")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,   // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class AddBookServlet extends HttpServlet {
    private BookDAO bookDAO;
    private AuthorDAO authorDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        bookDAO = new BookDAO();
        authorDAO = new AuthorDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get authors list
            List<Author> authors = authorDAO.getAllAuthors();
            
            // Debug information
            System.out.println("Number of authors fetched: " + authors.size());
            for (Author author : authors) {
                System.out.println("Author ID: " + author.getId() + ", Name: " + author.getAuthorName());
            }
            
            // Set authors in request scope
            request.setAttribute("authors", authors);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/librarian/add-books.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.err.println("Database error while fetching authors: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message in request
            request.setAttribute("errorMessage", "Failed to load authors. Please try again later.");
            request.setAttribute("authors", new ArrayList<Author>()); // Empty list to avoid null pointer
            
            // Forward to JSP with error
            request.getRequestDispatcher("/views/librarian/add-books.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            // Get form data
            String isbn = request.getParameter("isbn");
            String title = request.getParameter("title");
            String authorIdStr = request.getParameter("authorId");
            String category = request.getParameter("category");
            String publicationDateStr = request.getParameter("publicationDate");
            String quantityStr = request.getParameter("quantity");

            // Validate required fields
            if (isbn == null || isbn.trim().isEmpty() ||
                title == null || title.trim().isEmpty() ||
                authorIdStr == null || authorIdStr.trim().isEmpty() ||
                category == null || category.trim().isEmpty() ||
                publicationDateStr == null || publicationDateStr.trim().isEmpty() ||
                quantityStr == null || quantityStr.trim().isEmpty()) {
                    out.write("{\"success\": false, \"message\": \"All required fields must be filled\"}");
                    return;
            }

            // Parse numeric values
            int authorId = Integer.parseInt(authorIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            // Validate author exists
            Author author = authorDAO.getAuthorById(authorId);
            if (author == null) {
                out.write("{\"success\": false, \"message\": \"Selected author does not exist\"}");
                return;
            }
            
            // Handle file upload
            Part filePart = request.getPart("bookImage");
            String fileName = "";
            if (filePart != null && filePart.getSize() > 0) {
                fileName = processFileUpload(filePart, request);
            }
            
            // Create Book object
            Book book = new Book();
            book.setIsbn(isbn.trim());
            book.setTitle(title.trim());
            book.setAuthorId(authorId);
            book.setCategory(category);
            
            // Parse and set publication date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date publicationDate = sdf.parse(publicationDateStr);
            book.setPublicationDate(publicationDate);
            
            book.setQuantity(quantity);
            book.setCoverImage(fileName);
            book.setAvailable(quantity > 0);
            
            // Save book to database
            if (bookDAO.addBook(book)) {
                out.write("{\"success\": true, \"message\": \"Book added successfully\"}");
            } else {
                out.write("{\"success\": false, \"message\": \"Failed to add book\"}");
            }
            
        } catch (NumberFormatException e) {
            out.write("{\"success\": false, \"message\": \"Invalid number format for Author ID or Quantity\"}");
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
    
    private String processFileUpload(Part filePart, HttpServletRequest request) throws IOException {
        String fileName = System.currentTimeMillis() + "_" + getSubmittedFileName(filePart);
        
        // Create the base uploads directory if it doesn't exist
        String baseUploadPath = request.getServletContext().getRealPath("/uploads");
        File baseUploadDir = new File(baseUploadPath);
        if (!baseUploadDir.exists()) {
            baseUploadDir.mkdirs();
        }
        
        // Create the books subdirectory if it doesn't exist
        String booksUploadPath = baseUploadPath + File.separator + "books";
        File booksUploadDir = new File(booksUploadPath);
        if (!booksUploadDir.exists()) {
            booksUploadDir.mkdirs();
        }
        
        // Save the file
        String filePath = booksUploadPath + File.separator + fileName;
        filePart.write(filePath);
        
        // Return the relative path that will be stored in the database
        return fileName;
    }
    
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
} 