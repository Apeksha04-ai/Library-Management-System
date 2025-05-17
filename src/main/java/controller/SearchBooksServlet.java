package controller;

import java.io.IOException;
import java.util.List;

import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Book;
import model.User;
import util.SessionUtil;

@WebServlet("/student/search-books")
public class SearchBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = SessionUtil.getLoggedInUser(request);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        String query = request.getParameter("query");
        String category = request.getParameter("category");
        String availability = request.getParameter("availability");
        List<Book> books;
        
        try {
            if (query != null && !query.trim().isEmpty()) {
                books = bookDAO.searchBooks(query);
                request.setAttribute("searchQuery", query);
            } else {
                books = bookDAO.getAllBooks();
            }
            
            // Filter by category if specified
            if (category != null && !category.equals("all")) {
                books.removeIf(book -> !book.getCategory().equalsIgnoreCase(category));
            }
            
            // Filter by availability if specified
            if ("available".equals(availability)) {
                books.removeIf(book -> !book.isAvailable());
            }
            
            request.setAttribute("books", books);
            request.setAttribute("user", user);
            request.setAttribute("selectedCategory", category);
            request.setAttribute("selectedAvailability", availability);
            
            request.getRequestDispatcher("/views/student/search-books.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error searching books: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/student/search-books.jsp");
        }
    }
} 