<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Books - LibraryMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
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
            padding: 2.5rem;
            min-height: 100vh;
            background: var(--light-color);
            padding-top: calc(var(--header-height) + 20px);
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
      }

        /* Alert styles */
        .alert {
            margin-bottom: 2rem;
            padding: 1rem 1.5rem;
        border-radius: var(--border-radius);
        display: flex;
        align-items: center;
            gap: 1rem;
            background: white;
            box-shadow: var(--shadow-sm);
        }

        .alert i {
            font-size: 1.2rem;
        }

        .alert-success {
            background-color: #ECFDF5;
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
      }

        .alert-danger {
            background-color: #FEF2F2;
            color: var(--error-color);
            border-left: 4px solid var(--error-color);
      }

        /* Search section styles */
        .search-section {
        background: white;
            padding: 2rem;
        border-radius: var(--border-radius);
        box-shadow: var(--shadow-sm);
            margin-bottom: 2.5rem;
        transition: var(--transition);
      }

      .search-form {
        display: flex;
            gap: 1.2rem;
            align-items: center;
      }

        .search-input-wrapper {
        flex: 1;
        position: relative;
      }

      .search-input {
        width: 100%;
            padding: 1rem 1.2rem 1rem 3rem;
            border: 1px solid #E5E7EB;
            border-radius: var(--border-radius);
            font-size: 1rem;
        transition: var(--transition);
            color: var(--dark-color);
            background-color: var(--light-color);
      }

      .search-input:focus {
        outline: none;
        border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.1);
      }

      .search-icon {
        position: absolute;
            left: 1.2rem;
        top: 50%;
        transform: translateY(-50%);
            color: var(--primary-color);
            font-size: 1.1rem;
      }

        .search-select {
            padding: 1rem 1.2rem;
            border: 1px solid #E5E7EB;
            border-radius: var(--border-radius);
            font-size: 1rem;
            color: var(--dark-color);
            background-color: var(--light-color);
            min-width: 180px;
        transition: var(--transition);
      }

        .search-select:focus {
        outline: none;
        border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.1);
      }

      .search-button {
            padding: 1rem 2rem;
            background: var(--primary-color);
        color: white;
        border: none;
            border-radius: var(--border-radius);
        font-weight: 600;
            font-size: 1rem;
        cursor: pointer;
        transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.8rem;
      }

      .search-button:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Books container styles */
        .books-container {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
        }

        /* Books grid styles */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.8rem;
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
            height: 100%;
            max-width: 380px;
            margin: 0 auto;
      }

        .book-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
            border-color: var(--primary-color);
      }

      .book-cover {
            position: relative;
            width: 100%;
            padding-top: 150%;
            background: var(--primary-light);
            overflow: hidden;
        }

        .book-cover img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 1rem;
            transition: transform 0.3s ease;
        }

        .book-card:hover .book-cover img {
            transform: scale(1.05);
      }

      .book-info {
            padding: 1.5rem;
        flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
            background: white;
      }

      .book-title {
            font-size: 1.2rem;
        font-weight: 600;
        color: var(--dark-color);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.4;
      }

        .book-meta {
            display: flex;
            align-items: center;
            color: #6B7280;
            font-size: 0.855rem;
            gap: 0.5rem;
      }

        .book-meta i {
            color: var(--primary-color);
            font-size: 0.95rem;
            width: 16px;
      }

        .book-status {
            margin-top: 0.5rem;
            padding: 0.475rem 0.95rem;
            border-radius: 30px;
            font-size: 0.83rem;
        font-weight: 500;
            display: inline-flex;
        align-items: center;
            gap: 0.5rem;
            align-self: flex-start;
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
            padding: 0.83rem;
        border: none;
            border-radius: 9.5px;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
            text-align: center;
            font-size: 0.9rem;
            width: 100%;
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

            .header {
                left: 0;
                padding: 0 1.5rem;
            }

            .main-content {
                margin-left: 0;
                padding: 1.5rem;
                padding-top: calc(var(--header-height) + 20px);
            }

            .search-section {
                padding: 1.5rem;
            }

        .search-form {
          flex-direction: column;
        }

            .search-select {
                width: 100%;
                min-width: unset;
            }

            .search-button {
                width: 100%;
                justify-content: center;
            }

            .books-container {
                padding: 1.5rem;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        }
            
            .book-card {
                max-width: 320px;
        }
            
            .book-cover {
                padding-top: 155%;
        }
      }
    </style>
</head>
<body>
<c:set var="activeTab" value="search-books" scope="request"/>
<%@ include file="includes/sidebar.jsp" %>

    <!-- Header -->
    <header class="header">
        <h1 class="header-title">
            <i class="fas fa-search"></i>
            Search Books
        </h1>
    </header>

    <!-- Main Content -->
    <main class="main-content">
    <!-- Success and Error Messages -->
    <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${success}
        </div>
    </c:if>

    <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
        </div>
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
        <section class="books-container">
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
                                    <img src="${pageContext.request.contextPath}/assets/images/default-book-cover.svg" 
                                         alt="${book.title}">
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
        </section>
</main>

    <script>
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