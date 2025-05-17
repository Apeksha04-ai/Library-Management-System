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

    // Forward to BorrowedBooksServlet to fetch data if not already present
    if (request.getAttribute("borrows") == null) {
        System.out.println("borrowed-books.jsp: No borrows attribute found, forwarding to servlet");
        request.getRequestDispatcher("/librarian/borrowed-books").forward(request, response);
        return;
    }
    System.out.println("borrowed-books.jsp: Found borrows attribute");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrowed Books - LibraryMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
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
            overflow-y: auto;
            z-index: 100;
            transition: var(--transition);
            display: flex;
            flex-direction: column;
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
            display: flex;
            align-items: center;
            gap: 0.7rem;
            text-decoration: none;
            transition: var(--transition);
        }

        .sidebar-logo:hover {
            transform: translateY(-2px);
        }

        .nav-items {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            flex-grow: 1;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--dark-color);
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            gap: 1rem;
            font-weight: 500;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(108, 99, 255, 0.08);
            color: var(--primary-color);
            transform: translateX(5px);
        }

        .nav-link.active {
            background: var(--primary-color);
            color: white;
            box-shadow: var(--shadow-sm);
        }

        .nav-link i {
            width: 22px;
            font-size: 1.1rem;
        }

        .logout-section {
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.05);
            margin-top: 2rem;
        }

        .logout-link {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--error-color);
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            gap: 1rem;
            font-weight: 600;
        }

        .logout-link:hover {
            background: rgba(239, 68, 68, 0.08);
            transform: translateX(5px);
        }

        .logout-link i {
            width: 22px;
            font-size: 1.1rem;
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

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.7rem 1.5rem;
            background: var(--error-color);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            font-weight: 600;
            box-shadow: 0 2px 10px rgba(239, 68, 68, 0.2);
        }

        .logout-btn:hover {
            background: #D22B2B;
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(239, 68, 68, 0.3);
        }

        .mobile-menu-toggle {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 50px;
            height: 50px;
            background: var(--gradient-bg);
            border-radius: 50%;
            display: none;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            cursor: pointer;
            z-index: 999;
            box-shadow: var(--shadow-md);
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

        .borrowings-table {
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

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        /* Fine amount */
        .fine-amount {
            font-weight: 700;
            color: var(--error-color);
        }

        .fine-amount.zero {
            color: var(--success-color);
        }

        /* Button styles */
        .btn {
            display: inline-flex;
            align-items: center;
            padding: 0.7rem 1.2rem;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            gap: 0.5rem;
            white-space: nowrap;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
            box-shadow: 0 3px 10px rgba(108, 99, 255, 0.2);
        }

        .btn-primary:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 99, 255, 0.3);
        }

        .btn-warning {
            background: var(--warning-color);
            color: white;
            box-shadow: 0 3px 10px rgba(245, 158, 11, 0.2);
        }

        .btn-warning:hover {
            background: #d97706;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 158, 11, 0.3);
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            align-items: center;
            justify-content: center;
            z-index: 2000;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .modal.active {
            opacity: 1;
        }

        .modal-content {
            background: white;
            padding: 2.5rem;
            border-radius: var(--border-radius);
            width: 90%;
            max-width: 500px;
            box-shadow: var(--shadow-lg);
            transform: translateY(20px);
            transition: transform 0.3s ease;
        }

        .modal.active .modal-content {
            transform: translateY(0);
        }

        .modal-header {
            margin-bottom: 1.8rem;
            position: relative;
        }

        .modal-header::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 3px;
            background: var(--primary-color);
            bottom: -8px;
            left: 0;
            border-radius: 2px;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .modal-title i {
            color: var(--primary-color);
        }

        .modal-body {
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.8rem;
            font-weight: 600;
            color: var(--dark-color);
        }

        .form-control {
            width: 100%;
            padding: 0.9rem 1.2rem;
            border: 2px solid rgba(0, 0, 0, 0.05);
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(108, 99, 255, 0.1);
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
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

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .mobile-menu-toggle {
                display: flex;
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

        /* Filter controls */
        .filter-controls {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark-color);
        }

        .date-range {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .date-range span {
            color: var(--dark-color);
            font-weight: 500;
        }

        .date-range input {
            flex: 1;
        }

        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%236C63FF' d='M6 8.825L1.175 4 2.238 2.938 6 6.7l3.763-3.762L10.825 4z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            padding-right: 2.5rem;
        }
    </style>
</head>
<body>
    <!-- Include the common sidebar -->
    <jsp:include page="../components/sidebar.jsp">
        <jsp:param name="activePage" value="borrowed-books"/>
    </jsp:include>

    <!-- Header -->
    <header class="header">
        <h1 class="header-title">
            <i class="fas fa-clipboard-list"></i>
            Borrowed Books
        </h1>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <h1 class="page-title">Manage Borrowings</h1>

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
            <div class="filter-controls">
                <div class="filter-group">
                    <label for="statusFilter">Status:</label>
                    <select id="statusFilter" class="form-control">
                        <option value="all">All</option>
                        <option value="borrowed">Borrowed</option>
                        <option value="returned">Returned</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="dateFilter">Date Range:</label>
                    <div class="date-range">
                        <input type="text" id="startDate" class="form-control" placeholder="Start Date">
                        <span>to</span>
                        <input type="text" id="endDate" class="form-control" placeholder="End Date">
                    </div>
                </div>
                <div class="filter-group">
                    <label for="fineFilter">Fine Status:</label>
                    <select id="fineFilter" class="form-control">
                        <option value="all">All</option>
                        <option value="withFine">With Fine</option>
                        <option value="noFine">No Fine</option>
                    </select>
                </div>
            </div>
            <input type="text" class="search-input" id="searchInput"
                   placeholder="Search by book title, student name, or author...">
        </div>

        <div class="table-container">
            <table class="borrowings-table">
                <thead>
                <tr>
                    <th>Book Title</th>
                    <th>Student Name</th>
                    <th>Borrow Date</th>
                    <th>Due Date</th>
                    <th>Return Date</th>
                    <th>Fine (Rs)</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="borrowingsTableBody">
                <c:choose>
                    <c:when test="${empty borrows}">
                        <tr>
                            <td colspan="7">
                                <div class="no-data-message">
                                    <i class="fas fa-book-open"></i>
                                    <h3>No borrowed books found</h3>
                                    <p>There are currently no books being borrowed.</p>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="borrow" items="${borrows}">
                            <tr>
                                <td>${borrow.book.title}</td>
                                <td>${borrow.user.name}</td>
                                <td><fmt:formatDate value="${borrow.borrowDate}" pattern="yyyy-MM-dd" /></td>
                                <td><fmt:formatDate value="${borrow.dueDate}" pattern="yyyy-MM-dd" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty borrow.returnDate}">N/A</c:when>
                                        <c:otherwise>
                                            <fmt:formatDate value="${borrow.returnDate}" pattern="yyyy-MM-dd" />
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:forEach var="fine" items="${borrow.fines}">
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
                                <td>
                                    <c:choose>
                                        <c:when test="${empty borrow.returnDate}">
                                            <button class="btn btn-primary" onclick="showReturnModal(${borrow.borrowID})">
                                                <i class="fas fa-undo-alt"></i> Return
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status status-returned">
                                                <i class="fas fa-check-circle"></i> Returned
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Return Book Modal -->
    <div class="modal" id="returnModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">
                    <i class="fas fa-undo-alt"></i>
                    Mark Book as Returned
                </h2>
            </div>
            <div class="modal-body">
                <form id="returnBookForm" action="${pageContext.request.contextPath}/librarian/return-book" method="post">
                    <input type="hidden" id="borrowId" name="borrowId">
                    <div class="form-group">
                        <label class="form-label" for="returnDate">Return Date</label>
                        <input type="text" class="form-control" id="returnDate" name="returnDate"
                               placeholder="Select return date">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Fine Amount</label>
                        <p class="fine-amount" id="fineAmount">Rs. 0</p>
                        <input type="hidden" id="fineAmountInput" name="fineAmount" value="0">
                    </div>
                    <div class="button-group">
                        <button type="button" class="btn btn-warning" onclick="hideReturnModal()">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check"></i> Confirm Return
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Initialize datetime picker
        flatpickr("#returnDate", {
            enableTime: false,
            dateFormat: "Y-m-d",
            defaultDate: new Date(),
            time_24hr: true
        });

        // Initialize datetime pickers for filter date range
        flatpickr("#startDate", {
            enableTime: false,
            dateFormat: "Y-m-d",
            time_24hr: true
        });

        flatpickr("#endDate", {
            enableTime: false,
            dateFormat: "Y-m-d",
            time_24hr: true
        });

        // Enhanced search and filter functionality
        function filterRows() {
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            const status = document.getElementById('statusFilter').value;
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const fineStatus = document.getElementById('fineFilter').value;
            
            const rows = document.getElementById('borrowingsTableBody').getElementsByTagName('tr');
            
            Array.from(rows).forEach(row => {
                if (row.cells.length > 1) {  // Skip the no-data message row
                    const bookTitle = row.cells[0].textContent.toLowerCase();
                    const studentName = row.cells[1].textContent.toLowerCase();
                    const borrowDate = row.cells[2].textContent;
                    const returnDate = row.cells[4].textContent;
                    const fineAmount = parseFloat(row.cells[5].textContent.replace('Rs. ', '')) || 0;
                    
                    // Text search match
                    const matchesSearch = bookTitle.includes(searchText) || 
                                       studentName.includes(searchText);
                    
                    // Status match
                    let matchesStatus = true;
                    if (status !== 'all') {
                        if (status === 'borrowed') {
                            matchesStatus = returnDate.trim() === 'N/A';
                        } else if (status === 'returned') {
                            matchesStatus = returnDate.trim() !== 'N/A';
                        }
                    }
                    
                    // Date range match
                    let matchesDateRange = true;
                    if (startDate && endDate) {
                        const rowDate = new Date(borrowDate);
                        const start = new Date(startDate);
                        const end = new Date(endDate);
                        matchesDateRange = rowDate >= start && rowDate <= end;
                    }
                    
                    // Fine status match
                    let matchesFineStatus = true;
                    if (fineStatus !== 'all') {
                        if (fineStatus === 'withFine') {
                            matchesFineStatus = fineAmount > 0;
                        } else if (fineStatus === 'noFine') {
                            matchesFineStatus = fineAmount === 0;
                        }
                    }
                    
                    row.style.display =
                        matchesSearch && matchesStatus && matchesDateRange && matchesFineStatus
                            ? ''
                            : 'none';
                }
            });
        }

        // Add event listeners for all filter controls
        document.getElementById('searchInput').addEventListener('input', filterRows);
        document.getElementById('statusFilter').addEventListener('change', filterRows);
        document.getElementById('startDate').addEventListener('change', filterRows);
        document.getElementById('endDate').addEventListener('change', filterRows);
        document.getElementById('fineFilter').addEventListener('change', filterRows);

        // Modal functionality with animations
        function showReturnModal(borrowId) {
            document.getElementById('borrowId').value = borrowId;
            const modal = document.getElementById('returnModal');
            modal.style.display = 'flex';
            setTimeout(() => {
                modal.classList.add('active');
            }, 10);
            
            // Reset fine amount display
            document.getElementById('fineAmount').textContent = 'Rs. 0';
            document.getElementById('fineAmount').classList.add('zero');
            document.getElementById('fineAmountInput').value = '0';
        }

        function hideReturnModal() {
            const modal = document.getElementById('returnModal');
            modal.classList.remove('active');
            setTimeout(() => {
                modal.style.display = 'none';
            }, 300);
        }

        // Calculate fine amount when return date changes
        document.getElementById('returnDate').addEventListener('change', function() {
            const returnDate = new Date(this.value);
            // Get the closest row to get the due date
            const borrowId = document.getElementById('borrowId').value;
            const rows = document.getElementById('borrowingsTableBody').getElementsByTagName('tr');
            let dueDate = null;
            
            Array.from(rows).forEach(row => {
                if (row.cells.length > 1) {
                    const returnButton = row.querySelector('button.btn-primary');
                    if (returnButton && returnButton.getAttribute('onclick').includes(borrowId)) {
                        const dueDateText = row.cells[3].textContent.trim();
                        dueDate = new Date(dueDateText);
                    }
                }
            });
            
            if (dueDate && returnDate > dueDate) {
                // Calculate days late
                const days = Math.ceil((returnDate - dueDate) / (1000 * 60 * 60 * 24));
                const fineAmount = days * 5; // Rs. 5 per day
                document.getElementById('fineAmount').textContent = Rs. ${fineAmount};
                document.getElementById('fineAmount').classList.remove('zero');
                document.getElementById('fineAmountInput').value = fineAmount;
            } else {
                document.getElementById('fineAmount').textContent = 'Rs. 0';
                document.getElementById('fineAmount').classList.add('zero');
                document.getElementById('fineAmountInput').value = '0';
            }
        });

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('returnModal');
            if (event.target === modal) {
                hideReturnModal();
            }
        }

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
