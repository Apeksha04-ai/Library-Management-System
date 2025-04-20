<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LibraryMS - Modern Library Management System</title>
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

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            padding: 1rem 2.2rem;
            border-radius: 12px;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            font-size: 1.1rem;
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
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }

        .btn-outline:hover {
            background: rgba(108, 99, 255, 0.05);
            transform: translateY(-2px);
        }

        .btn-icon {
            margin-left: 0.5rem;
        }

        /* Header */
        .header {
            background-color: white;
            box-shadow: 0 1px 10px rgba(0, 0, 0, 0.05);
            padding: 1.2rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
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

        .header-buttons {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        /* Hero Section */
        .hero {
            padding: 7rem 0 5rem;
            background-color: var(--light-color);
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 30%;
            background-color: rgba(108, 99, 255, 0.05);
            clip-path: polygon(0 50%, 100% 0, 100% 100%, 0% 100%);
            z-index: 0;
        }

        .hero-container {
            position: relative;
            z-index: 1;
            text-align: center;
            max-width: 800px;
            margin: 0 auto;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 1.5rem;
            color: var(--dark-color);
        }

        .hero-title span {
            color: var(--primary-color);
            display: block;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 2.5rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        .hero-image {
            margin-top: 3rem;
            display: flex;
            justify-content: center;
            position: relative;
        }

        .hero-illustration {
            width: 100%;
            max-width: 600px;
            height: auto;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
        }

        .floating-book {
            position: absolute;
            width: 180px;
            height: auto;
            filter: drop-shadow(0 10px 25px rgba(0,0,0,0.15));
            z-index: 5;
            transition: transform 0.5s ease;
        }

        .floating-book:hover {
            transform: translateY(-10px);
        }

        .book-left {
            left: 0;
            top: 15%;
            transform: rotate(-15deg);
        }

        .book-right {
            right: 0;
            bottom: 10%;
            transform: rotate(10deg);
        }

        /* Features Section */
        .features {
            padding: 6rem 0;
            background-color: white;
            margin-bottom: 0;
        }

        .section-header {
            max-width: 700px;
            margin: 0 auto 4rem;
            text-align: center;
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            color: var(--dark-color);
        }

        .section-subtitle {
            font-size: 1.1rem;
            color: #666;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background-color: var(--light-color);
            border-radius: var(--border-radius);
            padding: 2rem;
            transition: var(--transition);
            border: 1px solid rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            height: 100%;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--gradient-bg);
            color: white;
            border-radius: 12px;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .feature-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--dark-color);
        }

        .feature-text {
            color: #666;
        }

        /* Testimonials Section */
        .testimonials {
            padding: 6rem 0;
            background-color: var(--light-color);
            position: relative;
        }

        .testimonials-container {
            position: relative;
            z-index: 1;
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .testimonial-card {
            background-color: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            border: 1px solid rgba(0,0,0,0.05);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .testimonial-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .testimonial-content {
            flex: 1;
            margin-bottom: 1.5rem;
            position: relative;
        }

        .testimonial-content::before {
            content: '"';
            font-size: 4rem;
            line-height: 1;
            font-family: serif;
            color: rgba(108, 99, 255, 0.1);
            position: absolute;
            top: -20px;
            left: -10px;
        }

        .testimonial-text {
            color: #555;
            line-height: 1.7;
            font-style: italic;
            position: relative;
            z-index: 1;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
        }

        .author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 1rem;
            background-color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .author-info h4 {
            font-weight: 700;
            margin-bottom: 0.2rem;
            color: var(--dark-color);
        }

        .author-info p {
            font-size: 0.9rem;
            color: #666;
        }

        /* CTA Section */
        .cta-section {
            padding: 6rem 0;
            background: var(--gradient-bg);
            color: white;
            position: relative;
            overflow: hidden;
        }

        .cta-background {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"%3E%3Cpath fill="white" fill-opacity="0.05" d="M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z"%3E%3C/path%3E%3C/svg%3E');
            pointer-events: none;
        }

        .cta-container {
            position: relative;
            z-index: 2;
            text-align: center;
            max-width: 700px;
            margin: 0 auto;
        }

        .cta-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
        }

        .cta-text {
            font-size: 1.1rem;
            margin-bottom: 2.5rem;
            opacity: 0.9;
        }

        .cta-btn {
            background-color: white;
            color: var(--primary-color);
            font-weight: 700;
            padding: 1rem 2.5rem;
            border-radius: 12px;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            font-size: 1.1rem;
        }

        .cta-btn:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .cta-btn i {
            margin-left: 0.5rem;
        }

        /* Footer */
        .footer {
            padding: 3rem 0 2rem;
            background-color: white;
            border-top: 1px solid rgba(0,0,0,0.05);
        }

        .footer-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer-logo {
            display: flex;
            align-items: center;
        }

        .footer-logo i {
            color: var(--primary-color);
            margin-right: 0.8rem;
            font-size: 1.5rem;
        }

        .footer-logo span {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--dark-color);
        }

        .footer-text {
            color: #666;
            font-size: 0.9rem;
        }

        .section-divider {
            width: 100%;
            height: 2px;
            background: var(--gradient-bg);
            opacity: 0.1;
            margin: 0;
            padding: 0;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .hero-title {
                font-size: 3rem;
            }

            .section-title {
                font-size: 2.2rem;
            }

            .floating-book {
                width: 120px;
            }
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .features-grid, .testimonials-grid {
                grid-template-columns: 1fr;
            }

            .footer-container {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }

            .footer-logo {
                justify-content: center;
            }

            .floating-book {
                width: 100px;
            }

            .book-left {
                left: 5%;
            }

            .book-right {
                right: 5%;
            }
        }

        @media (max-width: 576px) {
            .btn {
                width: 100%;
                justify-content: center;
            }

            .floating-book {
                display: none;
            }
        }

        /* Navigation Bar Styles */
        .navbar {
            background-color: white;
            padding: 1rem 0;
            box-shadow: var(--shadow-sm);
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .nav-logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
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

        .nav-link:hover {
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
            <a href="about.jsp" class="nav-link">About Us</a>
            <a href="contact.jsp" class="nav-link">Contact Us</a>
            <a href="books.jsp" class="nav-link">Books</a>
            <a href="faq.jsp" class="nav-link">FaQ </a>


        </div>
        <div class="nav-auth">
            <a href="views/login.jsp" class="nav-auth-btn login-btn">Login</a>
            <a href="views/register.jsp" class="nav-auth-btn register-btn">Register</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container hero-container">
        <h1 class="hero-title">Modern <span>Library Management</span> System</h1>
        <p class="hero-subtitle">Streamline your library operations with our comprehensive solution. Efficiently manage books, track borrowings, and provide an enhanced experience for students and staff.</p>
        <a href="views/register.jsp" class="btn btn-primary">Get Started <i class="fas fa-arrow-right btn-icon"></i></a>
        <div class="hero-image">
            <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwIiBoZWlnaHQ9IjQwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnPgogICAgICAgIDxyZWN0IHdpZHRoPSI4MDAiIGhlaWdodD0iNDAwIiBmaWxsPSIjZWVlZWZmIiByeD0iMTYiIC8+CiAgICAgICAgCiAgICAgICAgPCEtLSBCb29rc2hlbGYgLS0+CiAgICAgICAgPHJlY3QgeD0iMTAwIiB5PSIxMDAiIHdpZHRoPSI2MDAiIGhlaWdodD0iMjUwIiBmaWxsPSIjNkM2M0ZGIiBvcGFjaXR5PSIwLjEiIHJ4PSI4IiAvPgogICAgICAgIDxyZWN0IHg9IjEyMCIgeT0iMTIwIiB3aWR0aD0iNTYwIiBoZWlnaHQ9IjIwIiBmaWxsPSIjNEM0MUQ3IiByeD0iNCIgLz4KICAgICAgICA8cmVjdCB4PSIxMjAiIHk9IjIyMCIgd2lkdGg9IjU2MCIgaGVpZ2h0PSIyMCIgZmlsbD0iIzRDNDFENyIgcng9IjQiIC8+CiAgICAgICAgPHJlY3QgeD0iMTIwIiB5PSIzMjAiIHdpZHRoPSI1NjAiIGhlaWdodD0iMjAiIGZpbGw9IiM0QzQxRDciIHJ4PSI0IiAvPgogICAgICAgIAogICAgICAgIDwhLS0gQm9va3MgLS0+CiAgICAgICAgPCEtLSBSb3cgMSAtLT4KICAgICAgICA8cmVjdCB4PSIxNDAiIHk9IjE0MCIgd2lkdGg9IjUwIiBoZWlnaHQ9IjgwIiBmaWxsPSIjNkM2M0ZGIiByeD0iNCIgLz4KICAgICAgICA8cmVjdCB4PSIyMDAiIHk9IjE0MCIgd2lkdGg9IjQwIiBoZWlnaHQ9IjgwIiBmaWxsPSIjRkY2QzYzIiByeD0iNCIgLz4KICAgICAgICA8cmVjdCB4PSIyNTAiIHk9IjE0MCIgd2lkdGg9IjYwIiBoZWlnaHQ9IjgwIiBmaWxsPSIjNEE0MUQ3IiByeD0iNCIgLz4KICAgICAgICA8cmVjdCB4PSIzMjAiIHk9IjE0MCIgd2lkdGg9IjQ1IiBoZWlnaHQ9IjgwIiBmaWxsPSIjNkM2M0ZGIiByeD0iNCIgLz4KICAgICAgICA8cmVjdCB4PSIzNzUiIHk9IjE0MCIgd2lkdGg9IjcwIiBoZWlnaHQ9IjgwIiBmaWxsPSIjOTc5M0ZGIiByeD0iNCIgLz4KICAgICAgICA8cmVjdCB4PSI0NTUiIHk9IjE0MCIgd2lkdGg9IjU1IiBoZWlnaHQ9IjgwIiBmaWxsPSIjRkY2QzYzIiByeD0iNCIgLz4KICAgICAgICA8cmVjdCB4PSI1MjAiIHk9IjE0MCIgd2lkdGg9IjY1IiBoZWlnaHQ9IjgwIiBmaWxsPSIjNEE0MUQ3IiByeD0iNCIgLz4KICAgICAgICA8cmVjdCB4PSI1OTUiIHk9IjE0MCIgd2lkdGg9IjQwIiBoZWlnaHQ9IjgwIiBmaWxsPSIjNkM2M0ZGIiByeD0iNCIgLz4KICAgICAgICAKICAgICAgICA8IS0tIFJvdyAyIC0tPgogICAgICAgIDxyZWN0IHg9IjE0MCIgeT0iMjQwIiB3aWR0aD0iNzAiIGhlaWdodD0iODAiIGZpbGw9IiM0QTQxRDciIHJ4PSI0IiAvPgogICAgICAgIDxyZWN0IHg9IjIyMCIgeT0iMjQwIiB3aWR0aD0iNTAiIGhlaWdodD0iODAiIGZpbGw9IiM2QzYzRkYiIHJ4PSI0IiAvPgogICAgICAgIDxyZWN0IHg9IjI4MCIgeT0iMjQwIiB3aWR0aD0iNDUiIGhlaWdodD0iODAiIGZpbGw9IiNGRjZDNjMiIHJ4PSI0IiAvPgogICAgICAgIDxyZWN0IHg9IjMzNSIgeT0iMjQwIiB3aWR0aD0iNzAiIGhlaWdodD0iODAiIGZpbGw9IiM0QTQxRDciIHJ4PSI0IiAvPgogICAgICAgIDxyZWN0IHg9IjQxNSIgeT0iMjQwIiB3aWR0aD0iNTAiIGhlaWdodD0iODAiIGZpbGw9IiM5NzkzRkYiIHJ4PSI0IiAvPgogICAgICAgIDxyZWN0IHg9IjQ3NSIgeT0iMjQwIiB3aWR0aD0iNjAiIGhlaWdodD0iODAiIGZpbGw9IiM2QzYzRkYiIHJ4PSI0IiAvPgogICAgICAgIDxyZWN0IHg9IjU0NSIgeT0iMjQwIiB3aWR0aD0iNTAiIGhlaWdodD0iODAiIGZpbGw9IiNGRjZDNjMiIHJ4PSI0IiAvPgogICAgICAgIDxyZWN0IHg9IjYwNSIgeT0iMjQwIiB3aWR0aD0iNDAiIGhlaWdodD0iODAiIGZpbGw9IiM0QTQxRDciIHJ4PSI0IiAvPgogICAgPC9nPgo8L3N2Zz4=" alt="Library Management System Illustration" class="hero-illustration">

            <!-- Book 1 - Left side -->
            <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNTAgMzUwIj4KICAgIDwhLS0gQm9vayBDb3ZlciAtLT4KICAgIDxyZWN0IHg9IjIwIiB5PSIyMCIgd2lkdGg9IjIxMCIgaGVpZ2h0PSIzMTAiIHJ4PSI1IiByeT0iNSIgZmlsbD0iIzZDNjNGRiIvPgogICAgPHJlY3QgeD0iMzAiIHk9IjMwIiB3aWR0aD0iMTkwIiBoZWlnaHQ9IjI5MCIgcng9IjMiIHJ5PSIzIiBmaWxsPSIjZmZmZmZmIiBvcGFjaXR5PSIwLjMiLz4KICAgIDwhLS0gQm9vayBTcGluZSAtLT4KICAgIDxyZWN0IHg9IjEwIiB5PSIyMCIgd2lkdGg9IjIwIiBoZWlnaHQ9IjMxMCIgcng9IjIiIHJ5PSIyIiBmaWxsPSIjNEE0MUQ3Ii8+CiAgICA8IS0tIFBhZ2UgRGV0YWlscyAtLT4KICAgIDxyZWN0IHg9IjMwIiB5PSI2MCIgd2lkdGg9IjE1MCIgaGVpZ2h0PSI4IiByeD0iMiIgcnk9IjIiIGZpbGw9IiM0QTQxRDciIG9wYWNpdHk9IjAuNSIvPgogICAgPHJlY3QgeD0iMzAiIHk9IjgwIiB3aWR0aD0iMTcwIiBoZWlnaHQ9IjgiIHJ4PSIyIiByeT0iMiIgZmlsbD0iIzRBNDFENyIgb3BhY2l0eT0iMC41Ii8+CiAgICA8cmVjdCB4PSIzMCIgeT0iMTAwIiB3aWR0aD0iMTUwIiBoZWlnaHQ9IjgiIHJ4PSIyIiByeT0iMiIgZmlsbD0iIzRBNDFENyIgb3BhY2l0eT0iMC41Ii8+CiAgICA8cmVjdCB4PSIzMCIgeT0iMTIwIiB3aWR0aD0iMTcwIiBoZWlnaHQ9IjgiIHJ4PSIyIiByeT0iMiIgZmlsbD0iIzRBNDFENyIgb3BhY2l0eT0iMC41Ii8+CiAgICA8cmVjdCB4PSIzMCIgeT0iMTQwIiB3aWR0aD0iMTQwIiBoZWlnaHQ9IjgiIHJ4PSIyIiByeT0iMiIgZmlsbD0iIzRBNDFENyIgb3BhY2l0eT0iMC41Ii8+CiAgICA8cmVjdCB4PSIzMCIgeT0iMTYwIiB3aWR0aD0iMTcwIiBoZWlnaHQ9IjgiIHJ4PSIyIiByeT0iMiIgZmlsbD0iIzRBNDFENyIgb3BhY2l0eT0iMC41Ii8+CiAgICA8dGV4dCB4PSIxMjAiIHk9IjI0MCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZm9udC1mYW1pbHk9IkFyaWFsLCBzYW5zLXNlcmlmIiBmb250LXNpemU9IjI0IiBmb250LXdlaWdodD0iYm9sZCIgZmlsbD0iIzRBNDFENyI+TGlicmFyeTwvdGV4dD4KICAgIDx0ZXh0IHg9IjEyMCIgeT0iMjgwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LWZhbWlseT0iQXJpYWwsIHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMTgiIGZvbnQtd2VpZ2h0PSJub3JtYWwiIGZpbGw9IiM0QTQxRDciPk1hbmFnZW1lbnQ8L3RleHQ+Cjwvc3ZnPg==" alt="Library Book" class="floating-book book-left">

            <!-- Book 2 - Right side -->
            <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNTAgMzUwIj4KICAgIDwhLS0gQm9vayBDb3ZlciAtLT4KICAgIDxyZWN0IHg9IjIwIiB5PSIyMCIgd2lkdGg9IjIxMCIgaGVpZ2h0PSIzMTAiIHJ4PSI1IiByeT0iNSIgZmlsbD0iI0ZGNkM2MyIvPgogICAgPHJlY3QgeD0iMzAiIHk9IjMwIiB3aWR0aD0iMTkwIiBoZWlnaHQ9IjI5MCIgcng9IjMiIHJ5PSIzIiBmaWxsPSIjZmZmZmZmIiBvcGFjaXR5PSIwLjMiLz4KICAgIDwhLS0gQm9vayBTcGluZSAtLT4KICAgIDxyZWN0IHg9IjEwIiB5PSIyMCIgd2lkdGg9IjIwIiBoZWlnaHQ9IjMxMCIgcng9IjIiIHJ5PSIyIiBmaWxsPSIjRTY1QzVDIi8+CiAgICA8IS0tIEJvb2sgVGl0bGUgLS0+CiAgICA8dGV4dCB4PSIxMjUiIHk9IjgwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LWZhbWlseT0iQXJpYWwsIHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMTgiIGZvbnQtd2VpZ2h0PSJib2xkIiBmaWxsPSJ3aGl0ZSI+U3lzdGVtPC90ZXh0PgogICAgPCEtLSBCb29rIEljb24gLS0+CiAgICA8Y2lyY2xlIGN4PSIxMjUiIGN5PSIxNTAiIHI9IjQwIiBmaWxsPSJ3aGl0ZSIgb3BhY2l0eT0iMC4yIi8+CiAgICA8cGF0aCBkPSJNMTA1IDEzMCBoNDAgdjQwIGgtNDAgdi00MCBtNSA1IGgzMCB2MTAgaC0zMCB2LTEwIG0wIDE1IGgzMCB2MTAgaC0zMCB2LTEwIiBmaWxsPSJ3aGl0ZSIvPgogICAgPCEtLSBQYWdlIERldGFpbHMgLS0+CiAgICA8cmVjdCB4PSI4MCIgeT0iMjIwIiB3aWR0aD0iOTAiIGhlaWdodD0iOCIgcng9IjIiIHJ5PSIyIiBmaWxsPSJ3aGl0ZSIgb3BhY2l0eT0iMC41Ii8+CiAgICA8cmVjdCB4PSI4MCIgeT0iMjQwIiB3aWR0aD0iOTAiIGhlaWdodD0iOCIgcng9IjIiIHJ5PSIyIiBmaWxsPSJ3aGl0ZSIgb3BhY2l0eT0iMC41Ii8+CiAgICA8cmVjdCB4PSI4MCIgeT0iMjYwIiB3aWR0aD0iOTAiIGhlaWdodD0iOCIgcng9IjIiIHJ5PSIyIiBmaWxsPSJ3aGl0ZSIgb3BhY2l0eT0iMC41Ii8+Cjwvc3ZnPg==" alt="System Book" class="floating-book book-right">
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Key Features</h2>
            <p class="section-subtitle">Discover what makes our Library Management System the perfect solution for your institution</p>
        </div>

        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-book"></i>
                </div>
                <h3 class="feature-title">Book Management</h3>
                <p class="feature-text">Easily add, update, and delete books in the system. Keep track of all your resources with comprehensive cataloging including ISBN, title, author, and publication details.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3 class="feature-title">Advanced Search</h3>
                <p class="feature-text">Powerful search functionality allows students to find books by title, author, ISBN, or category. Filter results and view real-time availability statuses.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-exchange-alt"></i>
                </div>
                <h3 class="feature-title">Borrowing System</h3>
                <p class="feature-text">Streamlined borrowing process for checking books in and out. Automatically track due dates and manage book availability with real-time updates.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-calculator"></i>
                </div>
                <h3 class="feature-title">Fine Calculation</h3>
                <p class="feature-text">Automatic calculation of fines for overdue books. Configure fine rates and generate reports on outstanding payments with complete transparency.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-user-shield"></i>
                </div>
                <h3 class="feature-title">Role-Based Access</h3>
                <p class="feature-text">Secure access control with different permission levels for administrators, librarians, and students. Ensure each user has appropriate system access.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3 class="feature-title">Analytics Dashboard</h3>
                <p class="feature-text">Gain insights into library usage patterns with comprehensive analytics. Track popular books, borrowing trends, and user activity for better resource management.</p>
            </div>
        </div>
    </div>
</section>

<div class="section-divider"></div>

<!-- Testimonials Section -->
<section class="testimonials">
    <div class="container testimonials-container">
        <div class="section-header">
            <h2 class="section-title">What Others Say</h2>
            <p class="section-subtitle">Hear from librarians and institutions that have transformed their library management with our system</p>
        </div>

        <div class="testimonials-grid">
            <div class="testimonial-card">
                <div class="testimonial-content">
                    <p class="testimonial-text">This library management system has completely transformed how we operate. The intuitive interface and powerful features have made our workflows so much more efficient.</p>
                </div>
                <div class="testimonial-author">
                    <div class="author-avatar">
                        SJ
                    </div>
                    <div class="author-info">
                        <h4>Sarah Johnson</h4>
                        <p>Head Librarian, Central University</p>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <div class="testimonial-content">
                    <p class="testimonial-text">The analytics dashboard gives us incredible insights into our library usage patterns. We've been able to make data-driven decisions about our collection development.</p>
                </div>
                <div class="testimonial-author">
                    <div class="author-avatar">
                        MR
                    </div>
                    <div class="author-info">
                        <h4>Michael Roberts</h4>
                        <p>Library Director, Tech Institute</p>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <div class="testimonial-content">
                    <p class="testimonial-text">As a student, I love how easy it is to search for and borrow books. The system sends me reminders before my books are due, which has saved me from late fees!</p>
                </div>
                <div class="testimonial-author">
                    <div class="author-avatar">
                        LC
                    </div>
                    <div class="author-info">
                        <h4>Lisa Chen</h4>
                        <p>Student, Engineering Department</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <div class="cta-background"></div>
    <div class="container cta-container">
        <h2 class="cta-title">Ready to Transform Your Library Management?</h2>
        <p class="cta-text">Join educational institutions that have streamlined their library operations with our comprehensive management system.</p>

    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container footer-container">
        <div class="footer-logo">
            <i class="fas fa-book-reader"></i>
            <span>LibraryMS</span>
        </div>
        <div class="footer-text">
            &copy; 2025 LibraryMS. All rights reserved. Designed by Apeksha Neupane and The Group.
        </div>
    </div>
</footer>
</body>
</html>