package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

@WebServlet("/librarian/edit-book")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1 MB
    maxFileSize = 5 * 1024 * 1024,    // 5 MB
    maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class EditBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private AuthorDAO authorDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        authorDAO = new AuthorDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get book ID from request parameter
            String bookId = request.getParameter("id");
            if (bookId != null && !bookId.trim().isEmpty()) {
                // Get book details from database
                Book book = bookDAO.getBookById(Integer.parseInt(bookId));
                if (book != null) {
                    // Get all authors for the dropdown
                    List<Author> authors = authorDAO.getAllAuthors();
                    request.setAttribute("authors", authors);
                    request.setAttribute("book", book);
                    request.getRequestDispatcher("/views/librarian/edit-books.jsp").forward(request, response);
                    return;
                }
            }
            // If book not found or no ID provided, redirect to view books
            response.sendRedirect(request.getContextPath() + "/views/librarian/view-books.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving book details: " + e.getMessage());
            request.getRequestDispatcher("/views/librarian/view-books.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get book details from form
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String isbn = request.getParameter("isbn");
            String title = request.getParameter("title");
            int authorId = Integer.parseInt(request.getParameter("authorId"));
            String category = request.getParameter("category");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            // Parse publication date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date publicationDate = null;
            try {
                publicationDate = dateFormat.parse(request.getParameter("publicationDate"));
            } catch (ParseException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Invalid date format");
                response.sendRedirect(request.getContextPath() + "/views/librarian/edit-books.jsp?id=" + bookId);
                return;
            }
            
            // Handle cover image upload
            Part filePart = request.getPart("coverImage");
            String coverImage = null;
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getSubmittedFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Generate unique filename
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    String uploadPath = getServletContext().getRealPath("") + "uploads/books/";
                    
                    // Create directory if it doesn't exist
                    java.io.File uploadDir = new java.io.File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    // Save file
                    filePart.write(uploadPath + uniqueFileName);
                    coverImage = uniqueFileName;
                }
            }
            
            // Create book object
            Book book = new Book();
            book.setId(bookId);
            book.setIsbn(isbn);
            book.setTitle(title);
            book.setAuthorId(authorId);
            book.setCategory(category);
            book.setQuantity(quantity);
            book.setPublicationDate(publicationDate);
            if (coverImage != null) {
                book.setCoverImage(coverImage);
            }
            
            // Update book in database
            boolean success = bookDAO.updateBook(book);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Book updated successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update book. Please try again.");
            }
            
            // Redirect back to view books page
            response.sendRedirect(request.getContextPath() + "/views/librarian/view-books.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error updating book: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/librarian/view-books.jsp");
        }
    }
    
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }
} 