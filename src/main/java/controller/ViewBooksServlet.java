package controller;

import java.io.IOException;
import java.util.List;

import dao.AuthorDAO;
import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Author;
import model.Book;
import model.User;
import util.SessionUtil;

@WebServlet("/librarian/view-books")
public class ViewBooksServlet extends HttpServlet {
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
            System.out.println("ViewBooksServlet.doGet called");
            
            // Get the current session, creating one if needed
            HttpSession session = SessionUtil.getOrCreateSession(request);
            
            // Check if user is logged in and is a librarian
            User user = SessionUtil.getLoggedInUser(request);
            System.out.println("ViewBooksServlet: user is null? " + (user == null));
            
            if (user == null) {
                System.out.println("ViewBooksServlet: User not logged in, redirecting to login page");
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                return;
            }
            
            System.out.println("ViewBooksServlet: User role is: " + user.getRole());
            // Allow both librarian and admin to view books - using case-insensitive comparison
            if (!user.getRole().equalsIgnoreCase("librarian") && !user.getRole().equalsIgnoreCase("admin")) {
                System.out.println("ViewBooksServlet: User role not allowed, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                return;
            }
            
            System.out.println("ViewBooksServlet: User is logged in as: " + user.getEmail());
            
            String searchQuery = request.getParameter("search");
            List<Book> books;
            
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                System.out.println("Searching for books with query: " + searchQuery);
                books = bookDAO.searchBooks(searchQuery.trim());
            } else {
                System.out.println("Getting all books");
                books = bookDAO.getAllBooks();
            }

            System.out.println("Number of books retrieved: " + books.size());

            // Get author details for each book
            for (Book book : books) {
                Author author = authorDAO.getAuthorById(book.getAuthorId());
                if (author != null) {
                    System.out.println("Found author for book " + book.getId() + ": " + author.getAuthorName());
                    request.setAttribute("author_" + book.getId(), author);
                } else {
                    System.out.println("No author found for book " + book.getId());
                }
            }

            request.setAttribute("books", books);
            System.out.println("Forwarding to view-books.jsp");
            request.getRequestDispatcher("/views/librarian/view-books.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in ViewBooksServlet.doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading books: " + e.getMessage());
        }
    }
} 