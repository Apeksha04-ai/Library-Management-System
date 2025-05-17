<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%
    // Check if user is logged in and has appropriate role
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }
    
    // Redirect students to access denied page
    if ("Student".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/views/accessDenied.jsp");
        return;
    }

    // Forward to ReturnHistoryServlet to fetch data if not already present
    if (request.getAttribute("returnHistory") == null) {
        System.out.println("return-history.jsp: No return history found, forwarding to servlet");
        request.getRequestDispatcher("/librarian/return-history").forward(request, response);
        return;
    }
    System.out.println("return-history.jsp: Found return history, rendering page");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return History - LibraryMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <style>
        :root {
            --primary-color: #6C63FF;
            --secondary-color: #4A41D7;
            --dark-color: #2A2F4F;
            --light-color: #F7F7FC;
            --success-color: #10B981;
            --error-color: #EF4444;
            --warning-color: #F59E0B;
            --accent-color: #FF6C63;
            --sidebar-width: 260px;
            --header-height: 70px;
            --shadow-sm: 0 2px 10px rgba(108, 99, 255, 0.1);
            --shadow-md: 0 4px 20px rgba(108, 99, 255, 0.15);
            --shadow-lg: 0 10px 40px rgba(108, 99, 255, 0.2);
            --border-radius: 16px;
            --card-radius: 14px;
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            --gradient-bg: linear-gradient(135deg, #6C63FF 0%, #4A41D7 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
        }

        body {
            background-color: var(--light-color);
            color: var(--dark-color);
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* Header styles */
        .header {
            position: fixed;
            top: 0;
            left: var(--sidebar-width);
            right: 0;
            height: var(--header-height);
            background: white;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2.5rem;
            z-index: 99;
        }

        .header-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .header-title i {
            color: var(--primary-color);
            font-size: 1.3rem;
        }

        /* Main content */
        .main-content {
            margin-left: var(--sidebar-width);
            margin-top: var(--header-height);
            padding: 2.5rem;
            min-height: calc(100vh - var(--header-height));
        }

        .page-title {
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 2.5rem;
            position: relative;
            display: inline-block;
        }

        .page-title::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 4px;
            background: var(--primary-color);
            bottom: -10px;
            left: 0;
            border-radius: 2px;
        }

        /* Search container */
        .search-container {
            background: white;
            padding: 1.8rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
            transition: var(--transition);
        }

        .search-container:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-3px);
        }

        .search-input {
            width: 100%;
            padding: 0.9rem 1.2rem;
            border: 2px solid rgba(0, 0, 0, 0.05);
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(108, 99, 255, 0.1);
        }

        /* Alert messages */
        .alert {
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: var(--card-radius);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .alert-success {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }

        .alert-danger {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
            border-left: 4px solid var(--error-color);
        }

        /* Table styles */
        .table-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            transition: var(--transition);
            margin-bottom: 2rem;
        }

        .table-container:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-3px);
        }

        .history-table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 1.2rem 1.5rem;
            text-align: left;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        th {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--dark-color);
            background: rgba(108, 99, 255, 0.03);
            white-space: nowrap;
        }

        tr:hover {
            background-color: rgba(108, 99, 255, 0.02);
        }

        /* Status indicators */
        .status {
            display: inline-flex;
            align-items: center;
            padding: 0.4rem 1rem;
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 600;
            gap: 0.5rem;
        }

        .status-returned {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .status-overdue {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
        }

        /* Fine amount */
        .fine-amount {
            font-weight: 700;
            color: var(--error-color);
        }

        .fine-amount.zero {
            color: var(--success-color);
        }

        /* No data message */
        .no-data-message {
            text-align: center;
            padding: 3rem 1rem;
            color: #666;
        }

        .no-data-message i {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 1rem;
            display: block;
        }

        .no-data-message h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }

        /* Responsive styles */
        @media (max-width: 1200px) {
            .main-content {
                padding: 2rem;
            }

            th, td {
                padding: 1rem;
            }
        }

        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
            }
        }

        @media (max-width: 768px) {
            :root {
                --sidebar-width: 0;
            }

            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
                width: 280px;
            }

            .header {
                left: 0;
                padding-left: 1.5rem;
            }

            .main-content {
                margin-left: 0;
                padding: 1.5rem;
            }

            .header-actions {
                display: none;
            }
        }

        @media (max-width: 576px) {
            .header-title {
                font-size: 1.3rem;
            }

            th, td {
                padding: 0.8rem;
            }

            .page-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include the common sidebar -->
    <jsp:include page="../components/sidebar.jsp">
        <jsp:param name="activePage" value="return-history"/>
    </jsp:include>

    <!-- Header -->
    <header class="header">
        <h1 class="header-title">
            <i class="fas fa-history"></i>
            Return History
        </h1>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <h1 class="page-title">Book Return History</h1>

        <!-- Show alert messages if any -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>
        
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>

        <div class="search-container">
            <input type="text" class="search-input" id="searchInput"
                   placeholder="Search by book title, student name, or return date...">
        </div>

        <div class="table-container">
            <table class="history-table">
                <thead>
                <tr>
                    <th>Book Title</th>
                    <th>Student Name</th>
                    <th>Borrow Date</th>
                    <th>Due Date</th>
                    <th>Return Date</th>
                    <th>Status</th>
                    <th>Fine (Rs)</th>
                </tr>
                </thead>
                <tbody id="historyTableBody">
                <c:choose>
                    <c:when test="${empty returnHistory}">
                        <tr>
                            <td colspan="7">
                                <div class="no-data-message">
                                    <i class="fas fa-history"></i>
                                    <h3>No return history found</h3>
                                    <p>There are no records of returned books.</p>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="record" items="${returnHistory}">
                            <tr>
                                <td>${record.book.title}</td>
                                <td>${record.user.name}</td>
                                <td><fmt:formatDate value="${record.borrowDate}" pattern="yyyy-MM-dd" /></td>
                                <td><fmt:formatDate value="${record.dueDate}" pattern="yyyy-MM-dd" /></td>
                                <td><fmt:formatDate value="${record.returnDate}" pattern="yyyy-MM-dd" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${record.returnDate.after(record.dueDate)}">
                                            <span class="status status-overdue">
                                                <i class="fas fa-exclamation-circle"></i> Overdue
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status status-returned">
                                                <i class="fas fa-check-circle"></i> On Time
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:forEach var="fine" items="${record.fines}">
                                        <c:choose>
                                            <c:when test="${fine.fineAmount.doubleValue() > 0}">
                                                <span class="fine-amount">${fine.fineAmount}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="fine-amount zero">0</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </main>

    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchText = this.value.toLowerCase();
            const rows = document.getElementById('historyTableBody').getElementsByTagName('tr');

            Array.from(rows).forEach(row => {
                if (row.cells.length > 1) {  // Skip the no-data message row
                    const bookTitle = row.cells[0].textContent.toLowerCase();
                    const studentName = row.cells[1].textContent.toLowerCase();
                    const returnDate = row.cells[4].textContent.toLowerCase();
                    
                    row.style.display =
                        bookTitle.includes(searchText) || 
                        studentName.includes(searchText) || 
                        returnDate.includes(searchText)
                            ? ''
                            : 'none';
                }
            });
        });

        // Add animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            const tableContainer = document.querySelector('.table-container');
            const searchContainer = document.querySelector('.search-container');

            tableContainer.style.opacity = '0';
            searchContainer.style.opacity = '0';

            setTimeout(() => {
                searchContainer.style.opacity = '1';
                searchContainer.style.transform = 'translateY(0)';
            }, 100);

            setTimeout(() => {
                tableContainer.style.opacity = '1';
                tableContainer.style.transform = 'translateY(0)';
            }, 200);
        });
    </script>
</body>
</html>
