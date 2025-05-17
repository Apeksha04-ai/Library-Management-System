<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrowing History - LibraryMS</title>
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
            --header-height: 70px;
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

        /* Main content */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
            padding-top: calc(var(--header-height) + 2rem);
        }

        /* Header */
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
            padding: 0 2rem;
            z-index: 99;
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .page-title i {
            color: var(--primary-color);
        }

        /* Alerts */
        .alert {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
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

        /* History filters */
        .history-controls {
            background: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .history-controls:hover {
            box-shadow: var(--shadow-md);
        }

        .filter-title {
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--dark-color);
        }

        .history-filters {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: var(--text-color);
        }

        .filter-select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid rgba(0,0,0,0.1);
            border-radius: 8px;
            background-color: white;
            color: var(--text-color);
            font-size: 0.95rem;
            transition: var(--transition);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 1em;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.1);
        }

        .filter-button {
            margin-top: 1.5rem;
            padding: 0.75rem 1.5rem;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .filter-button:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
        }

        /* History table */
        .history-container {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .history-container:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-3px);
        }

        .history-table {
            width: 100%;
            border-collapse: collapse;
        }

        .history-table th,
        .history-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .history-table th {
            background-color: var(--primary-light);
            color: var(--primary-color);
            font-weight: 600;
            white-space: nowrap;
        }

        .history-table tr:last-child td {
            border-bottom: none;
        }

        .history-table tr:hover {
            background-color: rgba(108, 99, 255, 0.02);
        }

        /* Status badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            gap: 0.4rem;
            white-space: nowrap;
        }

        .status-returned {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .status-overdue {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
        }

        .status-active {
            background-color: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
        }

        /* Date cells */
        .date-cell {
            white-space: nowrap;
            color: var(--dark-color);
        }

        /* Fine amount */
        .fine-amount {
            color: var(--error-color);
            font-weight: 600;
        }

        .fine-amount.zero {
            color: var(--success-color);
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: var(--text-color);
        }

        .empty-state i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            opacity: 0.6;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            margin-bottom: 1.5rem;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        .browse-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: var(--transition);
        }

        .browse-button:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
        }

        /* Responsive styles */
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
            }

            .main-content {
                margin-left: 0;
            }

            .mobile-menu-toggle {
                display: block;
                position: fixed;
                bottom: 2rem;
                right: 2rem;
                width: 50px;
                height: 50px;
                background: var(--primary-color);
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                box-shadow: var(--shadow-md);
                z-index: 99;
                cursor: pointer;
            }
        }

        @media (max-width: 576px) {
            .main-content {
                padding: 1rem;
                padding-top: calc(var(--header-height) + 1rem);
            }

            .history-table {
                display: block;
                overflow-x: auto;
            }

            .history-controls {
                padding: 1rem;
            }

            .filter-group {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
<c:set var="activeTab" value="history" scope="request"/>
<%@ include file="includes/sidebar.jsp" %>

<!-- Header -->
<header class="header">
    <h1 class="page-title">
        <i class="fas fa-history"></i>
        Borrowing History
    </h1>
</header>

<!-- Main Content -->
<main class="main-content">
    <!-- Success and Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
        <% session.removeAttribute("success"); %>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
        <% session.removeAttribute("error"); %>
    </c:if>

    <!-- History Controls -->
    <div class="history-controls">
        <h2 class="filter-title">Filter History</h2>
        <div class="history-filters">
            <div class="filter-group">
                <label class="filter-label" for="statusFilter">Status</label>
                <select class="filter-select" id="statusFilter">
                    <option value="all">All Status</option>
                    <option value="active">Currently Borrowed</option>
                    <option value="returned">Returned</option>
                    <option value="overdue">Overdue</option>
                </select>
            </div>
            
            <div class="filter-group">
                <label class="filter-label" for="timeFilter">Time Period</label>
                <select class="filter-select" id="timeFilter">
                    <option value="all">All Time</option>
                    <option value="month">Last Month</option>
                    <option value="3months">Last 3 Months</option>
                    <option value="6months">Last 6 Months</option>
                    <option value="year">Last Year</option>
                </select>
            </div>
        </div>

        <button class="filter-button" onclick="filterHistory()">
            <i class="fas fa-filter"></i>
            Apply Filters
        </button>
    </div>

    <!-- Books Table -->
    <c:choose>
        <c:when test="${not empty borrowHistory}">
            <div class="history-container">
                <table class="history-table">
                    <thead>
                        <tr>
                            <th>Book Title</th>
                            <th>Author</th>
                            <th>Borrow Date</th>
                            <th>Due Date</th>
                            <th>Return Date</th>
                            <th>Status</th>
                            <th>Fine</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="borrow" items="${borrowHistory}">
                            <tr>
                                <td><strong>${borrow.book.title}</strong></td>
                                <td>${not empty borrow.book.authors ? borrow.book.authors[0].authorName : 'Unknown'}</td>
                                <td class="date-cell"><fmt:formatDate value="${borrow.borrowDate}" pattern="MMM d, yyyy"/></td>
                                <td class="date-cell"><fmt:formatDate value="${borrow.dueDate}" pattern="MMM d, yyyy"/></td>
                                <td class="date-cell">
                                    <c:choose>
                                        <c:when test="${not empty borrow.returnDate}">
                                            <fmt:formatDate value="${borrow.returnDate}" pattern="MMM d, yyyy"/>
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:set var="now" value="<%= new java.util.Date() %>"/>
                                    <c:choose>
                                        <c:when test="${not empty borrow.returnDate}">
                                            <span class="status-badge status-returned">
                                                <i class="fas fa-check-circle"></i> Returned
                                            </span>
                                        </c:when>
                                        <c:when test="${borrow.dueDate.time < now.time}">
                                            <span class="status-badge status-overdue">
                                                <i class="fas fa-exclamation-circle"></i> Overdue
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-active">
                                                <i class="fas fa-clock"></i> Active
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty borrow.fines && borrow.fines[0].fineAmount.doubleValue() > 0}">
                                            <span class="fine-amount">₹${borrow.fines[0].fineAmount}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="fine-amount zero">₹0</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-history"></i>
                <h3>No Borrowing History</h3>
                <p>You haven't borrowed any books yet. Start exploring our collection to find interesting books!</p>
                <a href="${pageContext.request.contextPath}/student/search-books" class="browse-button">
                    <i class="fas fa-search"></i>
                    Browse Books
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<script>
    // Mobile menu toggle functionality
    const mobileMenuToggle = document.getElementById('mobileMenuToggle');
    const sidebar = document.getElementById('sidebar');

    if (mobileMenuToggle) {
        mobileMenuToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
            const icon = this.querySelector('i');
            if (sidebar.classList.contains('active')) {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-times');
            } else {
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            }
        });
    }

    function filterHistory() {
        const statusFilter = document.getElementById('statusFilter').value;
        const timeFilter = document.getElementById('timeFilter').value;
        
        // Implement client-side filtering or make an AJAX call to server
        // For now, we'll just reload the page with filter parameters
        window.location.href = '${pageContext.request.contextPath}/student/history?status=' + 
                             statusFilter + '&time=' + timeFilter;
    }
</script>
</body>
</html>
