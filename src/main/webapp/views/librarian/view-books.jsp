<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

    // Forward to ViewBooksServlet to fetch books before displaying the page
    if (request.getAttribute("books") == null) {
        System.out.println("view-books.jsp: No books attribute found, forwarding to servlet");
        request.getRequestDispatcher("/librarian/view-books").forward(request, response);
        return;
    }
    System.out.println("view-books.jsp: Found books attribute, size: " + ((java.util.List)request.getAttribute("books")).size());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Books - LibraryMS</title>
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
            background: var(--light-color);
        }

        /* Search Section Styles */
        .search-section {
            background: white;
            padding: 1.8rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            transition: var(--transition);
        }

        .search-section:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-3px);
        }

        .search-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-bg);
        }

        .search-title {
            margin-bottom: 1.2rem;
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .search-title i {
            color: var(--primary-color);
        }

        .search-container {
            display: flex;
            gap: 1rem;
            max-width: 100%;
            align-items: stretch;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 280px;
            display: flex;
            align-items: center;
            background: var(--light-color);
            border-radius: 12px;
            padding: 0 1.2rem;
            border: 2px solid transparent;
            transition: var(--transition);
        }

        .search-box:focus-within {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(108, 99, 255, 0.1);
        }

        .search-box i {
            color: #666;
            margin-right: 1rem;
            font-size: 1.1rem;
        }

        .search-input {
            flex: 1;
            padding: 1rem 0;
            border: none;
            background: none;
            font-size: 1rem;
            color: var(--dark-color);
            width: 100%;
        }

        .search-input:focus {
            outline: none;
        }

        .search-input::placeholder {
            color: #999;
        }

        .filters-container {
            display: flex;
            gap: 1rem;
            align-items: stretch;
        }

        .category-select {
            min-width: 200px;
            padding: 0 1.2rem;
            border: 2px solid var(--light-color);
            border-radius: 12px;
            background: white;
            color: var(--dark-color);
            font-size: 1rem;
            cursor: pointer;
            transition: var(--transition);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%236C63FF' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1.2rem center;
            padding-right: 3rem;
        }

        .category-select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(108, 99, 255, 0.1);
        }

        .view-toggle {
            display: flex;
            gap: 0.3rem;
            padding: 0.4rem;
            background: var(--light-color);
            border-radius: 12px;
            align-self: stretch;
        }

        .view-toggle button {
            padding: 0.7rem;
            border: none;
            background: none;
            border-radius: 8px;
            cursor: pointer;
            color: #666;
            transition: var(--transition);
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
        }

        .view-toggle button:hover {
            color: var(--primary-color);
            background: rgba(108, 99, 255, 0.05);
        }

        .view-toggle button.active {
            background: white;
            color: var(--primary-color);
            box-shadow: var(--shadow-sm);
        }

        .search-button {
            background: var(--gradient-bg);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 0 1.5rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }

        .search-button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .showing-results {
            margin: 1.5rem 0;
            font-size: 1rem;
            color: #666;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .showing-results i {
            color: var(--primary-color);
        }

        /* Books Grid Styles */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.8rem;
            margin-bottom: 3rem;
        }

        .book-card {
            background: white;
            border-radius: var(--card-radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            position: relative;
            cursor: pointer;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .book-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
        }

        .book-card::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--gradient-bg);
            opacity: 0;
            transition: var(--transition);
        }

        .book-card:hover::after {
            opacity: 1;
        }

        .book-cover-container {
            width: 100%;
            height: 320px;
            background-color: #f7f7f7;
            overflow: hidden;
            position: relative;
        }

        .book-cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .book-card:hover .book-cover {
            transform: scale(1.08);
        }

        .category-tag {
            position: absolute;
            top: 1rem;
            right: 1rem;
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(5px);
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--primary-color);
            box-shadow: var(--shadow-sm);
            z-index: 2;
        }

        .book-info {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .book-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            line-height: 1.3;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .book-author {
            color: #666;
            font-size: 1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .book-author i {
            color: var(--primary-color);
            font-size: 0.9rem;
            opacity: 0.7;
        }

        .book-isbn {
            color: #888;
            font-size: 0.85rem;
            margin-bottom: 1.2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .book-isbn i {
            color: var(--primary-color);
            font-size: 0.85rem;
            opacity: 0.7;
        }

        .book-status {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 1rem;
            border-top: 1px solid rgba(0,0,0,0.05);
        }

        .availability {
            font-size: 0.95rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .availability i {
            font-size: 0.9rem;
        }

        .available {
            color: var(--success-color);
        }

        .available i {
            color: var(--success-color);
        }

        .unavailable {
            color: var(--error-color);
        }

        .unavailable i {
            color: var(--error-color);
        }

        .action-buttons {
            display: flex;
            gap: 0.6rem;
        }

        .btn {
            padding: 0.6rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            font-size: 0.9rem;
            width: 36px;
            height: 36px;
        }

        .btn i {
            font-size: 1rem;
        }

        .btn-edit {
            background-color: var(--warning-color);
        }

        .btn-delete {
            background-color: var(--error-color);
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-3px);
            box-shadow: var(--shadow-sm);
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(42, 47, 79, 0.7);
            z-index: 1000;
            overflow-y: auto;
            padding: 3rem 2rem;
            backdrop-filter: blur(8px);
            transition: all 0.3s ease;
        }

        .modal-content {
            position: relative;
            background: white;
            width: 90%;
            max-width: 1000px;
            margin: 0 auto;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            transform: translateY(20px);
            opacity: 0;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        .modal.active .modal-content {
            transform: translateY(0);
            opacity: 1;
        }

        .modal-header {
            padding: 2rem 2.5rem;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            position: relative;
        }

        .modal-title {
            font-size: 2.2rem;
            color: var(--dark-color);
            margin: 0;
            font-weight: 800;
            line-height: 1.2;
        }

        .modal-subtitle {
            color: #666;
            margin-top: 0.8rem;
            font-size: 1.1rem;
            opacity: 0.8;
        }

        .modal-close {
            position: absolute;
            top: 2rem;
            right: 2rem;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: none;
            background: var(--light-color);
            color: #666;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            font-size: 1.2rem;
        }

        .modal-close:hover {
            background-color: var(--error-color);
            color: white;
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 2.5rem;
            display: grid;
            grid-template-columns: minmax(300px, 400px) 1fr;
            gap: 3rem;
            background: linear-gradient(to bottom, #ffffff, #f8f9fa);
        }

        .modal-cover-container {
            width: 100%;
            aspect-ratio: 3/4;
            background-color: #f7f7f7;
            border-radius: var(--card-radius);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            position: relative;
        }

        .modal-cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .modal-cover:hover {
            transform: scale(1.05);
        }

        .book-details {
            display: flex;
            flex-direction: column;
            gap: 2rem;
            padding-right: 1.5rem;
        }

        .detail-group {
            padding-bottom: 2rem;
            border-bottom: 1px solid rgba(0,0,0,0.08);
        }

        .detail-group:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .detail-label {
            font-size: 0.95rem;
            color: #666;
            margin-bottom: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-label i {
            color: var(--primary-color);
        }

        .detail-value {
            font-size: 1.3rem;
            color: var(--dark-color);
            font-weight: 600;
            line-height: 1.4;
        }

        .availability-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.8rem 1.5rem;
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border-radius: 30px;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .availability-badge.unavailable {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
        }

        .availability-badge i {
            font-size: 1.1rem;
        }

        .modal-actions {
            margin-top: auto;
            padding-top: 2rem;
            display: flex;
            gap: 1rem;
        }

        .modal-btn {
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 12px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            border: none;
            cursor: pointer;
        }

        .modal-btn-delete {
            background-color: var(--error-color);
            color: white;
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.2);
        }

        .modal-btn-delete:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.3);
        }

        .modal-btn-edit {
            background-color: var(--primary-color);
            color: white;
            box-shadow: 0 5px 15px rgba(108, 99, 255, 0.2);
        }

        .modal-btn-edit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(108, 99, 255, 0.3);
        }

        /* Empty state styles */
        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            opacity: 0.5;
        }

        .empty-state h2 {
            margin-bottom: 1rem;
            color: var(--dark-color);
            font-size: 1.8rem;
            font-weight: 700;
        }

        .empty-state p {
            color: #666;
            font-size: 1.1rem;
            max-width: 500px;
            margin: 0 auto 2rem;
        }

        .empty-state-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1rem 2rem;
            background: var(--gradient-bg);
            color: white;
            font-weight: 600;
            border-radius: 12px;
            text-decoration: none;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }

        .empty-state-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        /* Mobile menu toggle */
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

        /* List view */
        .books-list {
            display: none;
            flex-direction: column;
            gap: 1rem;
        }

        .book-list-item {
            background: white;
            border-radius: var(--card-radius);
            padding: 1.2rem;
            display: flex;
            gap: 1.5rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            cursor: pointer;
        }

        .book-list-item:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .book-list-cover {
            width: 80px;
            height: 120px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
        }

        .book-list-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-list-info {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .book-list-title {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .book-list-author {
            color: #666;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .book-list-isbn {
            color: #888;
            font-size: 0.85rem;
            margin-bottom: 0.8rem;
        }

        .book-list-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .modal-body {
                gap: 2rem;
            }
        }

        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
                gap: 1.2rem;
            }

            .search-container {
                flex-direction: column;
            }

            .filters-container {
                width: 100%;
            }

            .category-select {
                flex: 1;
            }

            .book-cover-container {
                height: 280px;
            }

            .modal-body {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .modal-cover-container {
                max-width: 300px;
                margin: 0 auto;
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

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }

            .mobile-menu-toggle {
                display: flex;
            }

            .book-list-item {
                flex-direction: column;
                align-items: center;
                text-align: center;
                padding: 1.5rem;
            }

            .book-list-cover {
                width: 120px;
                height: 180px;
                margin-bottom: 1rem;
            }

            .book-list-actions {
                flex-direction: column-reverse;
                gap: 1rem;
            }
        }

        @media (max-width: 576px) {
            .books-grid {
                grid-template-columns: 1fr;
            }

            .search-section,
            .book-card,
            .empty-state {
                border-radius: 12px;
            }

            .modal {
                padding: 1rem;
            }

            .modal-header {
                padding: 1.5rem;
            }

            .modal-title {
                font-size: 1.8rem;
            }

            .modal-body {
                padding: 1.5rem;
            }

            .modal-actions {
                flex-direction: column;
                gap: 1rem;
            }

            .modal-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
    <script>
        // Global variables
        let currentBookId = null;
        
        // Book deletion functionality
        function confirmAndDeleteBook(bookId, event) {
            if (event) {
                event.stopPropagation();
            }
            
            if (confirm('Are you sure you want to delete this book? This action cannot be undone.')) {
                // Redirect directly to the delete URL
                window.location.href = '${pageContext.request.contextPath}/librarian/delete-book?id=' + bookId;
            }
        }
        
        // Show book details in modal
        function showBookDetails(id, title, author, isbn, category, quantity, coverImage) {
            currentBookId = id;
            const modal = document.getElementById('bookModal');
            const modalTitle = document.getElementById('modalTitle');
            const modalAuthor = document.getElementById('modalAuthor');
            const modalCategory = document.getElementById('modalCategory');
            const modalIsbn = document.getElementById('modalIsbn');
            const modalAvailability = document.getElementById('modalAvailability');
            const modalCover = document.getElementById('modalCover');
            const availabilityBadge = document.getElementById('availabilityBadge');
            const availabilityIcon = document.getElementById('availabilityIcon');

            // Set text content
            modalTitle.textContent = title;
            modalAuthor.textContent = author;
            modalCategory.textContent = category;
            modalIsbn.textContent = isbn;
            modalAvailability.textContent = `${quantity} copies available`;

            // Update availability status
            if (quantity > 0) {
                availabilityBadge.className = 'availability-badge';
                availabilityIcon.className = 'fas fa-check-circle';
            } else {
                availabilityBadge.className = 'availability-badge unavailable';
                availabilityIcon.className = 'fas fa-times-circle';
            }

            // Handle cover image
            const defaultCover = '${pageContext.request.contextPath}/assets/images/default-book-cover.svg';

            if (coverImage && coverImage.trim() !== '') {
                const imagePath = '${pageContext.request.contextPath}/uploads/books/' + coverImage;
                modalCover.src = imagePath;
                modalCover.onerror = function() {
                    console.log('Failed to load image:', imagePath);
                    this.onerror = null;
                    this.src = defaultCover;
                };
            } else {
                modalCover.src = defaultCover;
            }

            // Show modal with animation
            modal.style.display = 'block';
            document.body.style.overflow = 'hidden';

            // Add active class after a brief delay for animation
            setTimeout(() => {
                modal.classList.add('active');
            }, 10);
        }
        
        function closeModal() {
            const modal = document.getElementById('bookModal');
            modal.classList.remove('active');

            // Wait for animation to finish before hiding
            setTimeout(() => {
                modal.style.display = 'none';
                document.body.style.overflow = 'auto';
            }, 300);
        }
        
        // Initialize page when DOM is loaded
        document.addEventListener('DOMContentLoaded', function() {
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

            // View toggle functionality
            const gridViewBtn = document.getElementById('gridViewBtn');
            const listViewBtn = document.getElementById('listViewBtn');
            const booksGrid = document.getElementById('booksGrid');
            const booksList = document.getElementById('booksList');

            if (gridViewBtn && listViewBtn) {
                gridViewBtn.addEventListener('click', function() {
                    booksGrid.style.display = 'grid';
                    booksList.style.display = 'none';
                    gridViewBtn.classList.add('active');
                    listViewBtn.classList.remove('active');

                    // Save preference to localStorage
                    localStorage.setItem('libraryViewPreference', 'grid');
                });

                listViewBtn.addEventListener('click', function() {
                    booksGrid.style.display = 'none';
                    booksList.style.display = 'flex';
                    listViewBtn.classList.add('active');
                    gridViewBtn.classList.remove('active');

                    // Save preference to localStorage
                    localStorage.setItem('libraryViewPreference', 'list');
                });
                
                // Load user's saved view preference
                const viewPreference = localStorage.getItem('libraryViewPreference');

                if (viewPreference === 'list') {
                    listViewBtn.click();
                } else {
                    // Default to grid view
                    gridViewBtn.click();
                }
            }

            // Add animations for cards
            const bookCards = document.querySelectorAll('.book-card, .book-list-item');
            bookCards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 50 * index);
            });
            
            // Close modal when clicking outside
            window.onclick = function(event) {
                const modal = document.getElementById('bookModal');
                if (event.target === modal) {
                    closeModal();
                }
            };

            // Allow closing modal with ESC key
            document.addEventListener('keydown', function(event) {
                if (event.key === 'Escape') {
                    closeModal();
                }
            });

            // Form search on enter key
            const searchInput = document.querySelector('.search-input');
            if (searchInput) {
                searchInput.addEventListener('keypress', function(event) {
                    if (event.key === 'Enter') {
                        event.preventDefault();
                        this.closest('form').submit();
                    }
                });
            }
        });
    </script>
