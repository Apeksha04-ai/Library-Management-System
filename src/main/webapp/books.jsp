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
    <title>Books Catalog - Library Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Base Variables */
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

        /* Reset & Base Styles */
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

        /* Navigation */
        .navbar {
            background-color: white;
            padding: 1rem 0;
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .nav-logo {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .nav-logo i {
            margin-right: 0.5rem;
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

        .nav-link.active {
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
            color: var(--primary-color);
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
            padding-top: 3rem;
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
            color: #666;
            max-width: 700px;
            margin: 1.5rem auto 0;
            line-height: 1.6;
        }

        /* Featured Section */
        .featured-section {
            margin-bottom: 4rem;
            padding: 3rem 2rem;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.8rem;
            color: var(--dark-color);
            position: relative;
            padding-bottom: 0.5rem;
        }

        .section-title:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background-color: var(--accent-color);
            border-radius: 2px;
        }

        .view-all {
            color: var(--primary-color);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            transition: var(--transition);
        }

        .view-all:hover {
            transform: translateX(5px);
        }

        .featured-books {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }

        .featured-book {
            display: flex;
            background-color: var(--light-color);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .featured-book:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .featured-cover {
            width: 120px;
            height: 160px;
            object-fit: cover;
        }

        .featured-details {
            padding: 1rem;
            flex: 1;
        }

        .featured-title {
            font-size: 1rem;
            font-weight: 700;
            margin-bottom: 0.3rem;
            color: var(--dark-color);
            line-height: 1.4;
        }

        .featured-author {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 0.5rem;
        }

        .featured-description {
            font-size: 0.8rem;
            color: #666;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }

        .featured-ratings {
            display: flex;
            align-items: center;
            gap: 0.3rem;
            font-size: 0.8rem;
            color: #666;
        }

        .featured-ratings i {
            color: #FFD700;
        }

        /* Category Section */
        .category-section {
            margin-bottom: 4rem;
        }

        .category-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .category-title {
            font-size: 1.8rem;
            color: var(--dark-color);
            position: relative;
            padding-bottom: 0.5rem;
        }

        .category-title:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background-color: var(--accent-color);
            border-radius: 2px;
        }

        /* Books Grid */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 2rem;
            margin-bottom: 1rem;
        }

        .book-card {
            background-color: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .book-cover {
            width: 100%;
            height: 280px;
            object-fit: cover;
            border-top-left-radius: var(--border-radius);
            border-top-right-radius: var(--border-radius);
        }

        .book-details {
            padding: 1.5rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .book-title {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
            line-height: 1.4;
        }

        .book-author {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 1rem;
        }

        .book-genre {
            font-size: 0.8rem;
            padding: 0.3rem 0.6rem;
            background-color: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
            border-radius: 50px;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .book-actions {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .book-ratings {
            display: flex;
            align-items: center;
            gap: 0.3rem;
            font-size: 0.85rem;
            color: #666;
        }

        .book-ratings i {
            color: #FFD700;
        }

        .borrow-btn {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            background: var(--gradient-bg);
            color: white;
            font-size: 0.85rem;
            font-weight: 600;
            transition: var(--transition);
            cursor: pointer;
            border: none;
            display: inline-flex;
            align-items: center;
        }

        .borrow-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        /* Banner */
        .banner {
            background: var(--gradient-bg);
            color: white;
            padding: 3rem 2rem;
            border-radius: var(--border-radius);
            margin-bottom: 4rem;
            text-align: center;
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
        }

        .banner-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"%3E%3Cpath fill="white" fill-opacity="0.08" d="M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5z"%3E%3C/path%3E%3C/svg%3E');
            opacity: 0.6;
            z-index: 0;
        }

        .banner-content {
            position: relative;
            z-index: 1;
        }

        .banner-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .banner-text {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        .banner-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background-color: white;
            color: var(--primary-color);
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
        }

        .banner-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        /* Footer */
        .footer {
            padding: 3rem 0 2rem;
            background-color: var(--dark-color);
            color: white;
            margin-top: auto;
        }

        .footer-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .footer-col {
            flex: 1;
            min-width: 250px;
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
            font-size: 1.2rem;
            font-weight: 700;
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
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 1.5rem;
            margin-top: 3rem;
            text-align: center;
            font-size: 0.9rem;
            opacity: 0.8;
            max-width: 1200px;
            margin: 3rem auto 0;
            padding: 1.5rem 2rem 0;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .featured-books {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .nav-links, .nav-auth {
                display: none;
            }

            .mobile-menu-btn {
                display: block;
            }

            .footer-col {
                flex: 100%;
            }

            .featured-books {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 2rem;
            }

            .section-title, .category-title {
                font-size: 1.5rem;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            }

            .book-cover {
                height: 220px;
            }

            .banner-title {
                font-size: 1.6rem;
            }

            .banner-text {
                font-size: 1rem;
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
            <a href="about.jsp" class="nav-link">About Us</a>
            <a href="contact.jsp" class="nav-link">Contact Us</a>
            <a href="books.jsp" class="nav-link active">Books</a>
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

<!-- Main Content -->
<main class="container">
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">Books Catalog</h1>
        <p class="page-subtitle">Explore our extensive collection of books from various genres, authors, and eras. Find your next favorite read.</p>
    </div>

    <!-- Featured Section -->
    <section class="featured-section">
        <div class="section-header">
            <h2 class="section-title">Featured Books</h2>
            <a href="views/login.jsp" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
        </div>
        <div class="featured-books">
            <div class="featured-book">
                <img src="https://m.media-amazon.com/images/I/51Z0nLAfLmL.jpg" alt="The Alchemist" class="featured-cover">
                <div class="featured-details">
                    <h3 class="featured-title">The Alchemist</h3>
                    <p class="featured-author">By Paulo Coelho</p>
                    <p class="featured-description">A magical story about following your dreams. This international bestseller tells the mystical story of Santiago, an Andalusian shepherd boy who yearns to travel in search of a worldly treasure.</p>
                    <div class="featured-ratings">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <span>4.6</span>
                    </div>
                </div>
            </div>
            <div class="featured-book">
                <img src="https://m.media-amazon.com/images/I/51n1I8-zdmL.jpg" alt="The Love Hypothesis" class="featured-cover">
                <div class="featured-details">
                    <h3 class="featured-title">The Love Hypothesis</h3>
                    <p class="featured-author">By Ali Hazelwood</p>
                    <p class="featured-description">When a fake relationship between scientists meets the irresistible force of attraction, it throws one woman's carefully calculated theories on love into chaos.</p>
                    <div class="featured-ratings">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <span>4.5</span>
                    </div>
                </div>
            </div>
            <div class="featured-book">
                <img src="https://m.media-amazon.com/images/I/81s0B6NYXML.jpg" alt="It Ends With Us" class="featured-cover">
                <div class="featured-details">
                    <h3 class="featured-title">It Ends With Us</h3>
                    <p class="featured-author">By Colleen Hoover</p>
                    <p class="featured-description">A brave and heartbreaking novel that digs its claws into you and doesn't let go, long after you've finished it. This "glorious and touching read" tackles tough subject matter with compassion and grace.</p>
                    <div class="featured-ratings">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <span>4.7</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Fiction Category -->
    <section class="category-section">
        <div class="category-header">
            <h2 class="category-title">Fiction Books</h2>
            <a href="views/login.jsp" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
        </div>
        <div class="books-grid">
            <!-- Book 1 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/51Z0nLAfLmL.jpg" alt="The Alchemist" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">The Alchemist</h3>
                    <p class="book-author">By Paulo Coelho</p>
                    <span class="book-genre">Fiction</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.6</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 2 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/816-d6SM1BL.jpg" alt="Where the Crawdads Sing" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">Where the Crawdads Sing</h3>
                    <p class="book-author">By Delia Owens</p>
                    <span class="book-genre">Fiction</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.6</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 3 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/81s0B6NYXML.jpg" alt="It Ends With Us" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">It Ends With Us</h3>
                    <p class="book-author">By Colleen Hoover</p>
                    <span class="book-genre">Fiction</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.7</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 4 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/81dQwQlmAXL.jpg" alt="The Midnight Library" class="book-cover">
                <div class="book-details">
                    <h3class="book-title">The Midnight Library</h3>
                    <p class="book-author">By Matt Haig</p>
                    <span class="book-genre">Fiction</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.3</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Fantasy Category -->
    <section class="category-section">
        <div class="category-header">
            <h2 class="category-title">Fantasy Books</h2>
            <a href="views/login.jsp" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
        </div>
        <div class="books-grid">
            <!-- Book 1 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/81YOuOGFCJL.jpg" alt="Harry Potter and the Philosopher's Stone" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">Harry Potter and the Philosopher's Stone</h3>
                    <p class="book-author">By J.K. Rowling</p>
                    <span class="book-genre">Fantasy</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.8</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 2 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/71jwDNqAHrL.jpg" alt="Harry Potter and the Chamber of Secrets" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">Harry Potter and the Chamber of Secrets</h3>
                    <p class="book-author">By J.K. Rowling</p>
                    <span class="book-genre">Fantasy</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.7</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 3 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/91KukDv6C+L.jpg" alt="The Lord of the Rings" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">The Lord of the Rings</h3>
                    <p class="book-author">By J.R.R. Tolkien</p>
                    <span class="book-genre">Fantasy</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.9</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 4 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/91-EIJiYneL.jpg" alt="A Court of Thorns and Roses" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">A Court of Thorns and Roses</h3>
                    <p class="book-author">By Sarah J. Maas</p>
                    <span class="book-genre">Fantasy</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.5</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Self-Help Category -->
    <section class="category-section">
        <div class="category-header">
            <h2 class="category-title">Self-Help Books</h2>
            <a href="views/login.jsp" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
        </div>
        <div class="books-grid">
            <!-- Book 1 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/91KS3nAZmAL.jpg" alt="Atomic Habits" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">Atomic Habits</h3>
                    <p class="book-author">By James Clear</p>
                    <span class="book-genre">Self-Help</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.8</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 2 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/71t4GuxLCuL.jpg" alt="The 7 Habits of Highly Effective People" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">The 7 Habits of Highly Effective People</h3>
                    <p class="book-author">By Stephen R. Covey</p>
                    <span class="book-genre">Self-Help</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.7</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 3 - Replaced inappropriate title -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/71QKQ9mwV7L.jpg" alt="The Subtle Art of Not Caring" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">The Subtle Art of Not Caring</h3>
                    <p class="book-author">By Mark Manson</p>
                    <span class="book-genre">Self-Help</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.5</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>

            <!-- Book 4 -->
            <div class="book-card">
                <img src="https://m.media-amazon.com/images/I/61aDPH3eSxL.jpg" alt="Thinking, Fast and Slow" class="book-cover">
                <div class="book-details">
                    <h3 class="book-title">Thinking, Fast and Slow</h3>
                    <p class="book-author">By Daniel Kahneman</p>
                    <span class="book-genre">Self-Help</span>
                    <div class="book-actions">
                        <div class="book-ratings">
                            <i class="fas fa-star"></i>
                            <span>4.6</span>
                        </div>
                        <a href="views/login.jsp" class="borrow-btn">Borrow</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Member Banner -->
    <section class="banner">
        <div class="banner-bg"></div>
        <div class="banner-content">
            <h2 class="banner-title">Become a Member Today</h2>
            <p class="banner-text">Sign up to borrow books, save your favorites, and get personalized recommendations. Create your account for free and start enjoying our collection.</p>
            <a href="views/register.jsp" class="banner-btn">Sign Up Now <i class="fas fa-arrow-right"></i></a>
        </div>
    </section>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-col">
            <div class="footer-logo">
                <i class="fas fa-book-reader"></i>
                <span>LibraryMS</span>
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

        <div class="footer-col">
            <h3 class="footer-title">Quick Links</h3>
            <ul class="footer-links">
                <li class="footer-link"><a href="index.jsp"><i class="fas fa-chevron-right"></i> Home</a></li>
                <li class="footer-link"><a href="about.jsp"><i class="fas fa-chevron-right"></i> About Us</a></li>
                <li class="footer-link"><a href="contact.jsp"><i class="fas fa-chevron-right"></i> Contact</a></li>
                <li class="footer-link"><a href="books.jsp"><i class="fas fa-chevron-right"></i> Books</a></li>
                <li class="footer-link"><a href="faq.jsp"><i class="fas fa-chevron-right"></i> FAQ</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h3 class="footer-title">Our Services</h3>
            <ul class="footer-links">
                <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> Book Catalog</a></li>
                <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> Borrowing Management</a></li>
                <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> User Management</a></li>
                <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> Reporting & Analytics</a></li>
                <li class="footer-link"><a href="#"><i class="fas fa-chevron-right"></i> Online Access</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h3 class="footer-title">Contact Us</h3>
            <ul class="footer-links">
                <li class="footer-link">
                    <a href="#">
                        <i class="fas fa-map-marker-alt"></i> 123 Library Street, Knowledge City, 54321
                    </a>
                </li>
                <li class="footer-link">
                    <a href="#">
                        <i class="fas fa-phone-alt"></i> +1 (123) 456-7890
                    </a>
                </li>
                <li class="footer-link">
                    <a href="#">
                        <i class="fas fa-envelope"></i> info@libraryms.com
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <div class="footer-bottom">
        &copy; 2025 LibraryMS. All rights reserved. Designed by Apeksha Neupane and The Group.
    </div>
</footer>

<script>
    // Mobile menu toggle
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const navLinks = document.querySelector('.nav-links');
    const navAuth = document.querySelector('.nav-auth');

    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', function() {
            navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
            navAuth.style.display = navAuth.style.display === 'flex' ? 'none' : 'flex';
        });
    }
</script>
</body>
</html>