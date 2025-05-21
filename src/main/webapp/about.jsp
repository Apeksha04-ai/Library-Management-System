
<%--
  Created by IntelliJ IDEA.
  User: Bijeta Maden
  Date: 20/04/2025
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LibraryMS - About Us</title>
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
            box-shadow: var(--shadow-sm);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .nav-logo {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .nav-logo i {
            margin-right: 0.8rem;
            font-size: 1.5rem;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
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

        /* Page Header */
        .page-header {
            background: var(--gradient-bg);
            color: white;
            padding: 4rem 0;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"%3E%3Cpath fill="white" fill-opacity="0.05" d="M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z"%3E%3C/path%3E%3C/svg%3E');
            pointer-events: none;
        }

        .page-title {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
            position: relative;
        }

        .page-subtitle {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto;
            opacity: 0.9;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 3rem 0;
        }

        /* About Section */
        .about-section {
            padding: 3rem 0;
            background-color: white;
            position: relative;
        }

        .about-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(108, 99, 255, 0.02) 0%, rgba(74, 65, 215, 0.02) 100%);
            pointer-events: none;
        }

        .about-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            align-items: center;
            position: relative;
        }

        .about-image {
            position: relative;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            aspect-ratio: 4/3;
            transform: perspective(1000px) rotateY(-5deg);
            transition: var(--transition);
        }

        .about-image:hover {
            transform: perspective(1000px) rotateY(0deg);
        }

        .about-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .about-image::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, rgba(108, 99, 255, 0.1), rgba(74, 65, 215, 0.1));
            pointer-events: none;
        }

        .about-content {
            padding: 2rem;
        }

        .section-title {
            font-size: 2.5rem;
            color: var(--dark-color);
            margin-bottom: 2rem;
            position: relative;
            padding-bottom: 1.5rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 4px;
            background: var(--gradient-bg);
            border-radius: 2px;
        }

        .about-text {
            font-size: 1.1rem;
            color: #444;
            margin-bottom: 2rem;
            line-height: 1.8;
            letter-spacing: 0.2px;
        }

        .about-highlight {
            background: linear-gradient(120deg, rgba(108, 99, 255, 0.1) 0%, rgba(74, 65, 215, 0.1) 100%);
            padding: 2rem;
            border-radius: var(--border-radius);
            margin: 2rem 0;
            border-left: 4px solid var(--primary-color);
        }

        .about-highlight-text {
            font-size: 1.2rem;
            color: var(--dark-color);
            font-weight: 500;
            line-height: 1.6;
            font-style: italic;
        }

        .about-features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .about-feature {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
        }

        .feature-icon {
            color: var(--primary-color);
            font-size: 1.5rem;
            margin-top: 0.3rem;
        }

        .feature-text {
            font-size: 1rem;
            color: #555;
            line-height: 1.6;
        }

        /* Mission & Vision */
        .mission-vision {
            background-color: white;
            padding: 3rem 0;
            position: relative;
        }

        .mission-vision::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(108, 99, 255, 0.02) 0%, rgba(74, 65, 215, 0.02) 100%);
            pointer-events: none;
        }

        .mission-vision-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }

        .mission-card, .vision-card {
            background-color: var(--light-color);
            border-radius: var(--border-radius);
            padding: 3rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            height: 100%;
        }

        .mission-card:hover, .vision-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .card-icon {
            width: 60px;
            height: 60px;
            background: var(--gradient-bg);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-right: 1.5rem;
            flex-shrink: 0;
        }

        .card-title {
            font-size: 1.8rem;
            color: var(--dark-color);
            font-weight: 700;
        }

        .card-text {
            color: #555;
            font-size: 1.1rem;
            line-height: 1.8;
        }

        /* Team Section */
        .team-section {
            padding: 3rem 0;
            background-color: white;
            position: relative;
        }

        .team-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(108, 99, 255, 0.02) 0%, rgba(74, 65, 215, 0.02) 100%);
            pointer-events: none;
        }

        .section-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .section-subtitle {
            font-size: 1.1rem;
            color: #666;
            margin-top: 0.5rem;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .team-member {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .team-member:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .member-image {
            width: 100%;
            height: 280px;
            object-fit: cover;
        }

        .member-info {
            padding: 1.5rem;
            text-align: center;
        }

        .member-name {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .member-role {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 1rem;
        }

        .member-bio {
            color: #555;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
        }

        .social-links {
            display: flex;
            justify-content: center;
            gap: 1rem;
        }

        .social-link {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--light-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .social-link:hover {
            background: var(--gradient-bg);
            color: white;
            transform: translateY(-3px);
        }

        /* Stats Section */
        .stats-section {
            background: var(--gradient-bg);
            padding: 3rem 0;
            color: white;
            position: relative;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            position: relative;
            margin-top: 2rem;
        }

        .stat-item {
            text-align: center;
            padding: 1.5rem;
            border-radius: var(--border-radius);
            background: rgba(255, 255, 255, 0.1);
            transition: var(--transition);
        }

        .stat-item:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.2);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            line-height: 1;
        }

        .stat-label {
            font-size: 1rem;
            font-weight: 600;
            opacity: 0.9;
        }

        /* Footer */
        .footer {
            background-color: var(--dark-color);
            color: white;
            padding: 3rem 0 1.5rem;
        }

        .footer-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .footer-logo {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .footer-logo i {
            font-size: 1.5rem;
            margin-right: 0.8rem;
        }

        .footer-text {
            margin-bottom: 1.5rem;
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.95rem;
        }

        .footer-social {
            display: flex;
            gap: 1rem;
        }

        .footer-social-link {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            transition: var(--transition);
        }

        .footer-social-link:hover {
            background: var(--primary-color);
            transform: translateY(-3px);
        }

        .footer-title {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            font-weight: 700;
            position: relative;
            padding-bottom: 0.8rem;
        }

        .footer-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--primary-color);
        }

        .footer-links {
            list-style: none;
        }

        .footer-link {
            margin-bottom: 0.8rem;
        }

        .footer-link a {
            color: rgba(255, 255, 255, 0.7);
            transition: var(--transition);
        }

        .footer-link a:hover {
            color: white;
            padding-left: 5px;
        }

        .footer-link i {
            margin-right: 0.5rem;
            font-size: 0.8rem;
        }

        .footer-bottom {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 1.5rem;
            margin-top: 3rem;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .copyright {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
        }

        /* Responsive Adjustments */
        @media (max-width: 992px) {
            .about-grid, .mission-vision-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .about-image {
                max-width: 600px;
                margin: 0 auto;
            }

            .about-content {
                text-align: center;
            }

            .section-title:after {
                left: 50%;
                transform: translateX(-50%);
            }

            .about-features {
                grid-template-columns: 1fr;
                max-width: 500px;
                margin: 2rem auto 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 2rem 0;
            }

            .about-section, .mission-vision, .team-section, .stats-section {
                padding: 2rem 0;
            }

            .page-title {
                font-size: 2.2rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .nav-links, .nav-auth {
                display: none;
            }

            .team-grid {
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            }

            .member-image {
                height: 220px;
            }
        }

        @media (max-width: 576px) {
            .main-content {
                padding: 1.5rem 0;
            }

            .about-section, .mission-vision, .team-section, .stats-section {
                padding: 1.5rem 0;
            }

            .page-title {
                font-size: 1.8rem;
            }

            .section-title {
                font-size: 1.6rem;
            }

            .team-grid {
                grid-template-columns: 1fr;
            }

            .footer-bottom {
                flex-direction: column;
                text-align: center;
            }
        }

        /* Mobile Menu Button */
        .mobile-menu-btn {
            display: none;
            background: transparent;
            border: none;
            color: var(--dark-color);
            font-size: 1.5rem;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .mobile-menu-btn {
                display: block;
            }

            .nav-container {
                justify-content: space-between;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="nav-container">
        <a href="index.jsp" class="nav-logo">
            <i class="fas fa-book-reader"></i>
            LibraryMS
        </a>
        <div class="nav-links">
            <a href="index.jsp" class="nav-link">Home</a>
            <a href="about.jsp" class="nav-link active">About Us</a>
            <a href="contact.jsp" class="nav-link">Contact Us</a>
            <a href="books.jsp" class="nav-link">Books</a>
            <a href="faq.jsp" class="nav-link">FAQ</a>
        </div>
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
        <h1 class="page-title">About Us</h1>
        <p class="page-subtitle">Learn about our history, mission, and the dedicated team behind our library management system.</p>
    </div>
</section>

<!-- Main Content -->
<main class="main-content">
    <!-- About Section -->
    <section class="about-section">
        <div class="container">
            <div class="about-grid">
                <div class="about-image">
                    <img src="${pageContext.request.contextPath}/images/about.jpg" alt="Modern Library" class="about-img">
                </div>
                <div class="about-content">
                    <h2 class="section-title">Our Story</h2>
                    <p class="about-text">
                        Established in 2010, LibraryMS emerged from a vision to transform library management through innovative technology. Our journey began with a dedicated team of library professionals and software experts committed to revolutionizing how libraries operate in the digital age.
                    </p>
                    <div class="about-highlight">
                        <p class="about-highlight-text">
                            "We believe in empowering libraries with technology that enhances efficiency while preserving the essential human connection at the heart of every library."
                        </p>
                    </div>
                    <p class="about-text">
                        Through continuous innovation and user feedback, we've evolved into a comprehensive solution trusted by libraries worldwide. Our platform combines cutting-edge technology with deep understanding of library operations, ensuring seamless integration with existing workflows.
                    </p>
                    <div class="about-features">
                        <div class="about-feature">
                            <i class="fas fa-check-circle feature-icon"></i>
                            <p class="feature-text">Advanced catalog management and search capabilities</p>
                        </div>
                        <div class="about-feature">
                            <i class="fas fa-check-circle feature-icon"></i>
                            <p class="feature-text">Intuitive user interface for staff and patrons</p>
                        </div>
                        <div class="about-feature">
                            <i class="fas fa-check-circle feature-icon"></i>
                            <p class="feature-text">Comprehensive reporting and analytics tools</p>
                        </div>
                        <div class="about-feature">
                            <i class="fas fa-check-circle feature-icon"></i>
                            <p class="feature-text">Secure and scalable cloud-based infrastructure</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Mission & Vision Section -->
    <section class="mission-vision">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Our Mission & Vision</h2>
                <p class="section-subtitle">What drives us and where we're headed</p>
            </div>
            <div class="mission-vision-grid">
                <div class="mission-card">
                    <div class="card-header">
                        <div class="card-icon">
                            <i class="fas fa-bullseye"></i>
                        </div>
                        <h3 class="card-title">Our Mission</h3>
                    </div>
                    <p class="card-text">
                        To empower libraries of all sizes with innovative technology that simplifies management, enhances user experience, and promotes knowledge accessibility. We strive to create solutions that help librarians focus on what matters most - connecting people with information and fostering a love for learning.
                    </p>
                </div>
                <div class="vision-card">
                    <div class="card-header">
                        <div class="card-icon">
                            <i class="fas fa-eye"></i>
                        </div>
                        <h3 class="card-title">Our Vision</h3>
                    </div>
                    <p class="card-text">
                        To be the global leader in library management technology, setting new standards for efficiency, usability, and innovation. We envision a world where every library, regardless of size or resources, has access to state-of-the-art management tools that help them serve their communities better.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="team-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Meet Our Team</h2>
                <p class="section-subtitle">The talented individuals behind LibraryMS</p>
            </div>
            <div class="team-grid">
                <div class="team-member">
                    <img src="${pageContext.request.contextPath}/images/Team/Image-1.jpeg" alt="Apeksha Neupane" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Apeksha Neupane</h3>
                        <p class="member-role">Founder & CEO</p>
                        <p class="member-bio">Former librarian with over 15 years of experience who recognized the need for better library management solutions.</p>
                        <div class="social-links">
                            <a href="https://www.linkedin.com/in/apeksha-neupane-8781b1312/" target="_blank" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="https://www.facebook.com/apeksha.neupane.71" target="_blank" class="social-link"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://github.com/Apeksha04-ai" target="_blank" class="social-link"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                </div>
                <div class="team-member">
                    <img src="${pageContext.request.contextPath}/images/Team/Image-2.jpg" alt="Sewanta Luitel" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Sewanta Luitel</h3>
                        <p class="member-role">CTO</p>
                        <p class="member-bio">Tech innovator with a passion for creating intuitive software solutions for educational institutions.</p>
                        <div class="social-links">
                            <a href="linkedin.com/in/sewanta-luitel-aa00512b7" target="_blank" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="https://www.facebook.com/sewantaluitel98/" target="_blank" class="social-link"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://github.com/Sewanta07" target="_blank" class="social-link"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                </div>
                <div class="team-member">
                    <img src="${pageContext.request.contextPath}/images/Team/Image-3.jpeg" alt="Akriti Chaudhary" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Akriti Chaudhary</h3>
                        <p class="member-role">Head of Product</p>
                        <p class="member-bio">User experience expert who ensures our platform remains user-friendly while adding powerful features.</p>
                        <div class="social-links">
                            <a href="https://www.linkedin.com/in/akritichaudhary" target="_blank" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="https://www.facebook.com/aakriti.chaudhary.94009" target="_blank" class="social-link"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://github.com/akririchaudhary" target="_blank" class="social-link"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                </div>
                <div class="team-member">
                    <img src="${pageContext.request.contextPath}/images/Team/Image-4.jpeg" alt="Bijeta Maden" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Bijeta Maden</h3>
                        <p class="member-role">Customer Success Director</p>
                        <p class="member-bio">Dedicated to helping libraries implement and maximize the potential of our platform.</p>
                        <div class="social-links">
                            <a href="https://www.linkedin.com/in/bijeta-maden-15518932a/?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app" target="_blank" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="https://www.facebook.com/bijeta.maden.2025?rdid=GFaTLcrrz6prlzzx&share_url=https%3A%2F%2Fwww.facebook.com%2Fshare%2F18ZyQPRKa8%2F#" target="_blank" class="social-link"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://github.com/bijetamaden1" target="_blank" class="social-link"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                </div>
                <div class="team-member">
                    <img src="${pageContext.request.contextPath}/images/Team/Image-5.jpeg" alt="Rounak Gurung" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Rounak Gurung</h3>
                        <p class="member-role">Marketing Director</p>
                        <p class="member-bio">Strategic marketing professional with expertise in educational technology and library services.</p>
                        <div class="social-links">
                            <a href="https://www.linkedin.com/in/rounak-g-r-g-6bb93a2b5/" target="_blank" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="https://www.facebook.com/rounak.gurung.121" target="_blank" class="social-link"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://github.com/rounakgrg" target="_blank" class="social-link"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Our Impact</h2>
                <p class="section-subtitle">The numbers speak for themselves</p>
            </div>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Libraries Served</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">10M+</div>
                    <div class="stat-label">Books Managed</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">25+</div>
                    <div class="stat-label">Countries</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">98%</div>
                    <div class="stat-label">Client Satisfaction</div>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="footer-container">
            <div>
                <div class="footer-logo">
                    <i class="fas fa-book-reader"></i>
                    <span>LibraryMS</span>
                </div>
                <p class="footer-text">
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
                    <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> Book Catalog</a></li>
                    <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> Borrowing Management</a></li>
                    <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> User Management</a></li>
                    <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> Reporting & Analytics</a></li>
                    <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> Online Access</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="copyright">
                &copy; 2025 LibraryMS. All rights reserved. Designed by Apeksha Neupane and The Group.
            </div>
        </div>
    </div>
</footer>
</body>
</html>
