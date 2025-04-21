<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LibraryMS - Connect With Us</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6C63FF;
            --secondary-color: #4A41D7;
            --dark-color: #2A2F4F;
            --light-color: #F7F7FC;
            --accent-color: #FF6C63;
            --success-color: #10B981;
            --gradient-bg: linear-gradient(135deg, #6C63FF 0%, #4A41D7 100%);
            --shadow-sm: 0 2px 10px rgba(108, 99, 255, 0.1);
            --shadow-md: 0 4px 20px rgba(108, 99, 255, 0.2);
            --shadow-lg: 0 10px 40px rgba(108, 99, 255, 0.3);
            --border-radius: 16px;
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
            color: #2A2F4F;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"%3E%3Cpath fill="%236C63FF" fill-opacity="0.05" d="M0,96L48,112C96,128,192,160,288,154.7C384,149,480,107,576,112C672,117,768,171,864,186.7C960,203,1056,181,1152,154.7C1248,128,1344,96,1392,80L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"%3E%3C/path%3E%3C/svg%3E');
            background-repeat: no-repeat;
            background-position: bottom;
            background-size: 100% 50%;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        /* Navigation Bar */
        .navbar {
            background-color: white;
            box-shadow: 0 1px 10px rgba(0, 0, 0, 0.05);
            padding: 1.2rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo-icon {
            font-size: 1.8rem;
            color: var(--primary-color);
            margin-right: 0.8rem;
        }

        .logo-text {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
            list-style: none;
        }

        .nav-link {
            color: var(--dark-color);
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: var(--transition);
        }

        .nav-link:hover, .nav-link.active {
            color: var(--primary-color);
            background-color: rgba(108, 99, 255, 0.05);
        }

        .nav-auth {
            display: flex;
            gap: 1rem;
        }

        .nav-auth-btn {
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: var(--transition);
        }

        .login-btn {
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }

        .register-btn {
            background: var(--gradient-bg);
            color: white;
        }

        .login-btn:hover, .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .mobile-menu-btn {
            display: none;
            background: transparent;
            border: none;
            color: var(--dark-color);
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            padding: 5rem 0 2rem;
            background-color: var(--light-color);
            position: relative;
        }

        .page-title {
            font-size: 3rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            position: relative;
        }

        .page-title span {
            color: var(--primary-color);
        }

        .page-title::after {
            content: '';
            position: absolute;
            width: 80px;
            height: 4px;
            background: var(--accent-color);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: #666;
            max-width: 800px;
            margin: 1.5rem auto 0;
        }

        /* Contact Section */
        .contact-section {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            padding: 3rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .contact-form-container {
            flex: 1;
            min-width: 300px;
            background: white;
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            position: relative;
            z-index: 1;
            overflow: hidden;
            transition: var(--transition);
        }

        .contact-form-container:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .contact-form-container::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 150px;
            height: 150px;
            background: var(--light-color);
            border-radius: 50%;
            transform: translate(30%, -30%);
            z-index: -1;
            opacity: 0.6;
        }

        .contact-info {
            flex: 1;
            min-width: 300px;
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 15px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background: var(--accent-color);
            bottom: 0;
            left: 0;
            border-radius: 2px;
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

        textarea.form-input {
            min-height: 150px;
            resize: vertical;
            padding-left: 1rem;
            padding-top: 1rem;
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
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .submit-btn:active {
            transform: translateY(0);
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

        .info-card {
            background: white;
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
            transition: var(--transition);
        }

        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .info-card::after {
            content: '';
            position: absolute;
            bottom: 0;
            right: 0;
            width: 120px;
            height: 120px;
            background: var(--light-color);
            border-radius: 50%;
            transform: translate(30%, 30%);
            z-index: 0;
            opacity: 0.6;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .info-item:last-child {
            margin-bottom: 0;
        }

        .info-icon {
            width: 45px;
            height: 45px;
            background: rgba(108, 99, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            color: var(--primary-color);
            flex-shrink: 0;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .info-item:hover .info-icon {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .info-content h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.3rem;
        }

        .info-content p {
            color: #666;
            line-height: 1.5;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .social-link {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--light-color);
            color: var(--primary-color);
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }

        .social-link:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .hours-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .hours-table tr {
            border-bottom: 1px solid #E5E7EB;
            transition: var(--transition);
        }

        .hours-table tr:hover {
            background-color: rgba(108, 99, 255, 0.05);
        }

        .hours-table tr:last-child {
            border-bottom: none;
        }

        .hours-table td {
            padding: 0.8rem 0;
            color: #666;
        }

        .hours-table td:last-child {
            text-align: right;
            font-weight: 600;
            color: var(--dark-color);
        }

        .hours-table .closed {
            color: var(--accent-color);
        }

        .today {
            background-color: rgba(108, 99, 255, 0.1);
            border-left: 3px solid var(--primary-color);
        }

        .today td {
            padding-left: 0.5rem;
        }

        /* Map Section */
        .map-section {
            padding: 3rem 0 5rem;
            background-color: var(--light-color);
        }

        .text-center {
            text-align: center;
        }

        .map-section .section-title {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 15px;
            position: relative;
            display: inline-block;
        }

        .map-section .section-title::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background: var(--accent-color);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .map-container {
            width: 100%;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            transition: var(--transition);
            margin: 0 auto;
        }

        .map-container:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-5px);
        }

        .map-frame {
            width: 100%;
            height: 450px;
            border: none;
            display: block;
        }

        /* Success Dialog */
        .dialog-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s, visibility 0.3s;
        }

        .dialog-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .dialog-box {
            background: white;
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            text-align: center;
            max-width: 400px;
            width: 90%;
            transform: translateY(-20px);
            transition: transform 0.3s;
            position: relative;
            overflow: hidden;
        }

        .dialog-overlay.show .dialog-box {
            transform: translateY(0);
        }

        .success-icon {
            width: 70px;
            height: 70px;
            background: rgba(16, 185, 129, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: var(--success-color);
            font-size: 2rem;
        }

        .dialog-title {
            font-size: 1.5rem;
            color: var(--dark-color);
            margin-bottom: 0.8rem;
        }

        .dialog-message {
            color: #666;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .dialog-btn {
            padding: 0.8rem 2rem;
            background: var(--gradient-bg);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .dialog-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Footer */
        .footer {
            background-color: var(--dark-color);
            color: white;
            padding: 4rem 0 1rem;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .footer-logo {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .footer-logo i {
            color: var(--primary-color);
            margin-right: 0.8rem;
            font-size: 1.5rem;
        }

        .footer-logo span {
            font-size: 1.3rem;
            font-weight: 700;
            color: white;
        }

        .footer-about {
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
            opacity: 0.8;
        }

        .footer-title {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 10px;
            font-weight: 600;
        }

        .footer-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 2px;
            background: var(--accent-color);
        }

        .footer-links {
            list-style: none;
        }

        .footer-link {
            margin-bottom: 0.8rem;
        }

        .footer-link a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: var(--transition);
            display: flex;
            align-items: center;
        }

        .footer-link a:hover {
            color: white;
            padding-left: 5px;
        }

        .footer-link i {
            margin-right: 0.8rem;
            font-size: 0.8rem;
        }

        .footer-contact {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .contact-icon {
            width: 36px;
            height: 36px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }

        .contact-text {
            font-size: 0.95rem;
            opacity: 0.8;
        }

        .footer-social {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .footer-social-link {
            width: 36px;
            height: 36px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            color: white;
        }

        .footer-social-link:hover {
            background: var(--accent-color);
            transform: translateY(-3px);
        }

        .footer-bottom {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 1.5rem;
            margin-top: 3rem;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .copyright {
            font-size: 0.9rem;
            opacity: 0.8;
        }

        .footer-bottom-links {
            display: flex;
            gap: 1.5rem;
        }

        .footer-bottom-link {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: var(--transition);
        }

        .footer-bottom-link:hover {
            color: white;
        }

        /* Mobile menu styles */
        @media (max-width: 768px) {
            .mobile-menu {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: white;
                box-shadow: var(--shadow-md);
                z-index: 90;
                padding: 1rem 0;
            }

            .mobile-menu.show {
                display: block;
            }

            .mobile-menu .nav-links {
                flex-direction: column;
                align-items: flex-start;
                gap: 0;
            }

            .mobile-menu .nav-link {
                width: 100%;
                padding: 0.8rem 2rem;
                border-radius: 0;
            }

            .mobile-menu .nav-auth {
                flex-direction: column;
                padding: 1rem 2rem;
                gap: 0.8rem;
            }

            .mobile-menu .nav-auth-btn {
                width: 100%;
                text-align: center;
            }
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .contact-section {
                flex-direction: column;
            }

            .page-title {
                font-size: 2.5rem;
            }
        }

        @media (max-width: 768px) {
            .nav-links, .nav-auth {
                display: none;
            }

            .mobile-menu-btn {
                display: block;
            }

            .footer-bottom {
                flex-direction: column;
                text-align: center;
            }

            .footer-bottom-links {
                justify-content: center;
            }

            .page-title {
                font-size: 2rem;
            }
        }

        @media (max-width: 576px) {
            .section-title {
                font-size: 1.5rem;
            }

            .contact-form-container, .info-card {
                padding: 1.5rem;
            }

            .page-title {
                font-size: 1.8rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="nav-container">
        <a href="index.jsp" class="logo">
            <i class="fas fa-book-reader logo-icon"></i>
            <span class="logo-text">LibraryMS</span>
        </a>
        <ul class="nav-links">
            <li><a href="index.jsp" class="nav-link">Home</a></li>
            <li><a href="about.jsp" class="nav-link">About Us</a></li>
            <li><a href="contact.jsp" class="nav-link active">Contact Us</a></li>
            <li><a href="books.jsp" class="nav-link">Books</a></li>
            <li><a href="faq.jsp" class="nav-link">FaQ</a></li>
        </ul>
        <div class="nav-auth">
            <a href="views/login.jsp" class="nav-auth-btn login-btn">Login</a>
            <a href="views/register.jsp" class="nav-auth-btn register-btn">Register</a>
        </div>
        <button class="mobile-menu-btn">
            <i class="fas fa-bars"></i>
        </button>
    </div>

</nav>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1 class="page-title">Connect <span>With Us</span></h1>
        <p class="page-subtitle">Your insights matter to us. Whether you have questions about our services, need assistance with your account, or want to explore partnership opportunities—we're here to help.</p>
    </div>
</section>

<!-- Contact Section -->
<section class="contact-section">
    <div class="contact-form-container">
        <h2 class="section-title">Reach Out to Our Team</h2>
        <form action="contactServlet" method="post" id="contactForm">
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
                    <input type="email" id="email" name="email" class="form-input" placeholder="youremail@example.com" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                    <i class="fas fa-envelope input-icon"></i>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="subject">Subject</label>
                <div class="form-input-container">
                    <input type="text" id="subject" name="subject" class="form-input" placeholder="What is your inquiry about?" required>
                    <i class="fas fa-tag input-icon"></i>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="message">Message</label>
                <textarea id="message" name="message" class="form-input" placeholder="Please share the details of your inquiry..." required></textarea>
            </div>
            <button type="submit" class="submit-btn" id="submitBtn">
                Send Message <i class="fas fa-paper-plane btn-icon"></i>
            </button>
        </form>
    </div>
    <div class="contact-info">
        <div class="info-card">
            <h2 class="section-title">Ways to Reach Us</h2>
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="info-content">
                    <h3>Headquarters</h3>
                    <p>123 Library Street, Knowledge City<br>Education District, 54321</p>
                </div>
            </div>
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <div class="info-content">
                    <h3>Dedicated Support Line</h3>
                    <p>+1 (123) 456-7890<br>+1 (987) 654-3210</p>
                </div>
            </div>
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="info-content">
                    <h3>Email Departments</h3>
                    <p>support@libraryms.com<br>partnerships@libraryms.com</p>
                </div>
            </div>
            <div class="social-links">
                <a href="#" class="social-link" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social-link" title="Twitter"><i class="fab fa-twitter"></i></a>
                <a href="#" class="social-link" title="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="#" class="social-link" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
        <div class="info-card">
            <h2 class="section-title">Library Hours</h2>
            <table class="hours-table">
                <tr id="monday">
                    <td>Monday</td>
                    <td>9:00 AM - 6:00 PM</td>
                </tr>
                <tr id="tuesday">
                    <td>Tuesday</td>
                    <td>9:00 AM - 6:00 PM</td>
                </tr>
                <tr id="wednesday">
                    <td>Wednesday</td>
                    <td>9:00 AM - 6:00 PM</td>
                </tr>
                <tr id="thursday">
                    <td>Thursday</td>
                    <td>9:00 AM - 6:00 PM</td>
                </tr>
                <tr id="friday">
                    <td>Friday</td>
                    <td>9:00 AM - 5:00 PM</td>
                </tr>
                <tr id="saturday">
                    <td>Saturday</td>
                    <td>10:00 AM - 3:00 PM</td>
                </tr>
                <tr id="sunday">
                    <td>Sunday</td>
                    <td class="closed">Closed</td>
                </tr>
            </table>
        </div>
    </div>
</section>

<!-- Map Section -->
<section class="map-section">
    <div class="container">
        <h2 class="section-title text-center">Find Us</h2>
        <div class="map-container">
            <iframe class="map-frame" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3571.593359168591!2d87.26747871503836!3d26.46345988332273!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39ef75012f575225%3A0x92c0e02275003e10!2sItahari%20International%20College!5e0!3m2!1sen!2snp!4v1650104557397!5m2!1sen!2snp" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </div>
</section>

<!-- Success Dialog -->
<div class="dialog-overlay" id="successDialog">
    <div class="dialog-box">
        <div class="success-icon">
            <i class="fas fa-check"></i>
        </div>
        <h2 class="dialog-title">Message Sent Successfully!</h2>
        <p class="dialog-message">Thank you for reaching out to us. Our team will review your message and get back to you within 24-48 hours.</p>
        <button class="dialog-btn" id="dialogCloseBtn">Close</button>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div>
            <div class="footer-logo">
                <i class="fas fa-book-reader"></i>
                <span>LibraryMS</span>
            </div>
            <p class="footer-about">
                LibraryMS is a comprehensive library management system designed to streamline operations, enhance user experience, and empower libraries of all sizes.
            </p>
            <div class="footer-social">
                <a href="#" class="footer-social-link"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="footer-social-link"><i class="fab fa-twitter"></i></a>
                <a href="#" class="footer-social-link"><i class="fab fa-instagram"></i></a>
                <a href="#" class="footer-social-link"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
        <div>
            <h3 class="footer-title">Quick Links</h3>
            <ul class="footer-links">
                <li class="footer-link"><a href="index.jsp"><i class="fas fa-chevron-right"></i> Home</a></li>
                <li class="footer-link"><a href="about.jsp"><i class="fas fa-chevron-right"></i> About Us</a></li>
                <li class="footer-link"><a href="contact.jsp"><i class="fas fa-chevron-right"></i> Contact</a></li>
                <li class="footer-link"><a href="books.jsp"><i class="fas fa-chevron-right"></i> Books</a></li>
                <li class="footer-link"><a href="faq.jsp"><i class="fas fa-chevron-right"></i> FAQ</a></li>
            </ul>
        </div>
        <div>
            <h3 class="footer-title">Our Services</h3>
            <ul class="footer-links">
                <li class="footer-link"><a href="services.jsp#catalog"><i class="fas fa-chevron-right"></i> Book Catalog</a></li>
                <li class="footer-link"><a href="services.jsp#borrowing"><i class="fas fa-chevron-right"></i> Borrowing Management</a></li>
                <li class="footer-link"><a href="services.jsp#users"><i class="fas fa-chevron-right"></i> User Management</a></li>
                <li class="footer-link"><a href="services.jsp#reporting"><i class="fas fa-chevron-right"></i> Reporting & Analytics</a></li>
                <li class="footer-link"><a href="services.jsp#online"><i class="fas fa-chevron-right"></i> Online Access</a></li>
            </ul>
        </div>
        <div>
            <h3 class="footer-title">Contact Us</h3>
            <div class="footer-contact">
                <div class="contact-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="contact-text">
                    123 Library Street, Knowledge City
                    Education District, 54321
                </div>
            </div>
            <div class="footer-contact">
                <div class="contact-icon">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <div class="contact-text">
                    +1 (123) 456-7890
                </div>
            </div>
            <div class="footer-contact">
                <div class="contact-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="contact-text">
                    support@libraryms.com
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="copyright">
            &copy; 2025 LibraryMS. All rights reserved. Designed by Apeksha Neupane and The Group.
        </div>
        <div class="footer-bottom-links">
            <a href="#" class="footer-bottom-link">Privacy Policy</a>
            <a href="#" class="footer-bottom-link">Terms of Service</a>
            <a href="#" class="footer-bottom-link">Cookie Policy</a>
        </div>
    </div>
</footer>

<script>
    // Highlight current day in business hours
    document.addEventListener('DOMContentLoaded', function() {
        // Set today's day highlight in hours table
        const days = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'];
        const today = new Date().getDay(); // 0 is Sunday, 1 is Monday, etc.
        const todayElement = document.getElementById(days[today]);
        if (todayElement) {
            todayElement.classList.add('today');
        }

        // Mobile menu toggle
        const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
        const mobileMenu = document.getElementById('mobileMenu');

        if (mobileMenuBtn && mobileMenu) {
            mobileMenuBtn.addEventListener('click', function() {
                mobileMenu.classList.toggle('show');
            });
        }

        // Form submission and success dialog
        const contactForm = document.getElementById('contactForm');
        const successDialog = document.getElementById('successDialog');
        const dialogCloseBtn = document.getElementById('dialogCloseBtn');

        if (contactForm && successDialog && dialogCloseBtn) {
            contactForm.addEventListener('submit', function(e) {
                e.preventDefault();

                // Form validation
                const emailInput = document.getElementById('email');
                const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

                if (!emailPattern.test(emailInput.value)) {
                    alert('Please enter a valid email address');
                    emailInput.focus();
                    return false;
                }

                // Show success dialog
                successDialog.classList.add('show');

                // Reset form fields
                contactForm.reset();
            });

            dialogCloseBtn.addEventListener('click', function() {
                successDialog.classList.remove('show');
            });

            // Close dialog when clicking outside
            successDialog.addEventListener('click', function(e) {
                if (e.target === successDialog) {
                    successDialog.classList.remove('show');
                }
            });
        }

        // Close mobile menu when clicking a link
        const mobileLinks = document.querySelectorAll('.mobile-menu .nav-link');
        if (mobileLinks.length > 0 && mobileMenu) {
            mobileLinks.forEach(link => {
                link.addEventListener('click', function() {
                    mobileMenu.classList.remove('show');
                });
            });
        }
    });
</script>
</body>
</html>