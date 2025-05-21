<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout - LibraryMS</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logout-container {
            max-width: 500px;
            width: 90%;
            background: white;
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            padding: 3rem 2rem;
            text-align: center;
            animation: fadeIn 0.5s ease forwards;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logout-icon {
            width: 80px;
            height: 80px;
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2.5rem;
        }

        .logout-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .logout-message {
            color: #666;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            cursor: pointer;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
        }

        .footer-text {
            margin-top: 2rem;
            color: #888;
            font-size: 0.9rem;
        }

        /* Auto-redirect progress bar */
        .redirect-container {
            width: 100%;
            margin-top: 2rem;
        }

        .redirect-text {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .progress-bar {
            height: 6px;
            width: 100%;
            background-color: #eee;
            border-radius: 3px;
            overflow: hidden;
            position: relative;
        }

        .progress {
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            background-color: var(--primary-color);
            width: 0%;
            animation: progress 5s linear forwards;
        }

        @keyframes progress {
            0% {
                width: 0%;
            }
            100% {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Include the common sidebar -->
    <jsp:include page="../components/sidebar.jsp">
        <jsp:param name="activePage" value="logout"/>
    </jsp:include>

    <!-- Header -->
    <header class="header">
        <h1 class="header-title">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </h1>
    </header>

    <div class="logout-container">
        <div class="logout-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h1 class="logout-title">You've Been Logged Out</h1>
        <p class="logout-message">Thank you for using LibraryMS. You have been successfully logged out. For security reasons, please close your browser if you're on a shared device.</p>

        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
            <i class="fas fa-sign-in-alt"></i>
            <span>Login Again</span>
        </a>

        <div class="redirect-container">
            <p class="redirect-text">Redirecting to login page in 5 seconds...</p>
            <div class="progress-bar">
                <div class="progress"></div>
            </div>
        </div>

        <p class="footer-text">© 2025 LibraryMS. All rights reserved.</p>
    </div>

    <script>
        // Auto redirect after 5 seconds
        setTimeout(function() {
            window.location.href = "${pageContext.request.contextPath}/login";
        }, 5000);
    </script>
</body>
</html>