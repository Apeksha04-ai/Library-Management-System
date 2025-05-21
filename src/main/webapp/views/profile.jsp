<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Profile - Library Management System</title>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
    <style>
        :root {
            --primary-color: #6c63ff;
            --secondary-color: #4a41d7;
            --dark-color: #2a2f4f;
            --light-color: #f7f7fc;
            --success-color: #10b981;
            --error-color: #ef4444;
            --warning-color: #f59e0b;
            --accent-color: #ff6c63;
            --gray-light: #f5f5f5;
            --gray: #9e9e9e;
            --shadow-sm: 0 2px 10px rgba(108, 99, 255, 0.1);
            --shadow-md: 0 4px 20px rgba(108, 99, 255, 0.15);
            --shadow-lg: 0 10px 40px rgba(108, 99, 255, 0.2);
            --border-radius: 16px;
            --card-radius: 14px;
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            --gradient-bg: linear-gradient(135deg, #6c63ff 0%, #4a41d7 100%);
            --sidebar-width: 260px;
            --header-height: 70px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif;
        }

        body {
            background-color: var(--light-color);
            min-height: 100vh;
            color: var(--dark-color);
            line-height: 1.6;
            overflow-x: hidden;
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
            justify-content: space-between;
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
            display: flex;
            flex-direction: column;
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
            flex-grow: 1;
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

        /* Logout section */
        .logout-section {
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.05);
            margin-top: auto;
        }

        .logout-link {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--error-color);
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            gap: 1rem;
            font-weight: 600;
        }

        .logout-link:hover {
            background: rgba(239, 68, 68, 0.08);
            transform: translateX(5px);
        }

        .logout-link i {
            width: 22px;
            font-size: 1.1rem;
        }
        
        /* Main content adjustment */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2.5rem;
            min-height: calc(100vh - var(--header-height));
            background: var(--light-color);
            padding-top: calc(var(--header-height) + 20px);
        }
        
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1.5rem;
                padding-top: calc(var(--header-height) + 20px);
            }
            
            .header {
                left: 0;
            }

            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
                width: 280px;
            }

            .mobile-menu-toggle {
                display: flex;
            }
        }

        .profile-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: var(--dark-color);
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 2rem;
            transition: var(--transition);
        }

        .back-link:hover {
            color: var(--primary-color);
            transform: translateX(-5px);
        }

        .back-icon {
            margin-right: 0.5rem;
        }

        .profile-header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            font-size: 1rem;
            color: var(--gray);
        }

        .alert {
            padding: 1rem;
            border-radius: var(--card-radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            box-shadow: var(--shadow-sm);
        }

        .alert-icon {
            margin-right: 1rem;
            font-size: 1.5rem;
        }

        .alert-success {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }

        .alert-danger {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
            border-left: 4px solid var(--error-color);
        }

        .profile-content {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 2rem;
        }

        .profile-sidebar {
            background-color: white;
            border-radius: var(--card-radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            height: fit-content;
        }

        .profile-image-container {
            position: relative;
            width: 100%;
            height: 200px;
            background: var(--gradient-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }

        .profile-image {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 5px solid white;
            object-fit: cover;
            background-color: white;
            box-shadow: var(--shadow-md);
        }

        .profile-image-placeholder {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 5px solid white;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            color: var(--gray);
            box-shadow: var(--shadow-md);
        }

        .profile-info {
            padding: 0 1.5rem 1.5rem;
        }

        .profile-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            text-align: center;
        }

        .profile-role {
            font-size: 1rem;
            color: var(--gray);
            margin-bottom: 1.5rem;
            text-align: center;
            background-color: var(--light-color);
            padding: 0.3rem 1rem;
            border-radius: 30px;
            display: inline-block;
            margin-left: 50%;
            transform: translateX(-50%);
        }

        .info-item {
            display: flex;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .info-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .info-icon {
            width: 40px;
            height: 40px;
            background-color: var(--light-color);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 0.9rem;
            color: var(--gray);
            margin-bottom: 0.3rem;
        }

        .info-value {
            font-size: 1rem;
            color: var(--dark-color);
            font-weight: 600;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .profile-main {
            background-color: white;
            border-radius: var(--card-radius);
            box-shadow: var(--shadow-sm);
            padding: 2rem;
        }

        .section-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .edit-button {
            background-color: var(--light-color);
            color: var(--primary-color);
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            box-shadow: var(--shadow-sm);
        }

        .edit-button:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .edit-icon {
            margin-right: 0.5rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background-color: white;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.1);
        }

        .form-control:disabled {
            background-color: var(--gray-light);
            cursor: not-allowed;
            color: var(--gray);
        }

        .form-grid-full {
            grid-column: span 2;
        }

        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background-color: var(--gray-light);
            color: var(--dark-color);
        }

        .btn-secondary:hover {
            background-color: var(--gray);
            color: white;
            transform: translateY(-2px);
        }

        .password-section {
            margin-top: 2rem;
        }

        .edit-profile-pic {
            position: absolute;
            bottom: 20px;
            right: 20px;
            background-color: white;
            color: var(--primary-color);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-md);
            transition: var(--transition);
            cursor: pointer;
            z-index: 10;
        }

        .edit-profile-pic:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-3px) scale(1.05);
        }

        .upload-form {
            display: none;
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

        @media (max-width: 768px) {
            .profile-content {
                grid-template-columns: 1fr;
            }

            .profile-image-container {
                height: 180px;
            }

            .profile-image,
            .profile-image-placeholder {
                width: 120px;
                height: 120px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-grid-full {
                grid-column: span 1;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<% User currentUser = (User) session.getAttribute("user"); if (currentUser
        == null) { response.sendRedirect(request.getContextPath() +
        "/views/login.jsp"); return; } String name = currentUser.getName(); String
        email = currentUser.getEmail(); String phone = currentUser.getPhone();
    String role = currentUser.getRole(); String profileImage =
            currentUser.getImageUrl(); String successMessage = (String)
            request.getAttribute("successMessage"); String errorMessage = (String)
            request.getAttribute("errorMessage"); 
    
    // Determine the dashboard URL based on role
    String dashboardUrl = "Librarian".equals(role) ?
            request.getContextPath() + "/views/librarian/dashboard.jsp" :
            "Student".equals(role) ? request.getContextPath() +
                    "/views/student/dashboard.jsp" : request.getContextPath() +
                    "/views/dashboard/index.jsp"; %>
<!-- Mobile Menu Toggle -->
<div class="mobile-menu-toggle" id="mobileMenuToggle">
    <i class="fas fa-bars"></i>
</div>

<!-- Sidebar based on role -->
<% if ("Student".equals(role)) { %>
<c:set var="activeTab" value="profile" scope="request" />
<jsp:include page="student/includes/sidebar.jsp" />
<% } else if ("Librarian".equals(role)) { %>
<jsp:include page="components/sidebar.jsp">
    <jsp:param name="activePage" value="profile" />
</jsp:include>
<% } else { %>
<!-- Default sidebar for any other role -->
<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <a href="<%= dashboardUrl %>" class="sidebar-logo">
            <i class="fas fa-book-reader"></i>
            <span>LibraryMS</span>
        </a>
    </div>
    <ul class="nav-items">
        <li class="nav-item">
            <a href="<%= dashboardUrl %>" class="nav-link">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a
                    href="${pageContext.request.contextPath}/views/profile.jsp"
                    class="nav-link active"
            >
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </li>
    </ul>
    <div class="logout-section">
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</aside>
<% } %>

<!-- Header -->
<header class="header">
    <h1 class="header-title">
        <i class="fas fa-user"></i>
        My Profile
    </h1>
</header>

<!-- Main Content -->
<main class="main-content">
    <div class="profile-container">
        <a href="<%= dashboardUrl %>" class="back-link">
            <i class="fas fa-arrow-left back-icon"></i> Back to Dashboard
        </a>

        <div class="profile-header">
            <h1 class="page-title">My Profile</h1>
            <p class="page-subtitle">View and update your personal information</p>
        </div>

        <% if (successMessage != null && !successMessage.isEmpty()) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle alert-icon"></i>
            <%= successMessage %>
        </div>
        <% } %> <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle alert-icon"></i>
            <%= errorMessage %>
        </div>
        <% } %>

        <div class="profile-content">
            <div class="profile-sidebar">
                <div class="profile-image-container">
                    <% if (profileImage != null && !profileImage.isEmpty()) { %>
                    <img
                            src="<%= request.getContextPath() %>/<%= profileImage %>"
                            alt="Profile Picture"
                            class="profile-image"
                    />
                    <% } else { %>
                    <div class="profile-image-placeholder">
                        <i class="fas fa-user"></i>
                    </div>
                    <% } %>
                    <div class="edit-profile-pic" id="uploadTrigger">
                        <i class="fas fa-camera"></i>
                    </div>
                </div>

                <div class="profile-info">
                    <h2 class="profile-name"><%= name %></h2>
                    <p class="profile-role"><%= role %></p>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Email</div>
                            <div class="info-value"><%= email %></div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Phone</div>
                            <div class="info-value"><%= phone %></div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-user-tag"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Role</div>
                            <div class="info-value"><%= role %></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="profile-main">
                <div class="profile-edit-section">
                    <div class="section-title">
                        Personal Information
                        <button class="edit-button" id="editToggle">
                            <i class="fas fa-edit edit-icon"></i> Edit
                        </button>
                    </div>

                    <form
                            action="<%= request.getContextPath() %>/updateProfileServlet"
                            method="post"
                            id="profileForm"
                    >
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="name" class="form-label">Full Name</label>
                                <input
                                        type="text"
                                        class="form-control"
                                        id="name"
                                        name="name"
                                        value="<%= name %>"
                                        disabled
                                        required
                                />
                            </div>

                            <div class="form-group">
                                <label for="email" class="form-label">Email Address</label>
                                <input
                                        type="email"
                                        class="form-control"
                                        id="email"
                                        name="email"
                                        value="<%= email %>"
                                        disabled
                                        required
                                />
                            </div>

                            <div class="form-group">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input
                                        type="tel"
                                        class="form-control"
                                        id="phone"
                                        name="phone"
                                        value="<%= phone %>"
                                        disabled
                                        required
                                />
                            </div>

                            <div class="form-group">
                                <label for="role" class="form-label">Role</label>
                                <input
                                        type="text"
                                        class="form-control"
                                        id="role"
                                        value="<%= role %>"
                                        disabled
                                        readonly
                                />
                            </div>
                        </div>

                        <div class="button-group" id="formButtons" style="display: none">
                            <button type="button" class="btn btn-secondary" id="cancelEdit">
                                Cancel
                            </button>
                            <button type="submit" class="btn btn-primary">
                                Save Changes
                            </button>
                        </div>
                    </form>
                </div>

                <div class="password-section">
                    <div class="section-title">Change Password</div>

                    <form
                            action="<%= request.getContextPath() %>/changePasswordServlet"
                            method="post"
                    >
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="currentPassword" class="form-label"
                                >Current Password</label
                                >
                                <input
                                        type="password"
                                        class="form-control"
                                        id="currentPassword"
                                        name="currentPassword"
                                        required
                                />
                            </div>

                            <div class="form-group">
                                <label for="newPassword" class="form-label"
                                >New Password</label
                                >
                                <input
                                        type="password"
                                        class="form-control"
                                        id="newPassword"
                                        name="newPassword"
                                        required
                                />
                            </div>

                            <div class="form-group form-grid-full">
                                <label for="confirmPassword" class="form-label"
                                >Confirm New Password</label
                                >
                                <input
                                        type="password"
                                        class="form-control"
                                        id="confirmPassword"
                                        name="confirmPassword"
                                        required
                                />
                            </div>
                        </div>

                        <div class="button-group">
                            <button type="submit" class="btn btn-primary">
                                Update Password
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Profile Picture Upload Form -->
                <form
                        action="<%= request.getContextPath() %>/updateProfilePictureServlet"
                        method="post"
                        enctype="multipart/form-data"
                        id="uploadForm"
                        class="upload-form"
                >
                    <input
                            type="file"
                            name="profilePicture"
                            id="profilePicture"
                            accept="image/*"
                    />
                    <input type="submit" value="Upload" />
                </form>
            </div>
        </div>
    </div>
</main>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const editToggle = document.getElementById("editToggle");
        const cancelEdit = document.getElementById("cancelEdit");
        const formButtons = document.getElementById("formButtons");
        const uploadTrigger = document.getElementById("uploadTrigger");
        const uploadForm = document.getElementById("uploadForm");
        const profilePicture = document.getElementById("profilePicture");
        const mobileMenuToggle = document.getElementById('mobileMenuToggle');
        const sidebar = document.getElementById('sidebar');

        // Form fields
        const formInputs = document.querySelectorAll(
            "#profileForm .form-control:not([readonly])"
        );

        // Edit mode toggle
        if (editToggle) {
            editToggle.addEventListener("click", function () {
                formInputs.forEach((input) => {
                    input.disabled = false;
                });
                formButtons.style.display = "flex";
                editToggle.style.display = "none";
            });
        }

        // Cancel edit
        if (cancelEdit) {
            cancelEdit.addEventListener("click", function () {
                formInputs.forEach((input) => {
                    input.disabled = true;
                });
                formButtons.style.display = "none";
                editToggle.style.display = "inline-flex";
            });
        }

        // Profile picture upload
        if (uploadTrigger && profilePicture) {
            uploadTrigger.addEventListener("click", function () {
                profilePicture.click();
            });

            profilePicture.addEventListener("change", function () {
                if (profilePicture.files.length > 0) {
                    uploadForm.submit();
                }
            });
        }
        
        // Mobile menu toggle functionality
        if (mobileMenuToggle && sidebar) {
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
    });
</script>
</body>
</html>
