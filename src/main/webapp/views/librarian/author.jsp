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
    <title>Manage Authors - LibraryMS</title>
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

        /* Author Form */
        .author-container {
            max-width: 850px;
            margin: 0 auto;
        }

        .author-form {
            background: white;
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            transition: var(--transition);
        }

        .author-form:hover {
            box-shadow: var(--shadow-lg);
        }

        .form-header {
            margin-bottom: 2rem;
            text-align: center;
        }

        .form-title {
            color: var(--dark-color);
            font-size: 1.8rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            color: #666;
            font-size: 1rem;
            max-width: 600px;
            margin: 0 auto;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 0.5rem;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
            font-weight: 600;
            font-size: 0.9rem;
        }

        .form-label .required {
            color: var(--error-color);
            margin-left: 0.2rem;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid rgba(0,0,0,0.05);
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background-color: #fff;
            height: 45px;
            color: var(--dark-color);
        }

        .form-control:hover {
            border-color: rgba(108, 99, 255, 0.3);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(108, 99, 255, 0.1);
        }

        .form-control:read-only {
            background-color: rgba(108, 99, 255, 0.05);
            cursor: not-allowed;
            border-color: rgba(108, 99, 255, 0.1);
        }

        .form-control:read-only:hover {
            border-color: rgba(108, 99, 255, 0.1);
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
            height: auto;
            line-height: 1.5;
        }

        .submit-btn {
            background: var(--gradient-bg);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
            height: 50px;
            box-shadow: var(--shadow-md);
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .error-message {
            color: var(--error-color);
            font-size: 0.8rem;
            margin-top: 0.5rem;
            padding: 0.4rem 0.8rem;
            display: none;
            border-radius: 8px;
            background-color: rgba(239, 68, 68, 0.08);
            font-weight: 500;
        }

        .success-message {
            background: rgba(16, 185, 129, 0.08);
            color: var(--success-color);
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
            display: none;
            text-align: center;
            font-weight: 600;
            border-left: 4px solid var(--success-color);
        }

        .id-info {
            color: #666;
            font-size: 0.85rem;
            margin-top: 0.4rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .id-info i {
            color: var(--primary-color);
            font-size: 0.85rem;
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

        /* Responsive adjustments */
        @media (max-width: 1200px) {
            .form-grid {
                gap: 1.2rem;
            }

            .author-form {
                padding: 2rem;
            }
        }

        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
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

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full-width {
                grid-column: auto;
            }

            .mobile-menu-toggle {
                display: flex;
            }
        }

        @media (max-width: 576px) {
            .author-form {
                padding: 1.5rem;
            }

            .form-header {
                margin-bottom: 1.5rem;
            }

            .form-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include the common sidebar -->
    <jsp:include page="../components/sidebar.jsp">
        <jsp:param name="activePage" value="author"/>
    </jsp:include>

    <!-- Header -->
    <header class="header">
        <h1 class="header-title">
            <i class="fas fa-pen-fancy"></i>
            Manage Authors
        </h1>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="author-container">
            <div class="author-form">
                <div class="form-header">
                    <h2 class="form-title">Add New Author</h2>
                    <p class="form-subtitle">Enter the author's details to add them to the library database</p>
                </div>

                <div class="success-message" id="successMessage">
                    <i class="fas fa-check-circle"></i> Author added successfully to the database!
                </div>

                <form id="addAuthorForm" action="${pageContext.request.contextPath}/librarian/add-author" method="POST">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="authorId">Author ID</label>
                            <input type="text" class="form-control" id="authorId" name="authorId" readonly
                                   placeholder="Auto-generated ID">
                            <p class="id-info">
                                <i class="fas fa-info-circle"></i>
                                ID will be automatically generated when adding a new author
                            </p>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="authorName">Author Name<span class="required">*</span></label>
                            <input type="text" class="form-control" id="authorName" name="authorName" required
                                   placeholder="Enter author's full name">
                            <div class="error-message" id="authorNameError">
                                <i class="fas fa-exclamation-circle"></i> Author name is required
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="birthDate">Birth Date</label>
                            <input type="date" class="form-control" id="birthDate" name="birthDate">
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="nationality">Nationality</label>
                            <input type="text" class="form-control" id="nationality" name="nationality"
                                   placeholder="Enter author's nationality">
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="awards">Awards</label>
                            <input type="text" class="form-control" id="awards" name="awards"
                                   placeholder="Enter notable awards (comma separated)">
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label" for="biography">Biography</label>
                            <textarea class="form-control" id="biography" name="biography"
                                      placeholder="Enter author's biographical information"></textarea>
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">
                        <i class="fas fa-plus-circle"></i>
                        Add Author
                    </button>
                </form>
            </div>
        </div>
    </main>

    <script>
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

        // Form validation and submission
        document.getElementById('addAuthorForm').addEventListener('submit', function(e) {
            e.preventDefault();

            // Validate author name
            const authorName = document.getElementById('authorName').value.trim();
            const authorNameError = document.getElementById('authorNameError');

            if (!authorName) {
                authorNameError.style.display = 'block';
                return;
            } else {
                authorNameError.style.display = 'none';
            }

            // Form submission
            const formData = new FormData(this);

            fetch(this.action, {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
                .then(response => response.json())
                .then(data => {
                    const successMessage = document.getElementById('successMessage');
                    if (data.success) {
                        successMessage.style.display = 'block';
                        this.reset();

                        // Scroll to top to show success message
                        window.scrollTo({
                            top: 0,
                            behavior: 'smooth'
                        });

                        setTimeout(() => {
                            successMessage.style.display = 'none';
                        }, 4000);
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while adding the author');
                });
        });

        // Add animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Animate form appearance
            const form = document.querySelector('.author-form');
            setTimeout(() => {
                form.style.transform = 'translateY(0)';
                form.style.opacity = '1';
            }, 100);

            // Set max date for birth date picker to current date
            const birthDateInput = document.getElementById('birthDate');
            const today = new Date();
            const yyyy = today.getFullYear();
            let mm = today.getMonth() + 1;
            let dd = today.getDate();

            if (mm < 10) mm = '0' + mm;
            if (dd < 10) dd = '0' + dd;

            const maxDate = yyyy + '-' + mm + '-' + dd;
            birthDateInput.setAttribute('max', maxDate);
        });
    </script>
</body>
</html>