<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - LibraryMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6C63FF;
            --secondary-color: #4A41D7;
            --dark-color: #2A2F4F;
            --light-color: #F7F7FC;
            --success-color: #10B981;
            --error-color: #EF4444;
            --warning-color: #F59E0B;
            --sidebar-width: 250px;
            --header-height: 60px;
            --shadow-sm: 0 2px 10px rgba(108, 99, 255, 0.1);
            --shadow-md: 0 4px 20px rgba(108, 99, 255, 0.15);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            background-color: var(--light-color);
            color: var(--dark-color);
        }

        /* Header Styles */
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
            padding: 0 2rem;
            z-index: 100;
        }

        .header-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-color);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background-color: var(--error-color);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: var(--transition);
        }

        .logout-btn:hover {
            background-color: #D22B2B;
        }

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: white;
            box-shadow: var(--shadow-sm);
            padding: 1.5rem;
            overflow-y: auto;
            z-index: 1000;
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #eee;
            margin-bottom: 1.5rem;
        }

        .sidebar-logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-items {
            list-style: none;
            flex-grow: 1;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.8rem 1rem;
            color: var(--dark-color);
            text-decoration: none;
            border-radius: 8px;
            transition: var(--transition);
            gap: 0.8rem;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
        }

        .nav-link i {
            width: 20px;
        }

        .logout-section {
            padding-top: 1rem;
            border-top: 1px solid #eee;
            margin-top: auto;
        }

        .logout-link {
            display: flex;
            align-items: center;
            padding: 0.8rem 1rem;
            color: var(--error-color);
            text-decoration: none;
            border-radius: 8px;
            transition: var(--transition);
            gap: 0.8rem;
            font-weight: 600;
        }

        .logout-link:hover {
            background: rgba(239, 68, 68, 0.1);
        }

        .logout-link i {
            width: 20px;
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            margin-top: var(--header-height);
            padding: 2rem;
            min-height: calc(100vh - var(--header-height));
        }

        .welcome-message {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 2rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
        }

        .stat-title {
            color: #666;
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            margin-bottom: 1rem;
        }

        .stat-icon.books {
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
        }

        .stat-icon.borrowings {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .stat-icon.overdue {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .stat-icon.fines {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .dashboard-card {
            background: white;
            padding: 1.5rem;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
        }

        .card-header {
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
        }

        .card-subtitle {
            color: #666;
            font-size: 0.9rem;
        }

        .category-list {
            list-style: none;
        }

        .category-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid #eee;
        }

        .category-item:last-child {
            border-bottom: none;
        }

        .category-name {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .category-bar {
            flex: 1;
            height: 8px;
            background: #eee;
            border-radius: 4px;
            margin: 0 1rem;
            overflow: hidden;
        }

        .category-progress {
            height: 100%;
            background: var(--primary-color);
            border-radius: 4px;
        }

        .category-count {
            font-weight: 600;
            color: var(--dark-color);
            min-width: 24px;
            text-align: right;
        }

        .activity-list {
            list-style: none;
        }

        .activity-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: 0.75rem 0;
            border-bottom: 1px solid #eee;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .activity-icon.borrowed {
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
        }

        .activity-icon.returned {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
        }

        .activity-date {
            color: #666;
            font-size: 0.85rem;
        }

        @media (max-width: 1024px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }

            .welcome-message {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/views/librarian/dashboard.jsp" class="sidebar-logo">
            <i class="fas fa-book-reader"></i>
            <span>LibraryMS</span>
        </a>
    </div>
    <ul class="nav-items">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/dashboard.jsp" class="nav-link">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/add-books.jsp" class="nav-link">
                <i class="fas fa-plus-circle"></i>
                <span>Add Books</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/view-books.jsp" class="nav-link active">
                <i class="fas fa-book"></i>
                <span>View Books</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/author.jsp" class="nav-link">
                <i class="fas fa-pen-fancy"></i>
                <span>Manage Authors</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/edit-book.jsp" class="nav-link">
                <i class="fas fa-edit"></i>
                <span>Edit Books</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/borrowed-books.jsp" class="nav-link">
                <i class="fas fa-clipboard-list"></i>
                <span>Borrowed Books</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/profile.jsp" class="nav-link">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </li>
    </ul>
    <!-- Logout Section -->
    <div class="logout-section">
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</aside>

<!-- Header -->
<header class="header">
    <h1 class="header-title">Dashboard</h1>
    <!-- Header Logout Button (Alternative/Additional Option) -->
    <div class="header-actions">
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</header>

<!-- Main Content -->
<main class="main-content">
    <h1 class="welcome-message">Welcome, Admin User!</h1>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon books">
                <i class="fas fa-book"></i>
            </div>
            <h3 class="stat-title">Total Books</h3>
            <div class="stat-value">
                20
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon borrowings">
                <i class="fas fa-clock"></i>
            </div>
            <h3 class="stat-title">Active Borrowings</h3>
            <div class="stat-value">
                6
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon overdue">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h3 class="stat-title">Overdue Books</h3>
            <div class="stat-value">
                4
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon fines">
                <i class="fas fa-rupee-sign"></i>
            </div>
            <h3 class="stat-title">Total Fines</h3>
            <div class="stat-value">
                Rs.255
            </div>
        </div>
    </div>

    <!-- Dashboard Grid -->
    <div class="dashboard-grid">
        <!-- Popular Categories -->
        <div class="dashboard-card">
            <div class="card-header">
                <h2 class="card-title">Popular Categories</h2>
                <p class="card-subtitle">Top book categories in the library</p>
            </div>
            <ul class="category-list">
                <li class="category-item">
                    <span class="category-name">History</span>
                    <div class="category-bar">
                        <div class="category-progress" style="width: 80%"></div>
                    </div>
                    <span class="category-count">4</span>
                </li>
                <li class="category-item">
                    <span class="category-name">Science</span>
                    <div class="category-bar">
                        <div class="category-progress" style="width: 75%"></div>
                    </div>
                    <span class="category-count">4</span>
                </li>
                <li class="category-item">
                    <span class="category-name">Biography</span>
                    <div class="category-bar">
                        <div class="category-progress" style="width: 60%"></div>
                    </div>
                    <span class="category-count">3</span>
                </li>
            </ul>
        </div>

        <!-- Recent Activity -->
        <div class="dashboard-card">
            <div class="card-header">
                <h2 class="card-title">Recent Activity</h2>
                <p class="card-subtitle">Latest borrowings and returns</p>
            </div>
            <ul class="activity-list">
                <li class="activity-item">
                    <div class="activity-icon borrowed">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 1</h4>
                        <p class="activity-date">Borrowed on 4/19/2025</p>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon returned">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 14</h4>
                        <p class="activity-date">Returned on 4/29/2025</p>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon returned">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 9</h4>
                        <p class="activity-date">Returned on 4/17/2025</p>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon borrowed">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 12</h4>
                        <p class="activity-date">Borrowed on 4/7/2025</p>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon returned">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 11</h4>
                        <p class="activity-date">Returned on 4/21/2025</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</main>
</body>
</html>
