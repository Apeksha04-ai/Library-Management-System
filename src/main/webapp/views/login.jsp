<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 4/20/2025
  Time: 9:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Log In</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #5C6BC0;
            --secondary-color: #3F51B5;
            --dark-color: #303F9F;
            --light-color: #E8EAF6;
            --accent-color: #FF5722;
            --success-color: #4CAF50;
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

        .login-container {
            width: 100%;
            max-width: 1000px;
            min-height: 600px;
            display: flex;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            background-color: white;
            overflow: hidden;
            position: relative;
        }

        .login-sidebar {
            flex: 0 0 50%;
            background: var(--gradient-bg);
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 3rem;
            position: relative;
            overflow: hidden;
            color: white;
        }

        .login-sidebar::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"%3E%3Cpath fill="white" fill-opacity="0.1" d="M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z"%3E%3C/path%3E%3C/svg%3E');
            z-index: 0;
        }

        .logo {
            position: absolute;
            top: 2rem;
            left: 3rem;
            display: flex;
            align-items: center;
            z-index: 1;
        }

        .logo i {
            font-size: 1.8rem;
            margin-right: 0.8rem;
        }

        .logo h3 {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .sidebar-content {
            position: relative;
            z-index: 1;
        }

        .heading {
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            line-height: 1.2;
        }

        .sidebar-text {
            font-size: 1.1rem;
            margin-bottom: 2.5rem;
            line-height: 1.6;
            opacity: 0.9;
        }

        .feature-list {
            margin-top: 1rem;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.2rem;
        }

        .feature-icon {
            width: 32px;
            height: 32px;
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .feature-icon i {
            font-size: 1rem;
        }

        .feature-text {
            font-size: 0.95rem;
            line-height: 1.4;
        }

        .floating-shapes {
            position: absolute;
            bottom: 2rem;
            right: 2rem;
            width: 200px;
            height: 100px;
            z-index: 0;
        }

        .shape {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
        }

        .shape-1 {
            width: 80px;
            height: 80px;
            bottom: 0;
            right: 0;
            animation: float 8s ease-in-out infinite;
        }

        .shape-2 {
            width: 60px;
            height: 60px;
            bottom: 40px;
            right: 80px;
            animation: float 6s ease-in-out infinite;
            animation-delay: 1s;
        }

        .shape-3 {
            width: 40px;
            height: 40px;
            bottom: 80px;
            right: 40px;
            animation: float 4s ease-in-out infinite;
            animation-delay: 2s;
        }

        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0); }
        }

        .login-form {
            flex: 0 0 50%;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            margin-bottom: 2rem;
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            font-size: 1rem;
            color: #6B7280;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.6rem;
        }

        .form-input-container {
            position: relative;
        }

        .form-input {
            width: 100%;
            padding: 0.95rem 1rem 0.95rem 3rem;
            border: 2px solid #E5E7EB;
            border-radius: 12px;
            font-size: 1rem;
            color: var(--dark-color);
            transition: var(--transition);
            background-color: #F9FAFB;
        }

        .form-input:focus {
            border-color: var(--primary-color);
            background-color: white;
            outline: none;
            box-shadow: var(--shadow-sm);
        }

        .form-input::placeholder {
            color: #A1A1AA;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.1rem;
            color: #A1A1AA;
            transition: var(--transition);
        }

        .form-input:focus + .input-icon {
            color: var(--primary-color);
        }

        .error-message {
            display: none;
            color: var(--accent-color);
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .remember-me {
            display: flex;
            align-items: center;
        }

        .remember-checkbox {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            appearance: none;
            -webkit-appearance: none;
            background-color: #F9FAFB;
            border: 2px solid #E5E7EB;
            border-radius: 4px;
            cursor: pointer;
            position: relative;
            transition: var(--transition);
        }

        .remember-checkbox:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .remember-checkbox:checked::after {
            content: '✓';
            position: absolute;
            color: white;
            font-size: 14px;
            font-weight: bold;
            left: 4px;
            top: -1px;
        }

        .remember-text {
            font-size: 0.9rem;
            color: #6B7280;
        }

        .forgot-link {
            font-size: 0.9rem;
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
        }

        .forgot-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        .login-btn {
            width: 100%;
            padding: 1rem;
            background: var(--gradient-bg);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-md);
            margin-bottom: 1.5rem;
            position: relative;
            overflow: hidden;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .btn-text {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-icon {
            margin-left: 0.5rem;
            font-size: 1rem;
        }

        .login-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, rgba(255,255,255,0) 0%, rgba(255,255,255,0.2) 50%, rgba(255,255,255,0) 100%);
            transform: translateX(-100%);
            transition: transform 0.6s;
        }

        .login-btn:hover::before {
            transform: translateX(100%);
        }

        .register-prompt {
            text-align: center;
            font-size: 0.95rem;
            color: #6B7280;
        }

        .register-link {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }

        .register-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        .system-error {
            background-color: #FEF2F2;
            color: #DC2626;
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
            display: none;
            border-left: 4px solid #DC2626;
        }

        .system-error i {
            margin-right: 0.5rem;
        }

        .system-success {
            background-color: #F0FDF4;
            color: #166534;
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
            display: none;
            border-left: 4px solid #10B981;
        }

        .system-success i {
            margin-right: 0.5rem;
        }

        @media (max-width: 992px) {
            .login-container {
                flex-direction: column;
                max-width: 600px;
            }

            .login-sidebar, .login-form {
                flex: none;
                width: 100%;
            }

            .login-sidebar {
                padding: 3rem 2rem;
            }

            .login-form {
                padding: 3rem 2rem;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 1rem;
            }

            .login-container {
                box-shadow: none;
                background: transparent;
            }

            .login-sidebar {
                border-radius: var(--border-radius) var(--border-radius) 0 0;
                padding: 2rem 1.5rem;
            }

            .logo {
                top: 1.5rem;
                left: 1.5rem;
            }

            .heading {
                font-size: 2.2rem;
            }

            .login-form {
                background: white;
                border-radius: 0 0 var(--border-radius) var(--border-radius);
                padding: 2rem 1.5rem;
            }

            .feature-list {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-sidebar">
        <div class="logo">
            <i class="fas fa-book-reader"></i>
            <h3>LibraryMS</h3>
        </div>

        <div class="sidebar-content">
            <h1 class="heading">Welcome Back to Our Library Management System</h1>
            <p class="sidebar-text">Log in to access our vast collection of books and manage your borrowings.</p>

            <div class="feature-list">
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-search"></i>
                    </div>
                    <div class="feature-text">
                        <strong>Advanced Search</strong><br>
                        Find books by title, author, genre, or ISBN
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="feature-text">
                        <strong>24/7 Access</strong><br>
                        Access your account anytime, anywhere
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="feature-text">
                        <strong>Personalized Recommendations</strong><br>
                        Get book suggestions based on your reading history
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-history"></i>
                    </div>
                    <div class="feature-text">
                        <strong>Borrowing History</strong><br>
                        Track all your past and current borrowings
                    </div>
                </div>
            </div>
        </div>

        <div class="floating-shapes">
            <div class="shape shape-1"></div>
            <div class="shape shape-2"></div>
            <div class="shape shape-3"></div>
        </div>
    </div>

    <div class="login-form">
        <div class="form-header">
            <h2 class="form-title">Sign In</h2>
            <p class="form-subtitle">Please enter your credentials to continue</p>
        </div>

        <% if(request.getAttribute("error") != null) { %>
        <div class="system-error" style="display: block;">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <% if(session.getAttribute("registrationSuccess") != null) { %>
        <div class="system-success" style="display: block; background-color: #F0FDF4; color: #166534; padding: 1rem; border-radius: 12px; margin-bottom: 1.5rem; font-size: 0.95rem; border-left: 4px solid #10B981;">
            <i class="fas fa-check-circle"></i> <%= session.getAttribute("registrationSuccess") %>
            <% session.removeAttribute("registrationSuccess"); %>
        </div>
        <% } %>

        <form action="<%=request.getContextPath()%>/loginServlet" method="post" id="loginForm">
            <div class="form-group">
                <label class="form-label" for="email">Email Address</label>
                <div class="form-input-container">
                    <input type="email" id="email" name="email" class="form-input" placeholder="Enter your email address" required>
                    <i class="fas fa-envelope input-icon"></i>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <div class="form-input-container">
                    <input type="password" id="password" name="password" class="form-input" placeholder="Enter your password" required>
                    <i class="fas fa-lock input-icon"></i>
                </div>
            </div>

            <div class="remember-forgot">
                <div class="remember-me">
                    <input type="checkbox" id="rememberMe" name="rememberMe" class="remember-checkbox">
                    <label for="rememberMe" class="remember-text">Remember me</label>
                </div>
                <a href="#" class="forgot-link">Forgot password?</a>
            </div>

            <button type="submit" class="login-btn">
                <span class="btn-text">
                  Sign In <i class="fas fa-sign-in-alt btn-icon"></i>
                </span>
            </button>

            <div class="register-prompt">
                Don't have an account? <a href="<%=request.getContextPath()%>/views/register.jsp" class="register-link">Sign up</a>
            </div>
        </form>
    </div>
</div>

<script>
    // Basic form validation
    const loginForm = document.getElementById('loginForm');

    loginForm.addEventListener('submit', function(event) {
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        if (!email || !password) {
            event.preventDefault();
            alert('Please enter both email and password.');
        }
    });

    // Show/hide password functionality
    const passwordInput = document.getElementById('password');
    const passwordIcon = passwordInput.nextElementSibling;

    passwordIcon.addEventListener('click', function() {
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            passwordIcon.classList.remove('fa-lock');
            passwordIcon.classList.add('fa-unlock');
        } else {
            passwordInput.type = 'password';
            passwordIcon.classList.remove('fa-unlock');
            passwordIcon.classList.add('fa-lock');
        }
    });
</script>
</body>
</html>