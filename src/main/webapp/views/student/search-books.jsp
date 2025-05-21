<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Books - LibraryMS</title>
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

      .sidebar-logo:hover {
        transform: translateY(-2px);
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

      .logout-link i {
        font-size: 1.1rem;
            width: 24px;
        }

        /* Mobile menu toggle */
      .mobile-menu-toggle {
        position: fixed;
        bottom: 2rem;
        right: 2rem;
        width: 50px;
        height: 50px;
            background: var(--primary-color);
        border-radius: 50%;
        display: none;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.2rem;
        cursor: pointer;
            z-index: 1000;
        box-shadow: var(--shadow-md);
      }

        /* Main content styles */
      .main-content {
        margin-left: var(--sidebar-width);
            padding: 2rem;
            min-height: 100vh;
        }

        /* Header styles */
        .header {
        display: flex;
            justify-content: space-between;
        align-items: center;
            margin-bottom: 2rem;
            padding: 1rem 0;
      }

        .page-title {
            font-size: 1.75rem;
            font-weight: 700;
        color: var(--dark-color);
        display: flex;
        align-items: center;
            gap: 0.75rem;
      }

        .page-title i {
            color: var(--primary-color);
      }

        /* Alert styles */
        .alert {
            padding: 1rem;
        border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
            gap: 0.75rem;
            animation: slideIn 0.3s ease;
      }

        .alert-error {
            background-color: #FEF2F2;
            color: var(--error-color);
            border: 1px solid #FEE2E2;
      }

        @keyframes slideIn {
            from { transform: translateY(-10px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
      }

        /* Search section styles */
        .search-section {
        background: white;
            padding: 1.5rem;
        border-radius: var(--border-radius);
        box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
        transition: var(--transition);
      }

        .search-section:hover {
        box-shadow: var(--shadow-md);
      }

      .search-form {
        display: flex;
        gap: 1rem;
            align-items: center;
      }

        .search-input-wrapper {
        flex: 1;
        position: relative;
      }

      .search-input {
        width: 100%;
            padding: 0.875rem 1rem 0.875rem 2.75rem;
            border: 1px solid #E5E7EB;
            border-radius: var(--border-radius);
            font-size: 0.95rem;
        transition: var(--transition);
            color: var(--dark-color);
      }

      .search-input:focus {
        outline: none;
        border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.1);
      }

      .search-icon {
        position: absolute;
            left: 1rem;
        top: 50%;
        transform: translateY(-50%);
            color: #9CA3AF;
            pointer-events: none;
      }

        .search-select {
            padding: 0.875rem 1rem;
            border: 1px solid #E5E7EB;
            border-radius: var(--border-radius);
            font-size: 0.95rem;
            color: var(--dark-color);
            background-color: white;
            min-width: 160px;
        transition: var(--transition);
      }

        .search-select:focus {
        outline: none;
        border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.1);
      }

      .search-button {
            padding: 0.875rem 1.5rem;
            background-color: var(--primary-color);
        color: white;
        border: none;
            border-radius: var(--border-radius);
        font-weight: 600;
            font-size: 0.95rem;
        cursor: pointer;
        transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
      }

      .search-button:hover {
            background-color: var(--secondary-color);
            transform: translateY(-1px);
        }

        /* Books grid styles */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
      }

        .book-card {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            transition: var(--transition);
            border: 1px solid #E5E7EB;
        display: flex;
            flex-direction: column;
      }

        .book-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
            border-color: var(--primary-color);
      }

      .book-cover {
            aspect-ratio: 3/4;
            background: var(--primary-light);
        display: flex;
        align-items: center;
        justify-content: center;
            color: var(--primary-color);
            font-size: 2rem;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
      }

      .book-info {
            padding: 1.25rem;
        flex: 1;
            display: flex;
            flex-direction: column;
      }

      .book-title {
            font-size: 1.1rem;
        font-weight: 600;
        color: var(--dark-color);
            margin-bottom: 0.5rem;
      }

        .book-meta {
            color: #6B7280;
        font-size: 0.9rem;
        margin-bottom: 0.25rem;
      }

        .book-meta i {
            width: 16px;
        color: var(--primary-color);
            margin-right: 0.5rem;
      }

        .book-status {
            margin: 1rem 0;
            padding: 0.4rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
        font-weight: 500;
            display: inline-flex;
        align-items: center;
        gap: 0.4rem;
      }

        .status-available {
            background-color: #ECFDF5;
            color: var(--success-color);
      }

        .status-unavailable {
            background-color: #FEF2F2;
        color: var(--error-color);
      }

      .borrow-button {
            margin-top: auto;
            padding: 0.75rem;
        border: none;
        border-radius: 8px;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
            text-align: center;
            font-size: 0.95rem;
      }

        .borrow-button:not(:disabled) {
            background-color: var(--primary-light);
            color: var(--primary-color);
        }

        .borrow-button:not(:disabled):hover {
            background-color: var(--primary-color);
            color: white;
        }

        .borrow-button:disabled {
            background-color: #F3F4F6;
            color: #9CA3AF;
            cursor: not-allowed;
        }

        /* Responsive styles */
      @media (max-width: 768px) {
        .sidebar {
          transform: translateX(-100%);
        }

        .sidebar.active {
          transform: translateX(0);
        }

        .mobile-menu-toggle {
          display: flex;
        }

            .main-content {
                margin-left: 0;
                padding: 1rem;
            }

        .search-form {
          flex-direction: column;
        }

            .search-select {
                width: 100%;
            }

            .search-button {
                width: 100%;
                justify-content: center;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        }
        }

        /* Success and Error Messages */
        .alert {
            margin: 20px 0;
            padding: 15px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert i {
            font-size: 1.2em;
        }
        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
        .btn-close {
            margin-left: auto;
            font-size: 1.25rem;
            background: transparent;
            border: 0;
            opacity: 0.5;
            cursor: pointer;
        }
        .btn-close:hover {
            opacity: 1;
      }
    </style>
</head>
<body>
<c:set var="activeTab" value="search-books" scope="request"/>
<%@ include file="includes/sidebar.jsp" %>

<!-- Main Content -->
<main class="main-content">
    <header class="header">
        <h1 class="page-title">
            <i class="fas fa-search"></i>
            Search Books
        </h1>
    </header>

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

    <!-- Search Section -->
    <section class="search-section">
        <form action="${pageContext.request.contextPath}/student/search-books" method="GET" class="search-form">
            <div class="search-input-wrapper">
        <i class="fas fa-search search-icon"></i>
                <input type="text" 
                       name="query" 
                       class="search-input" 
                       placeholder="Search by title, author, or ISBN..." 
                       value="${searchQuery}"
                       autocomplete="off">
      </div>

                <select name="category" class="search-select">
                    <option value="all" ${selectedCategory == 'all' ? 'selected' : ''}>All Categories</option>
                    <option value="fiction" ${selectedCategory == 'fiction' ? 'selected' : ''}>Fiction</option>
                    <option value="non-fiction" ${selectedCategory == 'non-fiction' ? 'selected' : ''}>Non-Fiction</option>
                    <option value="science" ${selectedCategory == 'science' ? 'selected' : ''}>Science</option>
                    <option value="technology" ${selectedCategory == 'technology' ? 'selected' : ''}>Technology</option>
                    <option value="history" ${selectedCategory == 'history' ? 'selected' : ''}>History</option>
      </select>

                <select name="availability" class="search-select">
                    <option value="all" ${selectedAvailability == 'all' ? 'selected' : ''}>All Books</option>
                    <option value="available" ${selectedAvailability == 'available' ? 'selected' : ''}>Available Only</option>
      </select>

                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                    Search
                </button>
    </form>
    </section>

    <!-- Books Grid -->
    <div class="books-grid">
        <c:forEach var="book" items="${books}">
            <div class="book-card">
                <div class="book-cover">
                    <c:choose>
                        <c:when test="${not empty book.coverImage}">
                            <img src="${pageContext.request.contextPath}/uploads/books/${book.coverImage}" 
                                 alt="${book.title}" 
                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-book-cover.svg';">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/images/default-book-cover.svg" alt="${book.title}">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="book-info">
                    <h3 class="book-title">${book.title}</h3>
                    <p class="book-meta">
                        <i class="fas fa-user"></i>
                        ${not empty book.authors ? book.authors[0].authorName : 'Unknown'}
                    </p>
                    <p class="book-meta">
                        <i class="fas fa-barcode"></i>
                        ${book.isbn}
                    </p>
                    <span class="book-status ${book.available ? 'status-available' : 'status-unavailable'}">
                        <i class="fas ${book.available ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                        ${book.available ? 'Available' : 'Unavailable'}
                    </span>
                    <button class="borrow-button" 
                            onclick="borrowBook(${book.id})"
                            ${book.available ? '' : 'disabled'}>
                        ${book.available ? 'Borrow Book' : 'Not Available'}
                    </button>
                </div>
  </div>
        </c:forEach>
</div>
</main>

    <script>
        // Mobile menu toggle functionality is in sidebar.jsp, no need to define it here

        function borrowBook(bookId) {
            if (confirm('Are you sure you want to borrow this book?')) {
                window.location.href = '${pageContext.request.contextPath}/student/borrow-book?id=' + bookId;
            }
        }

        // Maintain selected values after form submission
        document.addEventListener('DOMContentLoaded', function() {
            const categorySelect = document.querySelector('select[name="category"]');
            const availabilitySelect = document.querySelector('select[name="availability"]');
            
            if ('${selectedCategory}') {
                categorySelect.value = '${selectedCategory}';
            }
            
            if ('${selectedAvailability}') {
                availabilitySelect.value = '${selectedAvailability}';
            }
        });
    </script>
</body>
</html>