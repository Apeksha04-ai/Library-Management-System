<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Sign Up</title>
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

        .signup-container {
            width: 100%;
            max-width: 1100px;
            min-height: 680px;
            display: flex;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            background-color: white;
            overflow: hidden;
            position: relative;
        }

        .signup-sidebar {
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

        .signup-sidebar::before {
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

        .benefit-list {
            margin-top: 1rem;
        }

        .benefit-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.2rem;
        }

        .benefit-icon {
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

        .benefit-icon i {
            font-size: 1rem;
        }

        .benefit-text {
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

        .signup-form {
            flex: 0 0 50%;
            padding: 3rem 3rem;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            overflow-y: auto;
            max-height: 680px;
        }

        .form-header {
            margin-bottom: 1.5rem;
        }

        .form-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            font-size: 1rem;
            color: #6B7280;
        }

        .form-row {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .form-col {
            flex: 1;
        }

        .form-group {
            margin-bottom: 1.25rem;
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

        .role-selector {
            display: flex;
            border: 2px solid #E5E7EB;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .role-option {
            flex: 1;
            padding: 1rem;
            text-align: center;
            background-color: #F9FAFB;
            color: #6B7280;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            position: relative;
        }

        .role-option.active {
            background-color: var(--primary-color);
            color: white;
        }

        .role-option:first-child {
            border-right: 1px solid #E5E7EB;
        }

        .role-option:hover:not(.active) {
            background-color: #EBEDF0;
        }

        .role-option input {
            position: absolute;
            opacity: 0;
        }

        .role-icon {
            margin-right: 0.5rem;
        }

        .profile-upload {
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .profile-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #F9FAFB;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            border: 2px dashed #E5E7EB;
            overflow: hidden;
            position: relative;
            cursor: pointer;
            transition: var(--transition);
        }

        .profile-preview:hover {
            border-color: var(--primary-color);
            background-color: #F0F4FF;
        }

        .profile-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .profile-preview i {
            font-size: 2.5rem;
            color: #A1A1AA;
            transition: var(--transition);
        }

        .profile-preview:hover i {
            color: var(--primary-color);
        }

        .profile-upload input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: 0;
            cursor: pointer;
        }

        .profile-text {
            font-size: 0.9rem;
            color: #6B7280;
        }

        .terms-container {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.25rem;
        }

        .terms-checkbox {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            margin-top: 2px;
            appearance: none;
            -webkit-appearance: none;
            background-color: #F9FAFB;
            border: 2px solid #E5E7EB;
            border-radius: 4px;
            cursor: pointer;
            position: relative;
            transition: var(--transition);
        }

        .terms-checkbox:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .terms-checkbox:checked::after {
            content: '✓';
            position: absolute;
            color: white;
            font-size: 14px;
            font-weight: bold;
            left: 4px;
            top: -1px;
        }

        .terms-text {
            font-size: 0.9rem;
            color: #6B7280;
            line-height: 1.5;
        }

        .terms-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }

        .terms-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        .submit-btn {
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
            margin-bottom: 1.25rem;
            position: relative;
            overflow: hidden;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .submit-btn:active {
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

        .submit-btn::before {
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

        .submit-btn:hover::before {
            transform: translateX(100%);
        }

        .login-prompt {
            text-align: center;
            font-size: 0.95rem;
            color: #6B7280;
        }

        .login-link {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }

        .login-link:hover {
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

        .password-strength {
            height: 5px;
            background-color: #E5E7EB;
            border-radius: 2.5px;
            margin-top: 0.5rem;
            overflow: hidden;
        }

        .strength-meter {
            height: 100%;
            width: 0;
            border-radius: 2.5px;
            transition: var(--transition);
        }

        .strength-text {
            font-size: 0.8rem;
            margin-top: 0.4rem;
            display: flex;
            justify-content: space-between;
        }

        .strength-label {
            font-weight: 600;
        }

        @media (max-width: 992px) {
            .signup-container {
                flex-direction: column;
                max-width: 600px;
            }

            .signup-sidebar, .signup-form {
                flex: none;
                width: 100%;
            }

            .signup-sidebar {
                padding: 3rem 2rem;
            }

            .signup-form {
                padding: 3rem 2rem;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 1rem;
            }

            .signup-container {
                box-shadow: none;
                background: transparent;
            }

            .signup-sidebar {
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

            .signup-form {
                background: white;
                border-radius: 0 0 var(--border-radius) var(--border-radius);
                padding: 2rem 1.5rem;
            }

            .benefit-list {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="signup-container">
    <div class="signup-sidebar">
        <div class="logo">
            <i class="fas fa-book-reader"></i>
            <h3>LibraryMS</h3>
        </div>

        <div class="sidebar-content">
            <h1 class="heading">Join Our Library Management System</h1>
            <p class="sidebar-text">Create an account to access our comprehensive library services and resources.</p>

            <div class="benefit-list">
                <div class="benefit-item">
                    <div class="benefit-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="benefit-text">
                        <strong>Extensive Book Catalog</strong><br>
                        Access thousands of books across various categories
                    </div>
                </div>
                <div class="benefit-item">
                    <div class="benefit-icon">
                        <i class="fas fa-history"></i>
                    </div>
                    <div class="benefit-text">
                        <strong>Borrowing History</strong><br>
                        Keep track of your borrowing activities
                    </div>
                </div>
                <div class="benefit-item">
                    <div class="benefit-icon">
                        <i class="fas fa-bell"></i>
                    </div>
                    <div class="benefit-text">
                        <strong>Due Date Notifications</strong><br>
                        Receive timely reminders for book returns
                    </div>
                </div>
                <div class="benefit-item">
                    <div class="benefit-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="benefit-text">
                        <strong>Analytics Dashboard</strong><br>
                        Access usage statistics and reading trends
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

    <div class="signup-form">
        <div class="form-header">
            <h2 class="form-title">Create Your Account</h2>
            <p class="form-subtitle">Please fill in your details to register</p>
        </div>

        <% if(request.getAttribute("error") != null) { %>
        <div class="system-error" style="display: block;">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="<%=request.getContextPath()%>/registerServlet" method="post" id="signupForm" enctype="multipart/form-data">
            <div class="role-selector">
                <label class="role-option active" id="studentRole">
                    <input type="radio" name="role" value="student" checked>
                    <i class="fas fa-user-graduate role-icon"></i>Student
                </label>
                <label class="role-option" id="librarianRole">
                    <input type="radio" name="role" value="librarian">
                    <i class="fas fa-user-tie role-icon"></i>Librarian
                </label>
            </div>

            <div class="profile-upload">
                <div class="profile-preview">
                    <img id="profileImg" src="" alt="Profile Preview">
                    <i class="fas fa-user-circle"></i>
                    <input type="file" id="profilePicture" name="profilePicture" accept="image/*">
                </div>
                <p class="profile-text">Upload profile picture (optional)</p>
            </div>

            <div class="form-group">
                <label class="form-label" for="name">Full Name</label>
                <div class="form-input-container">
                    <input type="text" id="name" name="name" class="form-input" placeholder="Enter your full name" required>
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>

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
                    <input type="password" id="password" name="password" class="form-input" placeholder="Create a password" required>
                    <i class="fas fa-lock input-icon"></i>
                </div>
                <div class="password-strength">
                    <div class="strength-meter" id="strength-meter"></div>
                </div>
                <div class="strength-text">
                    <span class="strength-label" id="strength-text">Password Strength</span>
                    <span>Use 8+ characters with letters, numbers & symbols</span>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="confirmPassword">Confirm Password</label>
                <div class="form-input-container">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="Confirm your password" required>
                    <i class="fas fa-shield-alt input-icon"></i>
                </div>
            </div>

            <div class="terms-container">
                <input type="checkbox" id="terms" name="terms" class="terms-checkbox" required>
                <div class="terms-text">
                    I agree to the <a href="#" class="terms-link">Terms of Service</a> and <a href="#" class="terms-link">Privacy Policy</a>. I understand how my data will be used as described in the Privacy Policy.
                </div>
            </div>

            <button type="submit" class="submit-btn">
        <span class="btn-text">
          Create Account <i class="fas fa-user-plus btn-icon"></i>
        </span>
            </button>

            <div class="login-prompt">
                Already have an account? <a href="<%=request.getContextPath()%>/views/login.jsp" class="login-link">Sign in</a>
            </div>
        </form>
    </div>
</div>

<script>
    // Role selection toggle
    const studentRole = document.getElementById('studentRole');
    const librarianRole = document.getElementById('librarianRole');

    studentRole.addEventListener('click', function() {
        studentRole.classList.add('active');
        librarianRole.classList.remove('active');
    });

    librarianRole.addEventListener('click', function() {
        librarianRole.classList.add('active');
        studentRole.classList.remove('active');
    });

    // Profile picture preview
    const profileInput = document.getElementById('profilePicture');
    const profileImg = document.getElementById('profileImg');
    const profileIcon = document.querySelector('.profile-preview i');

    profileInput.addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                profileImg.src = e.target.result;
                profileImg.style.display = 'block';
                profileIcon.style.display = 'none';
            }
            reader.readAsDataURL(file);
        } else {
            profileImg.style.display = 'none';
            profileIcon.style.display = 'block';
        }
    });

    // Password strength meter
    const passwordInput = document.getElementById('password');
    const strengthMeter = document.getElementById('strength-meter');
    const strengthText = document.getElementById('strength-text');
    const confirmPasswordInput = document.getElementById('confirmPassword');

    passwordInput.addEventListener('input', function() {
        const password = this.value;
        let strength = 0;
        let strengthClass = '';
        let strengthMessage = '';

        if (password.length >= 8) {
            strength += 25;
        }

        if (password.match(/[A-Z]/)) {
            strength += 25;
        }

        if (password.match(/[0-9]/)) {
            strength += 25;
        }

        if (password.match(/[^A-Za-z0-9]/)) {
            strength += 25;
        }

        strengthMeter.style.width = strength + '%';

        if (strength <= 25) {
            strengthClass = '#FF5722';
            strengthMessage = 'Weak';
        } else if (strength <= 50) {
            strengthClass = '#FFC107';
            strengthMessage = 'Fair';
        } else if (strength <= 75) {
            strengthClass = '#4CAF50';
            strengthMessage = 'Good';
        } else {
            strengthClass = '#2196F3';
            strengthMessage = 'Strong';
        }

        strengthMeter.style.backgroundColor = strengthClass;
        strengthText.textContent = strengthMessage;
        strengthText.style.color = strengthClass;
    });

    // Form validation
    const signupForm = document.getElementById('signupForm');

    signupForm.addEventListener('submit', function(event) {
        let isValid = true;

        // Password match validation
        if (passwordInput.value !== confirmPasswordInput.value) {
            alert('Passwords do not match!');
            isValid = false;
        }

        // Password strength validation
        if (passwordInput.value.length < 8) {
            alert('Password must be at least 8 characters long!');
            isValid = false;
        }

        // Terms checkbox validation
        const termsCheckbox = document.getElementById('terms');
        if (!termsCheckbox.checked) {
            alert('You must agree to the Terms of Service and Privacy Policy!');
            isValid = false;
        }

        if (!isValid) {
            event.preventDefault();
        }
    });
</script>
</body>
</html>