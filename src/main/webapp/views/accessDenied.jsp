<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Access Denied</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5C6BC0;
            --secondary-color: #3F51B5;
            --dark-color: #303F9F;
            --light-color: #E8EAF6;
            --accent-color: #FF5722;
            --success-color: #4CAF50;
            --danger-color: #F44336;
            --gradient-bg: linear-gradient(135deg, #5C6BC0 0%, #3F51B5 100%);
            --shadow-sm: 0 2px 10px rgba(63, 81, 181, 0.1);
            --shadow-md: 0 4px 20px rgba(63, 81, 181, 0.15);
            --shadow-lg: 0 10px 40px rgba(63, 81, 181, 0.25);
            --border-radius: 14px;
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
        }

        body {
            background-color: var(--light-color);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"%3E%3Cpath fill="%236C63FF" fill-opacity="0.05" d="M0,96L48,112C96,128,192,160,288,154.7C384,149,480,107,576,112C672,117,768,171,864,186.7C960,203,1056,181,1152,154.7C1248,128,1344,96,1392,80L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"%3E%3C/path%3E%3C/svg%3E');
            background-repeat: no-repeat;
            background-position: bottom;
            background-size: 100% 50%;
        }

        .access-denied-container {
            width: 100%;
            max-width: 600px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            text-align: center;
            padding: 2rem;
        }

        .icon-container {
            width: 120px;
            height: 120px;
            margin: 0 auto 2rem;
            background-color: rgba(244, 67, 54, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .icon-container i {
            font-size: 3.5rem;
            color: var(--danger-color);
        }

        .title {
            color: var(--dark-color);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .message {
            color: #6B7280;
            font-size: 1.1rem;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            max-width: 300px;
            margin: 0 auto;
        }

        .btn {
            padding: 1rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: var(--transition);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            background: var(--gradient-bg);
            color: white;
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-outline {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            background-color: white;
        }

        .btn-outline:hover {
            background-color: var(--light-color);
        }

        .btn i {
            margin-right: 0.5rem;
        }

        @media (max-width: 576px) {
            .access-denied-container {
                box-shadow: none;
            }

            .title {
                font-size: 1.8rem;
            }

            .message {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="access-denied-container">
        <div class="icon-container">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h1 class="title">Access Denied</h1>
        <p class="message">Sorry, you don't have permission to access this page. This area is restricted to users with librarian privileges.</p>
        <div class="actions">
            <a href="<%=request.getContextPath()%>/dashboard/index.jsp" class="btn btn-primary">
                <i class="fas fa-home"></i> Go to Dashboard
            </a>
            <a href="<%=request.getContextPath()%>/logout" class="btn btn-outline">
                <i class="fas fa-sign-out-alt"></i> Sign Out
            </a>
        </div>
    </div>
</body>
</html>