</head>
<body>
<!-- Include the common sidebar -->
<jsp:include page="../components/sidebar.jsp">
    <jsp:param name="activePage" value="view-books"/>
</jsp:include>

<!-- Header -->
<header class="header">
    <h1 class="header-title">
        <i class="fas fa-book"></i>
        View Books
    </h1>
</header>

<!-- Main Content -->
<main class="main-content">
    <!-- Display success and error messages -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success" style="background-color: rgba(16, 185, 129, 0.1); color: #10b981; padding: 1rem; margin-bottom: 1.5rem; border-radius: 8px; font-weight: 500; display: flex; align-items: center; gap: 0.8rem;">
            <i class="fas fa-check-circle" style="font-size: 1.2rem;"></i>
            ${sessionScope.successMessage}
        </div>
        <c:remove var="successMessage" scope="session" />
    </c:if>
    
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger" style="background-color: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 1rem; margin-bottom: 1.5rem; border-radius: 8px; font-weight: 500; display: flex; align-items: center; gap: 0.8rem;">
            <i class="fas fa-exclamation-circle" style="font-size: 1.2rem;"></i>
            ${sessionScope.errorMessage}
        </div>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <div class="search-section">
        <h2 class="search-title">
            <i class="fas fa-search"></i>
            Search Books
        </h2>
        <form action="${pageContext.request.contextPath}/librarian/view-books" method="GET" class="search-container">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" name="search" class="search-input"
                       placeholder="Search books by title, author, or ISBN..."
                       value="${param.search}">
            </div>
            <div class="filters-container">
                <select class="category-select" name="category">
                    <option value="">All Categories</option>
                    <option value="Fiction" ${param.category == 'Fiction' ? 'selected' : ''}>Fiction</option>
                    <option value="Non-Fiction" ${param.category == 'Non-Fiction' ? 'selected' : ''}>Non-Fiction</option>
                    <option value="Science" ${param.category == 'Science' ? 'selected' : ''}>Science</option>
                    <option value="Technology" ${param.category == 'Technology' ? 'selected' : ''}>Technology</option>
                    <option value="History" ${param.category == 'History' ? 'selected' : ''}>History</option>
                    <option value="Philosophy" ${param.category == 'Philosophy' ? 'selected' : ''}>Philosophy</option>
                    <option value="Biography" ${param.category == 'Biography' ? 'selected' : ''}>Biography</option>
                    <option value="Business" ${param.category == 'Business' ? 'selected' : ''}>Business</option>
                    <option value="Computers" ${param.category == 'Computers' ? 'selected' : ''}>Computers</option>
                    <option value="Art" ${param.category == 'Art' ? 'selected' : ''}>Art & Design</option>
                </select>
                <div class="view-toggle" id="viewToggle">
                    <button type="button" class="active" id="gridViewBtn" title="Grid View">
                        <i class="fas fa-th-large"></i>
                    </button>
                    <button type="button" id="listViewBtn" title="List View">
                        <i class="fas fa-list"></i>
                    </button>
                </div>
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                    Search
                </button>
            </div>
        </form>
    </div>

    <c:if test="${not empty books}">
        <p class="showing-results">
            <i class="fas fa-filter"></i>
            Showing ${books.size()} books
            <c:if test="${not empty param.search}">
                for "<strong>${param.search}</strong>"
            </c:if>
            <c:if test="${not empty param.category}">
                in <strong>${param.category}</strong> category
            </c:if>
        </p>
    </c:if>

    <!-- Grid View -->
    <div class="books-grid" id="booksGrid">
        <c:choose>
            <c:when test="${not empty books}">
                <c:forEach items="${books}" var="book">
                    <div class="book-card" onclick="showBookDetails(
                        ${book.id},
                            '${fn:replace(book.title, "'", "\\'")}',
                            '${fn:replace(requestScope['author_'.concat(book.id)].authorName, "'", "\\'")}',
                            '${book.isbn}',
                            '${book.category}',
                        ${book.quantity},
                            '${fn:replace(book.coverImage, "'", "\\'")}'
                            )">
                        <div class="book-cover-container">
                            <span class="category-tag">${book.category}</span>
                            <c:choose>
                                <c:when test="${not empty book.coverImage}">
                                    <img src="${pageContext.request.contextPath}/uploads/books/${book.coverImage}"
                                         alt="Cover of ${book.title}"
                                         class="book-cover"
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-book-cover.svg'"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/default-book-cover.svg"
                                         alt="Default book cover"
                                         class="book-cover"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="book-info">
                            <h3 class="book-title">${book.title}</h3>
                            <p class="book-author">
                                <i class="fas fa-user-edit"></i>
                                    ${requestScope['author_'.concat(book.id)].authorName}
                            </p>
                            <p class="book-isbn">
                                <i class="fas fa-barcode"></i>
                                ISBN: ${book.isbn}
                            </p>
                            <div class="book-status">
                                    <span class="availability ${book.quantity > 0 ? 'available' : 'unavailable'}">
                                        <i class="fas ${book.quantity > 0 ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                        ${book.quantity} copies available
                                    </span>
                                <div class="action-buttons">
                                    <button onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/librarian/edit-book?id=${book.id}'"
                                            class="btn btn-edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button onclick="confirmAndDeleteBook(${book.id}, event)" 
                                            class="btn btn-delete" title="Delete">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-books"></i>
                    <h2>No Books Found</h2>
                    <p>Try adjusting your search criteria or add new books to the library collection.</p>
                    <a href="${pageContext.request.contextPath}/views/librarian/add-books.jsp" class="empty-state-btn">
                        <i class="fas fa-plus-circle"></i>
                        Add New Book
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- List View -->
    <div class="books-list" id="booksList">
        <c:if test="${not empty books}">
            <c:forEach items="${books}" var="book">
                <div class="book-list-item" onclick="showBookDetails(
                    ${book.id},
                        '${fn:replace(book.title, "'", "\\'")}',
                        '${fn:replace(requestScope['author_'.concat(book.id)].authorName, "'", "\\'")}',
                        '${book.isbn}',
                        '${book.category}',
                    ${book.quantity},
                        '${fn:replace(book.coverImage, "'", "\\'")}'
                        )">
                    <div class="book-list-cover">
                        <c:choose>
                            <c:when test="${not empty book.coverImage}">
                                <img src="${pageContext.request.contextPath}/uploads/books/${book.coverImage}"
                                     alt="Cover of ${book.title}"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-book-cover.svg'"/>
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/images/default-book-cover.svg"
                                     alt="Default book cover"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="book-list-info">
                        <h3 class="book-list-title">${book.title}</h3>
                        <p class="book-list-author">
                            <i class="fas fa-user-edit"></i>
                                ${requestScope['author_'.concat(book.id)].authorName}
                        </p>
                        <p class="book-list-isbn">
                            <i class="fas fa-barcode"></i>
                            ISBN: ${book.isbn} | Category: ${book.category}
                        </p>
                        <div class="book-list-actions">
                                <span class="availability ${book.quantity > 0 ? 'available' : 'unavailable'}">
                                    <i class="fas ${book.quantity > 0 ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                    ${book.quantity} copies available
                                </span>
                            <div class="action-buttons">
                                <button onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/librarian/edit-book?id=${book.id}'"
                                        class="btn btn-edit" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button onclick="confirmAndDeleteBook(${book.id}, event)"
                                        class="btn btn-delete" title="Delete">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>
