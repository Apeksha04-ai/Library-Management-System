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
            --accent-color: #FF6C63;
            --sidebar-width: 260px;
            --header-height: 70px;
            --shadow-sm: 0 2px 10px rgba(108, 99, 255, 0.1);
            --shadow-md: 0 4px 20px rgba(108, 99, 255, 0.15);
            --shadow-lg: 0 10px 40px rgba(108, 99, 255, 0.2);
            --border-radius: 16px;
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
            background: var(--light-color);
        }

        .welcome-message {
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 2.5rem;
            position: relative;
            display: inline-block;
        }

        .welcome-message::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 4px;
            background: var(--primary-color);
            bottom: -10px;
            left: 0;
            border-radius: 2px;
        }

        /* Stats cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .stat-card {
            background: white;
            padding: 1.8rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 4px;
            top: 0;
            left: 0;
            background: linear-gradient(90deg, transparent, var(--primary-color), transparent);
            opacity: 0;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            margin-bottom: 1.2rem;
            font-size: 1.4rem;
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

        .stat-title {
            color: #666;
            font-size: 1rem;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .stat-value {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Dashboard grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.8rem;
        }

        .dashboard-card {
            background: white;
            padding: 1.8rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .dashboard-card:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-3px);
        }

        .card-header {
            margin-bottom: 1.8rem;
            position: relative;
        }

        .card-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.4rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-title i {
            color: var(--primary-color);
            font-size: 1.2rem;
        }

        .card-subtitle {
            color: #666;
            font-size: 0.95rem;
        }

        /* Category list */
        .category-list {
            list-style: none;
        }

        .category-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .category-item:last-child {
            border-bottom: none;
        }

        .category-name {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            font-weight: 500;
            color: var(--dark-color);
        }

        .category-name i {
            color: var(--primary-color);
        }

        .category-bar {
            flex: 1;
            height: 10px;
            background: rgba(108, 99, 255, 0.1);
            border-radius: 5px;
            margin: 0 1.2rem;
            overflow: hidden;
        }

        .category-progress {
            height: 100%;
            background: var(--gradient-bg);
            border-radius: 5px;
        }

        .category-count {
            font-weight: 700;
            color: var(--dark-color);
            min-width: 30px;
            text-align: right;
            background: rgba(108, 99, 255, 0.1);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }

        /* Activity list */
        .activity-list {
            list-style: none;
        }

        .activity-item {
            display: flex;
            align-items: flex-start;
            gap: 1.2rem;
            padding: 1rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            transition: var(--transition);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-item:hover {
            background: rgba(108, 99, 255, 0.02);
            transform: translateX(5px);
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
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
            font-size: 1rem;
        }

        .activity-date {
            color: #666;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .activity-date i {
            font-size: 0.8rem;
            color: #888;
        }

        /* Responsive styles */
        @media (max-width: 1200px) {
            .dashboard-grid {
                gap: 1.5rem;
            }

            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            }
        }

        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
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

            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 1rem;
            }

            .welcome-message {
                font-size: 1.8rem;
            }

            .mobile-menu-toggle {
                display: flex;
            }
        }

        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .stat-card {
                padding: 1.5rem;
            }

            .welcome-message {
                font-size: 1.5rem;
            }

            .dashboard-card {
                padding: 1.5rem;
            }

            .header-actions {
                display: none;
            }
        }

        /* Chart container */
        .chart-container {
            width: 100%;
            height: 200px;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
<!-- Mobile Menu Toggle -->
<div class="mobile-menu-toggle" id="mobileMenuToggle">
    <i class="fas fa-bars"></i>
</div>

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/views/librarian/dashboard.jsp" class="sidebar-logo">
            <i class="fas fa-book-reader"></i>
            <span>LibraryMS</span>
        </a>
    </div>
    <ul class="nav-items">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/dashboard.jsp" class="nav-link active">
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
            <a href="${pageContext.request.contextPath}/views/librarian/view-books.jsp" class="nav-link">
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
            <a href="${pageContext.request.contextPath}/views/librarian/edit-book.jsp" class="nav-link ">
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
    <h1 class="header-title">
        <i class="fas fa-chart-line"></i>
        Dashboard
    </h1>
    <!-- Header Logout Button -->
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
                <h2 class="card-title">
                    <i class="fas fa-tags"></i>
                    Popular Categories
                </h2>
                <p class="card-subtitle">Top book categories in the library</p>
            </div>
            <ul class="category-list">
                <li class="category-item">
                        <span class="category-name">
                            <i class="fas fa-landmark"></i>
                            History
                        </span>
                    <div class="category-bar">
                        <div class="category-progress" style="width: 80%"></div>
                    </div>
                    <span class="category-count">4</span>
                </li>
                <li class="category-item">
                        <span class="category-name">
                            <i class="fas fa-flask"></i>
                            Science
                        </span>
                    <div class="category-bar">
                        <div class="category-progress" style="width: 75%"></div>
                    </div>
                    <span class="category-count">4</span>
                </li>
                <li class="category-item">
                        <span class="category-name">
                            <i class="fas fa-user-tie"></i>
                            Biography
                        </span>
                    <div class="category-bar">
                        <div class="category-progress" style="width: 60%"></div>
                    </div>
                    <span class="category-count">3</span>
                </li>
                <li class="category-item">
                        <span class="category-name">
                            <i class="fas fa-laptop-code"></i>
                            Technology
                        </span>
                    <div class="category-bar">
                        <div class="category-progress" style="width: 45%"></div>
                    </div>
                    <span class="category-count">2</span>
                </li>
                <li class="category-item">
                        <span class="category-name">
                            <i class="fas fa-paint-brush"></i>
                            Art & Design
                        </span>
                    <div class="category-bar">
                        <div class="category-progress" style="width: 40%"></div>
                    </div>
                    <span class="category-count">2</span>
                </li>
            </ul>
        </div>

        <!-- Recent Activity -->
        <div class="dashboard-card">
            <div class="card-header">
                <h2 class="card-title">
                    <i class="fas fa-history"></i>
                    Recent Activity
                </h2>
                <p class="card-subtitle">Latest borrowings and returns</p>
            </div>
            <ul class="activity-list">
                <li class="activity-item">
                    <div class="activity-icon borrowed">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 1</h4>
                        <p class="activity-date">
                            <i class="far fa-calendar-alt"></i>
                            Borrowed on 4/19/2025
                        </p>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon returned">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 14</h4>
                        <p class="activity-date">
                            <i class="far fa-calendar-alt"></i>
                            Returned on 4/29/2025
                        </p>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon returned">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 9</h4>
                        <p class="activity-date">
                            <i class="far fa-calendar-alt"></i>
                            Returned on 4/17/2025
                        </p>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon borrowed">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 12</h4>
                        <p class="activity-date">
                            <i class="far fa-calendar-alt"></i>
                            Borrowed on 4/7/2025
                        </p>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon returned">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="activity-content">
                        <h4 class="activity-title">Book Title 11</h4>
                        <p class="activity-date">
                            <i class="far fa-calendar-alt"></i>
                            Returned on 4/21/2025
                        </p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</main>

<script>
    // Mobile menu toggle functionality
    const mobileMenuToggle = document.getElementById('mobileMenuToggle');
    const sidebar = document.getElementById('sidebar');

    if (mobileMenuToggle) {
        mobileMenuToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');

            // Change icon based on sidebar state
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

    // Add animation on page load for stats cards
    document.addEventListener('DOMContentLoaded', function() {
        const statCards = document.querySelectorAll('.stat-card');

        statCards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 100 * index);
        });

        // Add pulse effect to highlight important stats
        const overdueCard = document.querySelector('.stat-icon.overdue');
        setInterval(() => {
            overdueCard.classList.add('pulse');
            setTimeout(() => {
                overdueCard.classList.remove('pulse');
            }, 1000);
        }, 5000);
    });
</script>
</body>
</html>