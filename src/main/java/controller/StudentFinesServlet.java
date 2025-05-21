package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;

import dao.BorrowDAO;
import dao.FineDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Borrow;
import model.User;

@WebServlet("/student/fines")
public class StudentFinesServlet extends HttpServlet {

    private BorrowDAO borrowDAO;
    private FineDAO fineDAO;

    @Override
    public void init() throws ServletException {
        borrowDAO = new BorrowDAO();
        fineDAO = new FineDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get outstanding fines
            BigDecimal totalFines = fineDAO.getOutstandingFines(user.getUserID());
            request.setAttribute("totalFines", totalFines);

            // Get borrowed books with fines
            List<Borrow> overdueBorrows = borrowDAO.getOverdueBorrowsByUserId(user.getUserID());
            request.setAttribute("overdueBorrows", overdueBorrows);

            // Get total unpaid fines count
            int unpaidFinesCount = overdueBorrows.size();
            request.setAttribute("unpaidFinesCount", unpaidFinesCount);
            
            // Calculate total days overdue
            int totalDaysOverdue = 0;
            LocalDate today = LocalDate.now();
            
            for (Borrow borrow : overdueBorrows) {
                if (borrow.getDueDate() != null) {
                    LocalDate dueDate = borrow.getDueDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                    long daysLate = ChronoUnit.DAYS.between(dueDate, today);
                    if (daysLate > 0) {
                        totalDaysOverdue += daysLate;
                    }
                }
            }
            
            request.setAttribute("totalDaysOverdue", totalDaysOverdue);

            // Forward to the fines JSP
            request.getRequestDispatcher("/views/student/fines.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle fine payment if needed
        // This would be implemented when adding payment functionality
        doGet(request, response);
    }
} 