</main>

<!-- Book Details Modal -->
<div id="bookModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title" id="modalTitle"></h2>
            <p class="modal-subtitle">Complete book details</p>
            <button class="modal-close" onclick="closeModal()">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div class="modal-body">
            <div class="modal-cover-container">
                <img id="modalCover" class="modal-cover" alt="Book cover">
            </div>

            <div class="book-details">
                <div class="detail-group">
                    <div class="detail-label">
                        <i class="fas fa-user-edit"></i>
                        Author
                    </div>
                    <div class="detail-value" id="modalAuthor"></div>
                </div>

                <div class="detail-group">
                    <div class="detail-label">
                        <i class="fas fa-tag"></i>
                        Category
                    </div>
                    <div class="detail-value" id="modalCategory"></div>
                </div>

                <div class="detail-group">
                    <div class="detail-label">
                        <i class="fas fa-barcode"></i>
                        ISBN
                    </div>
                    <div class="detail-value" id="modalIsbn"></div>
                </div>

                <div class="detail-group">
                    <div class="detail-label">
                        <i class="fas fa-info-circle"></i>
                        Availability
                    </div>
                    <div class="detail-value">
                            <span class="availability-badge" id="availabilityBadge">
                                <i class="fas fa-check-circle" id="availabilityIcon"></i>
                                <span id="modalAvailability"></span>
                            </span>
                    </div>
                </div>

                <div class="modal-actions">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/views/librarian/edit-books.jsp?id=' + currentBookId" class="modal-btn modal-btn-edit">
                        <i class="fas fa-edit"></i> Edit Book
                    </button>
                    <button onclick="confirmAndDeleteBook(currentBookId)" class="modal-btn modal-btn-delete">
                        <i class="fas fa-trash-alt"></i> Delete Book
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>