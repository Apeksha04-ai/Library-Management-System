package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

import dao.BookDAO;
import dao.BorrowDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Book;
import model.Borrow;
import model.User;
import util.SessionUtil;

@WebServlet("/student/borrow-book")
public class StudentBorrowBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private BorrowDAO borrowDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        borrowDAO = new BorrowDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the current session
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null || !user.getRole().equalsIgnoreCase("student")) {
            session.setAttribute("error", "You must be logged in as a student to borrow books");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the book ID from request
        String bookIdParam = request.getParameter("id");
        if (bookIdParam == null || bookIdParam.trim().isEmpty()) {
            session.setAttribute("error", "Invalid book selection");
            response.sendRedirect(request.getContextPath() + "/student/search-books");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdParam);
            
            // Get the book
            Book book = bookDAO.getBookById(bookId);
            if (book == null) {
                session.setAttribute("error", "Book not found");
                response.sendRedirect(request.getContextPath() + "/student/search-books");
                return;
            }
            
            // Check if book is available
            if (!book.isAvailable() || book.getQuantity() <= 0) {
                session.setAttribute("error", "Book is not available for borrowing");
                response.sendRedirect(request.getContextPath() + "/student/search-books");
                return;
            }
            
            // Check if user already has this book borrowed
            if (borrowDAO.hasActiveBorrow(user.getUserID(), bookId)) {
                session.setAttribute("error", "You already have this book borrowed");
                response.sendRedirect(request.getContextPath() + "/student/search-books");
                return;
            }
            
            // Calculate due date (14 days from now)
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.DAY_OF_MONTH, 14);
            Date dueDate = calendar.getTime();
            
            // Create borrow object
            Borrow borrow = new Borrow();
            borrow.setUser(user);
            borrow.setBorrowDate(new Date());
            borrow.setDueDate(dueDate);
            
            // Create a borrow record
            boolean success = borrowDAO.addBorrow(borrow, bookId);
            
            if (success) {
                // Decrease book quantity by 1
                book.setQuantity(book.getQuantity() - 1);
                if (book.getQuantity() <= 0) {
                    book.setAvailable(false);
                }
                bookDAO.updateBook(book);
                
                session.setAttribute("success", "You have successfully borrowed \"" + book.getTitle() + "\". Please return by " 
                    + new java.text.SimpleDateFormat("MMM dd, yyyy").format(dueDate));
            } else {
                session.setAttribute("error", "Failed to borrow book. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid book ID");
        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/student/search-books");
    }
} 