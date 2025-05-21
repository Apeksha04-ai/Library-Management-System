<%--
  Created by IntelliJ IDEA.
  User: apekshaneupane
  Date: 20/04/2025
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Frequently Asked Questions</title>
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
            flex-direction: column;
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"%3E%3Cpath fill="%236C63FF" fill-opacity="0.05" d="M0,96L48,112C96,128,192,160,288,154.7C384,149,480,107,576,112C672,117,768,171,864,186.7C960,203,1056,181,1152,154.7C1248,128,1344,96,1392,80L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"%3E%3C/path%3E%3C/svg%3E');
            background-repeat: no-repeat;
            background-position: bottom;
            background-size: 100% 50%;
        }

        /* Navigation Bar Styles */
        .navbar {
            background: var(--gradient-bg);
            padding: 1rem 2rem;
            box-shadow: var(--shadow-md);
            position: relative;
            z-index: 100;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo-icon {
            font-size: 1.8rem;
            margin-right: 0.8rem;
            color: white;
        }

        .logo-text {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            color: white;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            list-style: none;
        }

        .nav-links li {
            margin-left: 1.5rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            position: relative;
            padding: 0.5rem 0;
            transition: var(--transition);
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background-color: white;
            transition: var(--transition);
        }

        .nav-links a:hover:after,
        .nav-links a.active:after {
            width: 100%;
        }

        .nav-buttons {
            display: flex;
            align-items: center;
        }

        .nav-btn {
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
            margin-left: 1rem;
            text-decoration: none;
            font-size: 0.95rem;
        }

        .login-btn {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid transparent;
        }

        .login-btn:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        .signup-btn {
            background-color: white;
            color: var(--primary-color);
            border: 2px solid white;
        }

        .signup-btn:hover {
            background-color: rgba(255, 255, 255, 0.9);
        }

        .mobile-menu-btn {
            display: none;
            background: transparent;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* FAQ Page Styles */
        .main-content {
            flex: 1;
            padding: 3rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            color: var(--dark-color);
            margin-bottom: 1rem;
            position: relative;
            display: inline-block;
        }

        .page-title:after {
            content: '';
            position: absolute;
            width: 60px;
            height: 4px;
            background: var(--accent-color);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .page-subtitle {
            font-size: 1.1rem;
            color: #6B7280;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .faq-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .faq-categories {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 3rem;
        }

        .category-btn {
            padding: 0.8rem 1.5rem;
            background: white;
            border: 2px solid var(--light-color);
            border-radius: 50px;
            font-weight: 600;
            color: var(--dark-color);
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.95rem;
        }

        .category-btn:hover, .category-btn.active {
            background: var(--gradient-bg);
            color: white;
            border-color: transparent;
            box-shadow: var(--shadow-sm);
        }

        .category-btn i {
            margin-right: 0.5rem;
        }

        .faq-section {
            margin-bottom: 3rem;
        }

        .section-title {
            font-size: 1.8rem;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 15px;
        }

        .section-title:after {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background: var(--accent-color);
            bottom: 0;
            left: 0;
            border-radius: 2px;
        }

        .faq-item {
            background: white;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            transition: var(--transition);
        }

        .faq-item:hover {
            box-shadow: var(--shadow-md);
        }

        .faq-question {
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            font-weight: 600;
            color: var(--dark-color);
            transition: var(--transition);
        }

        .faq-question:hover {
            background: rgba(92, 107, 192, 0.05);
        }

        .faq-question i {
            font-size: 1.2rem;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .faq-answer {
            padding: 0 1.5rem;
            max-height: 0;
            overflow: hidden;
            transition: var(--transition);
            border-top: 0 solid #E5E7EB;
        }

        .faq-answer-inner {
            padding: 0 0 1.5rem;
            color: #4B5563;
            line-height: 1.8;
        }

        .faq-item.active .faq-question {
            background: rgba(92, 107, 192, 0.05);
        }

        .faq-item.active .faq-question i {
            transform: rotate(180deg);
        }

        .faq-item.active .faq-answer {
            max-height: 1000px; /* Increased max-height to accommodate longer content */
            border-top: 1px solid #E5E7EB;
            padding-top: 1.5rem;
        }

        .search-container {
            margin-bottom: 3rem;
            display: flex;
            justify-content: center;
        }

        .search-form {
            width: 100%;
            max-width: 600px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 1.2rem 1.5rem 1.2rem 3.5rem;
            border: 2px solid #E5E7EB;
            border-radius: 50px;
            font-size: 1rem;
            color: var(--dark-color);
            transition: var(--transition);
            background-color: white;
            box-shadow: var(--shadow-sm);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: var(--shadow-md);
        }

        .search-icon {
            position: absolute;
            left: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-color);
            font-size: 1.2rem;
        }

        .faq-not-found {
            text-align: center;
            margin: 3rem 0;
        }

        .not-found-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .not-found-text {
            font-size: 1.2rem;
            color: var(--dark-color);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .not-found-subtext {
            font-size: 1rem;
            color: #6B7280;
            margin-bottom: 2rem;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        .contact-btn {
            padding: 0.8rem 1.5rem;
            background: var(--gradient-bg);
            color: white;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: var(--shadow-sm);
        }

        .contact-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .help-banner {
            background: white;
            border-radius: var(--border-radius);
            padding: 2.5rem;
            margin-bottom: 3rem;
            text-align: center;
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
        }

        .help-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--gradient-bg);
            clip-path: polygon(0 0, 100% 0, 100% 20%, 0 50%);
            opacity: 0.1;
        }

        .help-content {
            position: relative;
            z-index: 1;
        }

        .help-title {
            font-size: 1.8rem;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .help-text {
            font-size: 1.1rem;
            color: #4B5563;
            margin-bottom: 2rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        .help-options {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .help-option {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1.5rem;
            border-radius: var(--border-radius);
            background: #F9FAFB;
            transition: var(--transition);
            flex: 1;
            min-width: 200px;
            max-width: 250px;
        }

        .help-option:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-sm);
            background: white;
        }

        .help-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(92, 107, 192, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }

        .help-option {
            max-width: 400px; /* Increase max-width for single option */
            margin: 0 auto; /* Center the single option */
        }

        .help-option-text {
            font-size: 0.9rem;
            color: #6B7280;
            text-align: center;
            margin-bottom: 1rem;
        }

        .help-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            transition: var(--transition);
        }

        .help-link:hover {
            color: var(--dark-color);
        }

        .help-link i {
            font-size: 0.8rem;
        }

        /* Premium Features Badge */
        .premium-badge {
            display: inline-flex;
            align-items: center;
            background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
            color: #333;
            font-size: 0.7rem;
            font-weight: 700;
            padding: 0.3rem 0.6rem;
            border-radius: 20px;
            margin-left: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 5px rgba(255, 165, 0, 0.3);
        }

        .premium-badge i {
            margin-right: 0.3rem;
            font-size: 0.7rem;
            color: #333;
        }

        /* Role-Based Icons */
        .role-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            margin-right: 0.6rem;
            font-size: 0.8rem;
        }

        .admin-icon {
            background-color: #FF5722;
            color: white;
        }

        .librarian-icon {
            background-color: #4CAF50;
            color: white;
        }

        .student-icon {
            background-color: #2196F3;
            color: white;
        }

        /* Role-based tags */
        .role-tag {
            display: inline-block;
            padding: 0.2rem 0.5rem;
            font-size: 0.7rem;
            font-weight: 700;
            border-radius: 4px;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
        }

        .admin-tag {
            background-color: rgba(255, 87, 34, 0.15);
            color: #D84315;
        }

        .librarian-tag {
            background-color: rgba(76, 175, 80, 0.15);
            color: #2E7D32;
        }

        .student-tag {
            background-color: rgba(33, 150, 243, 0.15);
            color: #1565C0;
        }

        /* Footer Styles */
        .footer {
            background: var(--dark-color);
            color: white;
            padding: 3rem 2rem 1.5rem;
            margin-top: auto;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .footer-logo {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .footer-logo-icon {
            font-size: 1.8rem;
            margin-right: 0.8rem;
        }

        .footer-logo-text {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: 0.5px;
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
        }

        .footer-title:after {
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

        /* Responsive Styles */
        @media (max-width: 768px) {
            .nav-links, .nav-buttons {
                display: none;
            }

            .mobile-menu-btn {
                display: block;
            }

            .help-options {
                flex-direction: column;
                align-items: center;
            }

            .help-option {
                width: 100%;
                max-width: 100%;
            }

            .footer-bottom {
                flex-direction: column;
                text-align: center;
            }

            .footer-bottom-links {
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 2rem;
            }

            .section-title {
                font-size: 1.5rem;
            }

            .faq-categories {
                flex-direction: column;
            }

            .category-btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="nav-container">
        <div class="logo-container">
            <i class="fas fa-book-reader logo-icon"></i>
            <a href="index.jsp" class="logo-text">LibraryMS</a>
        </div>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="about.jsp">About Us</a></li>
            <li><a href="services.jsp">Services</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="faq.jsp" class="active">FAQ</a></li>
        </ul>
        <div class="nav-buttons">
            <a href="login.jsp" class="nav-btn login-btn">Login</a>
            <a href="signup.jsp" class="nav-btn signup-btn">Sign Up</a>
        </div>
        <button class="mobile-menu-btn">
            <i class="fas fa-bars"></i>
        </button>
    </div>
</nav>

<!-- Main Content -->
<main class="main-content">
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">Frequently Asked Questions</h1>
        <p class="page-subtitle">Find answers to common questions about our comprehensive library management system designed for institutions of all sizes.</p>
    </div>

    <!-- Search Box -->
    <div class="search-container">
        <form class="search-form">
            <input type="text" placeholder="Search for questions..." class="search-input" id="faqSearch">
            <i class="fas fa-search search-icon"></i>
        </form>
    </div>

    <!-- FAQ Categories -->
    <div class="faq-categories">
        <button class="category-btn active" data-category="all">
            <i class="fas fa-th-large"></i> All Questions
        </button>
        <button class="category-btn" data-category="general">
            <i class="fas fa-info-circle"></i> General
        </button>
        <button class="category-btn" data-category="access">
            <i class="fas fa-lock"></i> Access & Roles
        </button>
        <button class="category-btn" data-category="features">
            <i class="fas fa-tools"></i> Features
        </button>
        <button class="category-btn" data-category="billing">
            <i class="fas fa-credit-card"></i> Billing
        </button>
        <button class="category-btn" data-category="support">
            <i class="fas fa-headset"></i> Support
        </button>
    </div>

    <!-- FAQ Container -->
    <div class="faq-container">
        <!-- General Section -->
        <div class="faq-section" id="general">
            <h2 class="section-title">General Questions</h2>

            <div class="faq-item" data-category="general">
                <div class="faq-question">
                    What is LibraryMS?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        LibraryMS is a comprehensive library management system designed to streamline all aspects of library operations. It helps libraries of all sizes manage their collections, automate borrowing processes, track member activities, generate insightful reports, and provide better service to patrons. Our platform combines powerful functionality with an intuitive interface to create an efficient solution for modern libraries.
                        <p style="margin-top: 1rem;">Key features include:</p>
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Complete book inventory management</li>
                            <li>Role-based authentication for administrators, librarians, and students</li>
                            <li>Automated borrowing and returning processes</li>
                            <li>Fine calculation for overdue books</li>
                            <li>Advanced search and filtering capabilities</li>
                            <li>Comprehensive reporting and analytics</li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="general">
                <div class="faq-question">
                    What types of libraries can use LibraryMS?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        LibraryMS is designed to be versatile and adaptable to libraries of all types and sizes. Our system is currently used by:
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Academic libraries (universities, colleges, schools)</li>
                            <li>Public libraries</li>
                            <li>Special libraries (corporate, medical, legal, etc.)</li>
                            <li>Small community libraries</li>
                            <li>Religious institution libraries</li>
                            <li>Research institution libraries</li>
                        </ul>
                        We offer different plans to accommodate the specific needs and budgets of various library types. The role-based access system is particularly useful for educational institutions with clear hierarchies between administrators, librarians, and students.
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="general">
                <div class="faq-question">
                    Do I need special hardware to use LibraryMS?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        No, LibraryMS is a cloud-based solution that works on standard computers, tablets, and smartphones. You don't need any specialized hardware to run the basic system. For enhanced functionality, you might consider optional peripherals such as barcode scanners, label printers, or RFID readers, but these are not required to use the core system.

                        <p style="margin-top: 1rem;">Any device with a modern web browser and internet connection can access LibraryMS. This makes it ideal for libraries that want to allow students to search the catalog from their own devices, while librarians can manage the system from the circulation desk.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="general">
                <div class="faq-question">
                    Is LibraryMS available in multiple languages?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, LibraryMS supports multiple languages to serve libraries worldwide. Our interface is currently available in English, Spanish, French, German, Chinese, Arabic, and Hindi. Both the administrator interface and the public catalog can be configured to display in the preferred language. We're continuously adding support for more languages based on user requests and global needs.

                        <p style="margin-top: 1rem;">This multilingual capability makes our system ideal for libraries serving diverse communities or international educational institutions where users may prefer to interact with the system in their native language.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Access & Roles Section -->
        <div class="faq-section" id="access">
            <h2 class="section-title">Access & Roles Questions</h2>

            <div class="faq-item" data-category="access">
                <div class="faq-question">
                    What are the different user roles in LibraryMS?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        LibraryMS implements a comprehensive role-based authentication system with three primary user roles:

                        <div style="margin-top: 1rem;">
                            <span class="role-tag admin-tag">Admin</span>
                            <strong>Administrator Role:</strong>
                            <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                                <li>Full system access and configuration</li>
                                <li>Manage book resources (add, update, delete books)</li>
                                <li>Create and manage user accounts for all roles</li>
                                <li>Access to all reports and analytics</li>
                                <li>System settings and customization</li>
                                <li>Backup and restore capabilities</li>
                            </ul>
                        </div>

                        <div style="margin-top: 1rem;">
                            <span class="role-tag librarian-tag">Librarian</span>
                            <strong>Librarian Role:</strong>
                            <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                                <li>Manage borrowing and returning processes</li>
                                <li>Track book availability and reservations</li>
                                <li>Process fines and payments</li>
                                <li>Catalog management (add, update books)</li>
                                <li>Generate circulation reports</li>
                                <li>Assist students with account issues</li>
                            </ul>
                        </div>

                        <div style="margin-top: 1rem;">
                            <span class="role-tag student-tag">Student</span>
                            <strong>Student/Patron Role:</strong>
                            <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                                <li>Search for books by title, author, or ISBN</li>
                                <li>Filter search results by various criteria</li>
                                <li>Check book availability and location</li>
                                <li>View personal borrowing history</li>
                                <li>Check due dates and any outstanding fines</li>
                                <li>Request book reservations</li>
                            </ul>
                        </div>

                        <p style="margin-top: 1rem;">This role-based system ensures secure access control while providing each user type with the specific tools they need.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="access">
                <div class="faq-question">
                    How do I create an account for my library?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Creating an account is simple. Click on the "Sign Up" button in the top right corner of our website. You'll need to provide basic information about your library and create administrator credentials. After completing the form, you'll receive a confirmation email with further instructions. Once your account is set up, you can start configuring your library's profile and adding resources to your catalog right away.

                        <p style="margin-top: 1rem;">Note that the initial account created will have Administrator privileges. Once logged in, the Administrator can create additional accounts for librarians and student users through the user management interface.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="access">
                <div class="faq-question">
                    How do students access the library system?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Students can access the library system in two ways:

                        <ol style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li><strong>Administrator-created accounts:</strong> The library administrator or librarian can create student accounts in bulk or individually. Students will receive login credentials via email.</li>
                            <li><strong>Self-registration:</strong> If enabled by the administrator, students can self-register on the login page. They'll need to provide their student ID and email address for verification. This option can be customized to require administrator approval before activation.</li>
                        </ol>

                        <p style="margin-top: 1rem;">Once logged in, students will have access to search the catalog, view their borrowing history, check due dates, and see any outstanding fines. They cannot access administrative functions or modify the book database.</p>

                        <p style="margin-top: 1rem;">For educational institutions, we also offer integration with common student management systems and single sign-on (SSO) capabilities for seamless authentication. <span class="premium-badge"><i class="fas fa-star"></i> Premium</span></p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="access">
                <div class="faq-question">
                    Can I customize permissions for different staff members?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, LibraryMS offers a comprehensive role-based access control system. As an administrator, you can create custom roles with specific permissions or use our pre-defined roles such as Administrator, Librarian, Cataloger, and Circulation Staff. Each role can be configured with granular access rights to different modules and functions.

                        <p style="margin-top: 1rem;">For example, you might create a specialized "Junior Librarian" role that can process returns but not issue fines, or a "Catalog Manager" who can add new books but cannot access financial reporting. This ensures staff members only have access to the tools they need for their specific responsibilities, maintaining security and operational efficiency.</p>

                        <p style="margin-top: 1rem;">Our Enterprise plan allows for unlimited custom roles with highly specific permission sets. <span class="premium-badge"><i class="fas fa-star"></i> Premium</span></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features Section -->
        <div class="faq-section" id="features">
            <h2 class="section-title">Features & Functionality</h2>

            <div class="faq-item" data-category="features">
                <div class="faq-question">
                    How does the book search functionality work?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        LibraryMS features a powerful and intuitive search system that helps users quickly find the resources they need. Students and staff can search for books using various criteria:

                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li><strong>Basic search:</strong> By title, author, ISBN, or keywords</li>
                            <li><strong>Advanced filtering:</strong> By category, publication date, language, availability status</li>
                            <li><strong>Location search:</strong> Find books by shelf, section, or floor</li>
                            <li><strong>Subject search:</strong> Browse by subject area or discipline</li>
                        </ul>

                        <p style="margin-top: 1rem;">The search results provide comprehensive information about each book, including availability status, due dates for borrowed copies, and location within the library. Users can also view cover images and read summaries when available.</p>

                        <p style="margin-top: 1rem;">Our Professional and Enterprise plans include full-text search for digital resources and integrated discovery services that extend beyond your library's physical collection. <span class="premium-badge"><i class="fas fa-star"></i> Premium</span></p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="features">
                <div class="faq-question">
                    How does the fine calculation system work?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        LibraryMS includes a configurable fine calculation system for overdue books. The default setting charges Rs.5 per day for each day a book is overdue, but administrators can customize this based on their library's policies.

                        <p style="margin-top: 1rem;">Key features of the fine system include:</p>
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Automatic calculation of fines based on return date</li>
                            <li>Configurable grace periods before fines begin</li>
                            <li>Different fine rates for different book categories or user types</li>
                            <li>Maximum fine caps to prevent excessive charges</li>
                            <li>Fine reduction or waiver capabilities for librarians</li>
                            <li>Complete fine history for each user</li>
                        </ul>

                        <p style="margin-top: 1rem;">Students can view their current and past fines through their account dashboard. The system can be configured to automatically block new borrowing when fines exceed a certain threshold until payment is made.</p>

                        <p style="margin-top: 1rem;">Advanced plans include online payment processing integration for fine collection. <span class="premium-badge"><i class="fas fa-star"></i> Premium</span></p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="features">
                <div class="faq-question">
                    Can LibraryMS handle digital resources and physical books?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, LibraryMS is designed to manage both physical and digital resources comprehensively. For physical items, the system tracks location, availability, and circulation status. For digital resources, LibraryMS can manage e-books, digital journals, audio/video materials, and databases with features like direct access links, license management, and usage tracking.

                        <p style="margin-top: 1rem;">Our integrated approach allows libraries to offer a seamless experience for patrons regardless of resource format. Students can search across all resources types simultaneously and access digital content directly through the system when available.</p>

                        <p style="margin-top: 1rem;">The Professional and Enterprise plans include advanced digital resource management with features like:</p>
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Digital rights management</li>
                            <li>Time-limited access controls</li>
                            <li>Usage analytics for digital resources</li>
                            <li>Integration with major e-book providers</li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="features">
                <div class="faq-question">
                    How does the book borrowing and returning process work?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        The borrowing and returning process in LibraryMS is designed to be efficient and user-friendly:

                        <p style="margin-top: 1rem;"><strong>Borrowing Process:</strong></p>
                        <ol style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Student presents their ID card or provides their credentials to the librarian</li>
                            <li>Librarian scans or enters the book's barcode or ISBN</li>
                            <li>System verifies student eligibility (active status, no blocking fines, hasn't exceeded maximum books)</li>
                            <li>System confirms the loan, records the due date, and updates the book's status to "borrowed"</li>
                            <li>Student receives a confirmation receipt (printed or via email)</li>
                        </ol>

                        <p style="margin-top: 1rem;"><strong>Returning Process:</strong></p>
                        <ol style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Book is returned to the library and scanned by the librarian</li>
                            <li>System identifies the loan record and calculates any applicable fines</li>
                            <li>Book status is updated to "available" or "in processing"</li>
                            <li>Student receives a return confirmation and fine notification if applicable</li>
                        </ol>

                        <p style="margin-top: 1rem;">The system automatically sends due date reminders and overdue notices to students via email. Administrators can configure the schedule for these notifications (e.g., 3 days before due date, on the due date, and at various intervals afterward).</p>

                        <p style="margin-top: 1rem;">Self-service kiosks for borrowing and returning are available with our Professional and Enterprise plans. <span class="premium-badge"><i class="fas fa-star"></i> Premium</span></p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="features">
                <div class="faq-question">
                    Does the system send overdue notices automatically?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, LibraryMS includes a robust notification system that automatically sends overdue notices to patrons. You can configure multiple reminder schedules (e.g., 3 days before due date, on the due date, and at various intervals afterward). Notifications can be sent via email or SMS, and the content is fully customizable to match your library's communication style. The system also keeps a record of all notifications sent for reference in case of disputes.

                        <p style="margin-top: 1rem;">The notification system can be customized in several ways:</p>
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Customize message content and branding</li>
                            <li>Set different notification schedules for different book types or patron categories</li>
                            <li>Enable or disable specific notification types</li>
                            <li>Schedule notifications to be sent only during certain hours</li>
                        </ul>

                        <p style="margin-top: 1rem;">Enterprise plans include SMS notifications, push notifications for mobile app users, and integration with messaging platforms. <span class="premium-badge"><i class="fas fa-star"></i> Premium</span></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Billing Section -->
        <div class="faq-section" id="billing">
            <h2 class="section-title">Pricing & Billing</h2>

            <div class="faq-item" data-category="billing">
                <div class="faq-question">
                    What pricing plans are available?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        LibraryMS offers several pricing tiers to accommodate libraries of different sizes and needs:
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li><strong>Basic Plan:</strong> For small libraries with up to 5,000 items and 3 staff accounts
                                <ul>
                                    <li>Core book management features</li>
                                    <li>Basic role-based access (Admin, Librarian, Student)</li>
                                    <li>Standard borrowing and returning processes</li>
                                    <li>Basic fine calculation</li>
                                    <li>Email support</li>
                                </ul>
                            </li>
                            <li style="margin-top: 0.8rem;"><strong>Standard Plan:</strong> For medium libraries with up to 25,000 items and 10 staff accounts
                                <ul>
                                    <li>All Basic features plus:</li>
                                    <li>Advanced search capabilities</li>
                                    <li>Customizable fine rules</li>
                                    <li>Basic reporting and analytics</li>
                                    <li>Email and chat support</li>
                                </ul>
                            </li>
                            <li style="margin-top: 0.8rem;"><strong>Professional Plan:</strong> For large libraries with up to 100,000 items and 25 staff accounts
                                <ul>
                                    <li>All Standard features plus:</li>
                                    <li>Digital resource management</li>
                                    <li>Advanced reporting and analytics</li>
                                    <li>API access for integrations</li>
                                    <li>Priority support</li>
                                </ul>
                            </li>
                            <li style="margin-top: 0.8rem;"><strong>Enterprise Plan:</strong> For very large institutions with unlimited items and staff accounts
                                <ul>
                                    <li>All Professional features plus:</li>
                                    <li>Customizable roles and permissions</li>
                                    <li>Self-service kiosks</li>
                                    <li>Advanced integrations</li>
                                    <li>Dedicated account manager</li>
                                </ul>
                            </li>
                        </ul>
                        <p style="margin-top: 1rem;">We also offer special discounted rates for educational institutions, non-profits, and public libraries. Please contact our sales team for detailed pricing information and to discuss which plan best suits your library's needs.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="billing">
                <div class="faq-question">
                    Is there a free trial available?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, we offer a 30-day free trial that gives you full access to all features in our Standard Plan. The trial allows you to thoroughly test the system with your actual library data and workflows. No credit card is required to start the trial.

                        <p style="margin-top: 1rem;">During the trial period, our team provides complimentary onboarding assistance to help you evaluate the system effectively. We'll help you set up your initial catalog, user roles, and borrowing policies to ensure you can properly assess how LibraryMS would work in your specific environment.</p>

                        <p style="margin-top: 1rem;">If you need more time for evaluation, you can request a trial extension through your account manager. For educational institutions implementing the system as part of a course project, we offer extended evaluation periods.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="billing">
                <div class="faq-question">
                    Are there any special plans for educational institutions?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, we offer special Educational Institution Plans designed specifically for schools, colleges, and universities. These plans include:

                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li><strong>School Plan:</strong> Tailored for K-12 schools with simplified interfaces and age-appropriate features</li>
                            <li><strong>College Plan:</strong> Designed for small to medium colleges with department-specific collections</li>
                            <li><strong>University Plan:</strong> Comprehensive solution for large universities with multiple libraries and specialized collections</li>
                        </ul>

                        <p style="margin-top: 1rem;">All educational plans include:</p>
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Substantial discounts compared to standard pricing</li>
                            <li>Integration with common Student Information Systems</li>
                            <li>Specialized training for student library assistants</li>
                            <li>Course reserve management tools</li>
                            <li>Academic year-based reporting</li>
                        </ul>

                        <p style="margin-top: 1rem;">We also offer special project-based licenses for educational institutions implementing LibraryMS as part of coursework or student projects. Please contact our education team for more details.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="billing">
                <div class="faq-question">
                    Can I upgrade or downgrade my plan?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, you can upgrade your plan at any time as your library grows or needs change. Upgrades take effect immediately, and you'll only be charged the prorated difference for the remainder of your billing cycle. Downgrades can be processed at the end of your current billing cycle. Our flexible approach ensures you're always on the most appropriate plan for your current needs. Plan changes can be requested through your account settings or by contacting our customer support team.

                        <p style="margin-top: 1rem;">When upgrading, your existing data and configurations will be preserved and automatically migrated to the new plan level. If you're upgrading to gain access to specific features, our team can provide guidance on how to best implement and utilize these new capabilities.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Support Section -->
        <div class="faq-section" id="support">
            <h2 class="section-title">Support & Training</h2>

            <div class="faq-item" data-category="support">
                <div class="faq-question">
                    What training resources are available?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        LibraryMS provides comprehensive training resources to ensure your team can effectively use the system:
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Interactive video tutorials for each module</li>
                            <li>Detailed user documentation and knowledge base</li>
                            <li>Live webinar training sessions (scheduled regularly)</li>
                            <li>Customized training sessions for your staff</li>
                            <li>Administrator-specific advanced training</li>
                            <li>Printable quick-start guides and user manuals</li>
                            <li>Role-specific training paths for administrators, librarians, and student assistants</li>
                        </ul>

                        <p style="margin-top: 1rem;">We also offer specialized training packages:</p>
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li><strong>Getting Started Package:</strong> Comprehensive setup and basic operations training</li>
                            <li><strong>Advanced Features Package:</strong> In-depth training on reporting, customization, and advanced features</li>
                            <li><strong>Train-the-Trainer Program:</strong> Equips your team leaders to train others within your organization</li>
                        </ul>

                        <p style="margin-top: 1rem;">All Standard plan and above subscribers receive complimentary onboarding training to help you get started. Additional custom training sessions can be purchased as needed.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="support">
                <div class="faq-question">
                    How do I get technical support?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Technical support is available through multiple channels:
                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Email support: available to all customers 24/7</li>
                            <li>Live chat: available during business hours (8am-8pm EST, Monday-Friday)</li>
                            <li>Phone support: available to Professional and Enterprise customers</li>
                            <li>Dedicated support manager: available to Enterprise customers</li>
                            <li>Community forums: where you can connect with other LibraryMS users</li>
                        </ul>

                        <p style="margin-top: 1rem;">Our support team includes library professionals who understand both the technical aspects of the system and the practical needs of modern libraries. This ensures you receive relevant, practical solutions tailored to your specific library environment.</p>

                        <p style="margin-top: 1rem;">Our average response time is under 2 hours during business hours. For critical issues, we offer emergency support with expedited response times. All support interactions are tracked in our system for reference and continuity.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="support">
                <div class="faq-question">
                    Is data migration assistance available?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, we provide data migration assistance for all new customers. Our data specialists will help you export data from your current system and import it into LibraryMS. The migration process includes:

                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Initial data assessment and mapping</li>
                            <li>Export guidance for your current system</li>
                            <li>Data cleaning and formatting recommendations</li>
                            <li>Test migration with sample data</li>
                            <li>Full migration with validation and quality checks</li>
                            <li>Post-migration verification and troubleshooting</li>
                        </ul>

                        <p style="margin-top: 1rem;">We have experience migrating from most major library systems including Koha, Alexandria, Liberty, and custom databases. We can handle various data formats including MARC records, CSV files, Excel spreadsheets, and SQL exports.</p>

                        <p style="margin-top: 1rem;">Standard migrations are included in Professional and Enterprise plans, while Basic and Standard plans can add migration services for an additional fee. For complex migrations or libraries with large collections, we offer premium migration services with enhanced data transformation and enrichment options.</p>
                    </div>
                </div>
            </div>

            <div class="faq-item" data-category="support">
                <div class="faq-question">
                    Do you offer implementation services for educational projects?
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <div class="faq-answer-inner">
                        Yes, we offer specialized services for educational institutions implementing LibraryMS as part of coursework or student projects. Our Academic Implementation Program includes:

                        <ul style="margin-top: 0.5rem; margin-left: 1.5rem;">
                            <li>Special licensing terms for academic projects</li>
                            <li>Technical documentation and architecture overviews</li>
                            <li>API documentation for integration projects</li>
                            <li>Conceptual guidance on implementing library management systems</li>
                            <li>Best practices for JSP, Servlets, and MySQL implementation</li>
                            <li>Virtual guidance sessions with our development team</li>
                        </ul>

                        <p style="margin-top: 1rem;">We understand the unique requirements of educational projects, including the need for hands-on experience with technologies like JSP, Servlets, and MySQL. Our team can provide guidance on implementing role-based authentication, book management, search functionality, and fine calculation in a way that aligns with course objectives while creating a practical, functional system.</p>

                        <p style="margin-top: 1rem;">For educators, we also offer teaching resources including system architecture documentation, database schema examples, and sample code that can be used in the classroom.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Not Found Section (initially hidden) -->
        <div class="faq-not-found" style="display: none;">
            <div class="not-found-icon">
                <i class="fas fa-search"></i>
            </div>
            <h3 class="not-found-text">No matching questions found</h3>
            <p class="not-found-subtext">
                We couldn't find any questions matching your search term. Try using different keywords or ask us directly.
            </p>
            <a href="contact.jsp" class="contact-btn">
                <i class="fas fa-envelope"></i> Contact Support
            </a>
        </div>
    </div>

    <!-- Help Banner -->
    <div class="help-banner">
        <div class="help-bg"></div>
        <div class="help-content">
            <h2 class="help-title">Need More Help?</h2>
            <p class="help-text">
                If you couldn't find the answer you were looking for, our support team is always ready to assist you through various channels.
            </p>

            <div class="help-option">
                <div class="help-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <h3 class="help-option-title">Email Support</h3>
                <p class="help-option-text">
                    Send us your questions and get detailed answers
                </p>
                <a href="contact.jsp" class="help-link">Contact Us <i class="fas fa-arrow-right"></i></a>

            </div>
        </div>
    </div>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div>
            <div class="footer-logo">
                <i class="fas fa-book-reader footer-logo-icon"></i>
                <span class="footer-logo-text">LibraryMS</span>
            </div>
            <p class="footer-about">
                LibraryMS is a comprehensive library management system designed to streamline operations, enhance user experience, and empower libraries of all sizes with role-based access control.
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
                <li class="footer-link"><a href="services.jsp"><i class="fas fa-chevron-right"></i> Services</a></li>
                <li class="footer-link"><a href="contact.jsp"><i class="fas fa-chevron-right"></i> Contact</a></li>
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
                    info@libraryms.com
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="copyright">
            &copy; 2025 LibraryMS. All rights reserved.
        </div>
        <div class="footer-bottom-links">
            <a href="#" class="footer-bottom-link">Privacy Policy</a>
            <a href="#" class="footer-bottom-link">Terms of Service</a>
            <a href="#" class="footer-bottom-link">Cookie Policy</a>
        </div>
    </div>
</footer>

<script>
    // Mobile menu toggle
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const navLinks = document.querySelector('.nav-links');
    const navButtons = document.querySelector('.nav-buttons');

    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', function() {
            navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
            navButtons.style.display = navButtons.style.display === 'flex' ? 'none' : 'flex';
        });
    }

    // FAQ Item Toggle
    const faqItems = document.querySelectorAll('.faq-item');

    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');

        question.addEventListener('click', () => {
            // Toggle current item
            item.classList.toggle('active');
        });
    });

    // Category Filter
    const categoryBtns = document.querySelectorAll('.category-btn');
    const faqSections = document.querySelectorAll('.faq-section');

    categoryBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Remove active class from all buttons
            categoryBtns.forEach(otherBtn => {
                otherBtn.classList.remove('active');
            });

            // Add active class to clicked button
            btn.classList.add('active');

            const category = btn.getAttribute('data-category');

            if (category === 'all') {
                // Show all sections and items for "All Questions"
                faqSections.forEach(section => {
                    section.style.display = 'block';
                });

                faqItems.forEach(item => {
                    item.style.display = 'block';
                });
            } else {
                // For specific categories, only show matching sections and items
                faqSections.forEach(section => {
                    if (section.id === category) {
                        section.style.display = 'block';
                    } else {
                        section.style.display = 'none';
                    }
                });

                // Show items that match the category
                faqItems.forEach(item => {
                    if (item.getAttribute('data-category') === category) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                });
            }

            // Hide not found message when changing categories
            document.querySelector('.faq-not-found').style.display = 'none';
        });
    });

    // Search functionality
    const searchInput = document.getElementById('faqSearch');

    searchInput.addEventListener('input', () => {
        const searchTerm = searchInput.value.toLowerCase().trim();
        let matchFound = false;

        if (searchTerm === '') {
            // Reset to show all items when search is cleared
            categoryBtns.forEach(btn => {
                if (btn.getAttribute('data-category') === 'all') {
                    btn.click();
                }
            });
            return;
        }

        // Make sure "All Questions" is selected visually
        categoryBtns.forEach(btn => {
            btn.classList.remove('active');
            if (btn.getAttribute('data-category') === 'all') {
                btn.classList.add('active');
            }
        });

        // Show all sections initially for search
        faqSections.forEach(section => {
            section.style.display = 'block';
        });

        // Search through questions and answers
        faqItems.forEach(item => {
            const question = item.querySelector('.faq-question').textContent.toLowerCase();
            const answer = item.querySelector('.faq-answer-inner').textContent.toLowerCase();

            if (question.includes(searchTerm) || answer.includes(searchTerm)) {
                item.style.display = 'block';
                matchFound = true;

                // Automatically expand items that match search
                item.classList.add('active');
            } else {
                item.style.display = 'none';

                // Collapse items that don't match
                item.classList.remove('active');
            }
        });

        // Check each section to see if it has any visible items
        faqSections.forEach(section => {
            const visibleItems = Array.from(section.querySelectorAll('.faq-item')).filter(item =>
                item.style.display !== 'none'
            );

            if (visibleItems.length > 0) {
                section.style.display = 'block';
            } else {
                section.style.display = 'none';
            }
        });

        // Show not found message if no matches
        document.querySelector('.faq-not-found').style.display = matchFound ? 'none' : 'block';
    });
</script>
</body>
</html>