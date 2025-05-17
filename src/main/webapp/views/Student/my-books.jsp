<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Books - LibraryMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6C63FF;
            --primary-light: #F3F2FF;
            --secondary-color: #4A41D7;
            --dark-color: #2A2F4F;
            --light-color: #F7F7FC;
            --success-color: #10B981;
            --error-color: #EF4444;
            --warning-color: #F59E0B;
            --text-color: #4B5563;
            --border-radius: 12px;
            --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
            --transition: all 0.3s ease;
            --sidebar-width: 260px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        body {
            background-color: var(--light-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: white;
            box-shadow: var(--shadow-md);
            padding: 2rem 1.5rem;
            z-index: 100;
            transition: var(--transition);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            padding-bottom: 1.8rem;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            margin-bottom: 1.8rem;
        }

        .sidebar-logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.7rem;
        }

        .nav-items {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--text-color);
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: var(--transition);
            gap: 0.8rem;
            font-weight: 500;
        }

        .nav-link:hover {
            background: var(--primary-light);
            color: var(--primary-color);
            transform: translateX(5px);
        }

        .nav-link.active {
            background: var(--primary-color);
            color: white;
        }

        .nav-link i {
            font-size: 1.1rem;
            width: 24px;
        }

        .logout-section {
            position: absolute;
            bottom: 2rem;
            left: 1.5rem;
            right: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.05);
        }

        .logout-link {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--error-color);
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: var(--transition);
            gap: 0.8rem;
            font-weight: 600;
        }

        .logout-link:hover {
            background: #FEF2F2;
            transform: translateX(5px);
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
        }

        /* Include the same CSS as search-books.jsp */
        /* Add specific styles for my-books page */
        .books-table {
            width: 100%;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            margin-top: 2rem;
        }
        
        .books-table th,
        .books-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #E5E7EB;
        }
        
        .books-table th {
            background-color: var(--primary-light);
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .books-table tr:hover {
            background-color: #F9FAFB;
        }
        
        .return-button {
            padding: 0.5rem 1rem;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        
        .return-button:hover {
            background-color: var(--secondary-color);
            transform: translateY(-1px);
        }
        
        .due-date {
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .due-soon {
            background-color: #FEF3C7;
            color: #92400E;
        }
        
        .overdue {
            background-color: #FEE2E2;
            color: #991B1B;
        }
        
        .fine-amount {
            color: var(--error-color);
            font-weight: 500;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--text-color);
        }
        
        .empty-state i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .empty-state h3 {
            margin-bottom: 0.5rem;
        }
        
        .empty-state p {
            margin-bottom: 1.5rem;
        }
        
        .browse-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .browse-button:hover {
            background-color: var(--secondary-color);
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
<c:set var="activeTab" value="my-books" scope="request"/>
<%@ include file="includes/sidebar.jsp" %>

<div class="main-content">
    <h1 style="margin-bottom: 1.5rem;">My Books</h1>

    <!-- Success and Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% session.removeAttribute("success"); %>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% session.removeAttribute("error"); %>
    </c:if>

    <!-- Books Table -->
    <c:choose>
        <c:when test="${not empty activeBooks}">
            <div class="table-responsive">
                <table class="books-table">
                    <thead>
                        <tr>
                            <th>Book Title</th>
                            <th>Author</th>
                            <th>Borrow Date</th>
                            <th>Due Date</th>
                            <th>Fine (if any)</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="borrow" items="${activeBooks}">
                            <tr>
                                <td>${borrow.book.title}</td>
                                <td>${not empty borrow.book.authors ? borrow.book.authors[0].authorName : 'Unknown'}</td>
                                <td><fmt:formatDate value="${borrow.borrowDate}" pattern="MMM d, yyyy"/></td>
                                <td>
                                    <c:set var="now" value="<%= new java.util.Date() %>"/>
                                    <c:set var="daysUntilDue" value="${(borrow.dueDate.time - now.time) / (1000*60*60*24)}"/>
                                    <span class="due-date ${daysUntilDue <= 3 ? 'due-soon' : ''} ${daysUntilDue < 0 ? 'overdue' : ''}">
                                        <fmt:formatDate value="${borrow.dueDate}" pattern="MMM d, yyyy"/>
                                        <c:if test="${daysUntilDue <= 3 && daysUntilDue > 0}">
                                            (Due in ${Math.ceil(daysUntilDue)} days)
                                        </c:if>
                                        <c:if test="${daysUntilDue < 0}">
                                            (Overdue by ${Math.abs(Math.floor(daysUntilDue))} days)
                                        </c:if>
                                    </span>
                                </td>
                                <td>
                                    <c:if test="${not empty borrow.fines}">
                                        <span class="fine-amount">₹${borrow.fines[0].fineAmount}</span>
                                    </c:if>
                                </td>
                                <td>
                                    <button class="return-button" onclick="returnBook(${borrow.borrowID})">
                                        <i class="fas fa-undo-alt"></i> Return
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-book-open"></i>
                <h3>No Books Currently Borrowed</h3>
                <p>You haven't borrowed any books yet. Browse our collection to find interesting books!</p>
                <a href="${pageContext.request.contextPath}/student/search-books" class="browse-button">
                    <i class="fas fa-search"></i>
                    Browse Books
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function returnBook(borrowId) {
        if (confirm('Are you sure you want to return this book?')) {
            window.location.href = '${pageContext.request.contextPath}/student/return-book?borrowId=' + borrowId;
        }
    }
</script>
</body>
</html>
