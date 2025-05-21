<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // Forward to StudentDashboardServlet to fetch data if not already present
    if (request.getAttribute("currentlyBorrowed") == null) {
        System.out.println("student/dashboard.jsp: No data found, forwarding to servlet");
        request.getRequestDispatcher("/student/dashboard").forward(request, response);
        return;
    }
    System.out.println("student/dashboard.jsp: Data found, rendering page");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - LibraryMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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

        .stat-icon.borrowed {
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

        /* Search box */
        .search-box {
            background: white;
            padding: 1.8rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2.5rem;
            transition: var(--transition);
        }

        .search-box:hover {
            box-shadow: var(--shadow-md);
        }

        .search-form {
            display: flex;
            gap: 1rem;
        }

        .search-input-group {
            flex: 1;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 1rem 1.2rem 1rem 3rem;
            border: 1px solid rgba(0,0,0,0.1);
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--light-color);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.2);
        }

        .search-icon {
            position: absolute;
            left: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .search-filter {
            width: 180px;
            padding: 1rem 1.2rem;
            border: 1px solid rgba(0,0,0,0.1);
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--light-color);
        }

        .search-filter:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.2);
        }

        .search-button {
            padding: 1rem 2rem;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 2px 10px rgba(108, 99, 255, 0.2);
        }

        .search-button:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(108, 99, 255, 0.3);
        }

        /* Borrowed Books */
        .book-list {
            list-style: none;
        }

        .book-item {
            display: flex;
            align-items: center;
            gap: 1.2rem;
            padding: 1.2rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            transition: var(--transition);
        }

        .book-item:last-child {
            border-bottom: none;
        }

        .book-item:hover {
            background: rgba(108, 99, 255, 0.02);
            transform: translateX(5px);
        }

        .book-cover {
            width: 50px;
            height: 70px;
            background: var(--gradient-bg);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            box-shadow: var(--shadow-sm);
        }

        .book-info {
            flex: 1;
        }

        .book-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
            font-size: 1.1rem;
        }

        .book-author {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }

        .book-dates {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-top: 0.5rem;
        }

        .book-date {
            font-size: 0.85rem;
            color: #666;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .book-date i {
            color: var(--primary-color);
            font-size: 0.9rem;
        }

        .book-date.overdue {
            color: var(--error-color);
            font-weight: 600;
        }

        .book-date.overdue i {
            color: var(--error-color);
        }

        .book-actions {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .book-button {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
        }

        .book-button.return {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .book-button.return:hover {
            background: rgba(16, 185, 129, 0.2);
        }

        .book-button.renew {
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
        }

        .book-button.renew:hover {
            background: rgba(108, 99, 255, 0.2);
        }

        /* Recent Searches */
        .recent-searches {
            margin-top: 1.5rem;
            display: flex;
            gap: 0.8rem;
            flex-wrap: wrap;
        }

        .recent-search-tag {
            padding: 0.4rem 1rem;
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
            border-radius: 20px;
            font-size: 0.9rem;
            transition: var(--transition);
            cursor: pointer;
        }

        .recent-search-tag:hover {
            background: rgba(108, 99, 255, 0.2);
            transform: translateY(-2px);
        }

        /* Interest Tags */
        .interest-tags {
            margin-top: 1.5rem;
            display: flex;
            gap: 0.8rem;
            flex-wrap: wrap;
        }

        .interest-tag {
            padding: 0.6rem 1.2rem;
            background: white;
            border: 1px solid rgba(108, 99, 255, 0.2);
            color: var(--primary-color);
            border-radius: 20px;
            font-size: 0.95rem;
            transition: var(--transition);
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .interest-tag:hover {
            background: rgba(108, 99, 255, 0.08);
            transform: translateY(-2px);
            border-color: var(--primary-color);
        }

        .interest-tag i {
            font-size: 0.9rem;
        }

        /* Fine Details */
        .fine-details {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 0.5rem;
            padding-top: 0.5rem;
            border-top: 1px dashed rgba(239, 68, 68, 0.2);
        }

        .fine-amount {
            color: var(--error-color);
            font-weight: 600;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .fine-amount i {
            font-size: 0.9rem;
        }

        .pay-button {
            padding: 0.4rem 1rem;
            background: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
            border: none;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
        }

        .pay-button:hover {
            background: rgba(239, 68, 68, 0.2);
        }

        /* Recommended Books */
        .recommended-books {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .recommended-book {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .recommended-book:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .recommended-book-cover {
            height: 120px;
            background: var(--gradient-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
        }

        .recommended-book-info {
            padding: 1rem;
        }

        .recommended-book-title {
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 0.3rem;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .recommended-book-author {
            color: #666;
            font-size: 0.85rem;
            margin-bottom: 0.8rem;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .borrow-button {
            width: 100%;
            padding: 0.5rem 0;
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
            border: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.9rem;
            cursor: pointer;
            transition: var(--transition);
        }

        .borrow-button:hover {
            background: var(--primary-color);
            color: white;
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

            .search-form {
                flex-direction: column;
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

            .recommended-books {
                grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
            }
        }

        .search-container {
            margin: 20px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .search-input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .search-button {
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .books-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        
        .book-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 15px;
            transition: transform 0.2s;
        }
        
        .book-card:hover {
            transform: translateY(-5px);
        }
        
        .book-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
        }
        
        .book-title {
            font-size: 1.2em;
            margin: 10px 0;
            color: #333;
        }
        
        .book-author {
            color: #666;
            margin-bottom: 10px;
        }
        
        .book-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        
        .status-available {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .status-unavailable {
            background: #ffebee;
            color: #c62828;
        }
        
        .borrow-button {
            width: 100%;
            padding: 10px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .borrow-button:hover {
            background: #45a049;
        }
        
        .borrow-button:disabled {
            background: #cccccc;
            cursor: not-allowed;
        }

        /* Alert Messages */
        .alert {
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            gap: 0.8rem;
            animation: slideIn 0.3s ease-out;
        }

        .alert i {
            font-size: 1.2rem;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .search-container {
            background: white;
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2.5rem;
            text-align: center;
        }

        .search-link {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1rem 2rem;
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: var(--transition);
        }

        .search-link:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: rgba(108, 99, 255, 0.05);
            border-radius: 8px;
            transition: var(--transition);
        }

        .activity-item:hover {
            transform: translateX(5px);
            background: rgba(108, 99, 255, 0.1);
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
        }

        .activity-details {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: var(--dark-color);
        }

        .activity-date {
            font-size: 0.9rem;
            color: #666;
        }
    </style>
</head>
<body>
<c:set var="activeTab" value="dashboard" scope="request"/>
<%@ include file="includes/sidebar.jsp" %>

<!-- Header -->
<header class="header">
    <h1 class="header-title">
        <i class="fas fa-home"></i>
        Student Dashboard
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
    <h1 class="welcome-message">Welcome, ${user.name}!</h1>

    <!-- Error/Success Messages -->
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i>
            ${sessionScope.error}
            </div>
        <c:remove var="error" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            ${sessionScope.success}
        </div>
        <c:remove var="success" scope="session" />
    </c:if>

    <!-- Quick Search Link -->
    <div class="search-container">
        <a href="${pageContext.request.contextPath}/student/search-books" class="search-link">
            <i class="fas fa-search"></i>
            Search and Borrow Books
        </a>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon borrowed">
                <i class="fas fa-book-open"></i>
            </div>
            <h3 class="stat-title">Currently Borrowed</h3>
            <div class="stat-value">
                ${currentlyBorrowed}
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon books">
                <i class="fas fa-history"></i>
            </div>
            <h3 class="stat-title">Total Borrowed</h3>
            <div class="stat-value">
                ${totalBorrowed}
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon overdue">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h3 class="stat-title">Overdue Books</h3>
            <div class="stat-value">
                ${overdueBooks}
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon fines">
                <i class="fas fa-rupee-sign"></i>
            </div>
            <h3 class="stat-title">Outstanding Fines</h3>
            <div class="stat-value">
                ₹${outstandingFines}
            </div>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="dashboard-grid">
        <div class="dashboard-card">
            <div class="card-header">
                <h2 class="card-title">
                    <i class="fas fa-clock"></i>
                    Recent Activity
                </h2>
            </div>
            <div class="activity-list">
                <c:choose>
                    <c:when test="${empty recentActivity}">
                        <div class="empty-state">
                            <i class="fas fa-history"></i>
                            <h3>No Recent Activity</h3>
                            <p>You haven't borrowed or returned any books recently.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="activity" items="${recentActivity}">
                            <div class="activity-item">
                                <div class="activity-icon ${empty activity.returnDate ? 'borrow' : 'return'}">
                                    <i class="fas ${empty activity.returnDate ? 'fa-arrow-circle-down' : 'fa-arrow-circle-up'}"></i>
                                </div>
                                <div class="activity-details">
                                    <h4 class="activity-title">
                                        ${empty activity.returnDate ? 'Borrowed' : 'Returned'}: ${activity.book.title}
                                    </h4>
                                    <p class="activity-date">
                                        <c:choose>
                                            <c:when test="${empty activity.returnDate}">
                                                <fmt:formatDate value="${activity.borrowDate}" pattern="MMMM d, yyyy"/>
                                                <span class="due-date">Due: <fmt:formatDate value="${activity.dueDate}" pattern="MMMM d, yyyy"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatDate value="${activity.returnDate}" pattern="MMMM d, yyyy"/>
                                                <c:if test="${not empty activity.fines && activity.fines[0].fineAmount.doubleValue() > 0}">
                                                    <span class="fine-amount">Fine: ₹${activity.fines[0].fineAmount}</span>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
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
</script>
</body>
</html>