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
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Books - LibraryMS</title>
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

        /* Add Books Form */
        .add-books-container {
            max-width: 850px;
            margin: 0 auto;
        }

        .add-books-form {
            background: white;
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            transition: var(--transition);
        }

        .add-books-form:hover {
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

        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%236C63FF' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            padding-right: 2.5rem;
        }

        .image-upload-container {
            display: flex;
            gap: 2.5rem;
            align-items: flex-start;
            padding: 1.5rem;
            background: rgba(108, 99, 255, 0.03);
            border-radius: 12px;
            border: 1px dashed rgba(108, 99, 255, 0.2);
        }

        .image-preview {
            width: 180px;
            height: 220px;
            border: 2px dashed rgba(108, 99, 255, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            transition: var(--transition);
            background-color: white;
        }

        .image-preview:hover {
            border-color: var(--primary-color);
            background-color: rgba(108, 99, 255, 0.02);
        }

        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
            display: none;
        }

        .image-preview i {
            font-size: 4.5rem;
            color: rgba(108, 99, 255, 0.2);
        }

        .upload-instructions {
            flex: 1;
            padding: 1.2rem;
            background: white;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
        }

        .upload-instructions h4 {
            margin-bottom: 1rem;
            color: var(--dark-color);
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .upload-instructions h4 i {
            color: var(--primary-color);
        }

        .upload-instructions ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .upload-instructions li {
            margin-bottom: 0.5rem;
            color: #555;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .upload-instructions li i {
            color: var(--primary-color);
            font-size: 0.8rem;
        }

        .upload-instructions input[type="file"] {
            margin-top: 1rem;
            width: 100%;
            padding: 0.8rem;
            background: rgba(108, 99, 255, 0.03);
            border-radius: 12px;
            border: 1px dashed rgba(108, 99, 255, 0.2);
            cursor: pointer;
        }

        .upload-instructions input[type="file"]:hover {
            background: rgba(108, 99, 255, 0.05);
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

        .quantity-input {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .quantity-input .form-control {
            text-align: center;
            -moz-appearance: textfield;
            width: 80px;
            font-weight: 600;
        }

        .quantity-input .form-control::-webkit-outer-spin-button,
        .quantity-input .form-control::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .quantity-btn {
            background: white;
            border: 2px solid rgba(108, 99, 255, 0.2);
            border-radius: 10px;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            color: var(--primary-color);
        }

        .quantity-btn:hover {
            background: rgba(108, 99, 255, 0.08);
            border-color: var(--primary-color);
            transform: scale(1.05);
        }

        .quantity-btn:active {
            transform: scale(0.95);
        }

        .add-author-link {
            margin-top: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-link {
            color: var(--primary-color);
            text-decoration: none;
            padding: 0.5rem 0.8rem;
            margin: 0;
            border: none;
            background: none;
            cursor: pointer;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border-radius: 8px;
            transition: var(--transition);
            font-weight: 500;
        }

        .btn-link:hover {
            color: var(--secondary-color);
            background: rgba(108, 99, 255, 0.05);
        }

        /* Responsive adjustments */
        @media (max-width: 1200px) {
            .form-grid {
                gap: 1.2rem;
            }

            .add-books-form {
                padding: 2rem;
            }
        }

        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
            }

            .image-upload-container {
                gap: 1.5rem;
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

            .image-upload-container {
                flex-direction: column;
            }

            .image-preview {
                width: 100%;
                height: 200px;
            }
        }

        @media (max-width: 576px) {
            .add-books-form {
                padding: 1.5rem;
            }

            .form-header {
                margin-bottom: 1.5rem;
            }

            .form-title {
                font-size: 1.5rem;
            }

            .upload-instructions {
                padding: 1rem;
            }

            .add-author-link {
                flex-direction: column;
                align-items: flex-start;
            }
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
            .mobile-menu-toggle {
                display: flex;
            }
        }
    </style>
</head>
<body>
    <!-- Include the common sidebar -->
    <jsp:include page="../components/sidebar.jsp">
        <jsp:param name="activePage" value="add-books"/>
    </jsp:include>

    <!-- Mobile Menu Toggle -->
    <div class="mobile-menu-toggle" id="mobileMenuToggle">
        <i class="fas fa-bars"></i>
    </div>

    <!-- Main Content -->
    <header class="header">
        <h1 class="header-title">Add Books</h1>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="add-books-form">
            <div class="form-header">
                <h2 class="form-title">Add New Book</h2>
                <p class="form-subtitle">Enter the book details below to add it to the library collection</p>
            </div>

            <div class="success-message" id="successMessage">
                <i class="fas fa-check-circle"></i> Book added successfully to the library collection!
            </div>

            <form id="addBookForm" action="${pageContext.request.contextPath}/librarian/add-book" method="POST" enctype="multipart/form-data">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="isbn">ISBN<span class="required">*</span></label>
                        <input type="text" class="form-control" id="isbn" name="isbn" required
                               placeholder="Enter ISBN (10 or 13 digits)"
                               pattern="^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$">
                        <div class="error-message" id="isbnError">
                            <i class="fas fa-exclamation-circle"></i> Please enter a valid ISBN number
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="title">Title<span class="required">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" required
                               placeholder="Enter book title">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="authorId">Author<span class="required">*</span></label>
                        <select class="form-control" id="authorId" name="authorId" required>
                            <option value="">Select Author</option>
                            <c:choose>
                                <c:when test="${not empty authors}">
                                    <c:forEach items="${authors}" var="author">
                                        <option value="${author.id}">${author.authorName} (ID: ${author.id})</option>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <option value="" disabled>No authors available</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                        <div class="error-message" id="authorError">
                            <i class="fas fa-exclamation-circle"></i> Please select an author
                        </div>
                        <div class="add-author-link">
                            <a href="${pageContext.request.contextPath}/librarian/author" class="btn btn-link">
                                <i class="fas fa-plus-circle"></i> Add New Author
                            </a>
                            <button type="button" class="btn btn-link" onclick="refreshAuthors()">
                                <i class="fas fa-sync-alt"></i> Refresh Authors
                            </button>
                        </div>
                        <!-- Debug info -->
                        <div style="font-size: 0.8em; margin-top: 5px;">
                            <c:if test="${not empty authors}">
                                <span style="color: green;">Available Authors: ${authors.size()}</span>
                            </c:if>
                            <c:if test="${empty authors}">
                                <span style="color: red;">No authors loaded. Please check the database connection.</span>
                            </c:if>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="category">Category<span class="required">*</span></label>
                        <select class="form-control" id="category" name="category" required>
                            <option value="">Select Category</option>
                            <option value="Fiction">Fiction</option>
                            <option value="Non-Fiction">Non-Fiction</option>
                            <option value="Science">Science</option>
                            <option value="Technology">Technology</option>
                            <option value="History">History</option>
                            <option value="Philosophy">Philosophy</option>
                            <option value="Biography">Biography</option>
                            <option value="Business">Business</option>
                            <option value="Computers">Computers</option>
                            <option value="Art">Art & Design</option>
                        </select>
                        <div class="error-message" id="categoryError">
                            <i class="fas fa-exclamation-circle"></i> Please select a category
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="publicationDate">Publication Date<span class="required">*</span></label>
                        <input type="date" class="form-control" id="publicationDate" name="publicationDate" required>
                        <div class="error-message" id="publicationDateError">
                            <i class="fas fa-exclamation-circle"></i> Please select a publication date
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="quantity">Quantity<span class="required">*</span></label>
                        <div class="quantity-input">
                            <button type="button" class="quantity-btn" onclick="decrementQuantity()">
                                <i class="fas fa-minus"></i>
                            </button>
                            <input type="number" class="form-control" id="quantity" name="quantity"
                                   required min="1" value="1">
                            <button type="button" class="quantity-btn" onclick="incrementQuantity()">
                                <i class="fas fa-plus"></i>
                            </button>
                        </div>
                        <div class="error-message" id="quantityError">
                            <i class="fas fa-exclamation-circle"></i> Quantity must be at least 1
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label" for="bookImage">Book Cover Image</label>
                        <div class="image-upload-container">
                            <div class="image-preview" id="imagePreview">
                                <i class="fas fa-book" id="defaultIcon"></i>
                                <img src="" alt="Book Cover Preview" id="previewImg">
                            </div>
                            <div class="upload-instructions">
                                <h4>Image Guidelines</h4>
                                <ul>
                                    <li><i class="fas fa-check"></i> Maximum file size: 5MB</li>
                                    <li><i class="fas fa-check"></i> Recommended dimensions: 800x1200px</li>
                                    <li><i class="fas fa-check"></i> Accepted formats: JPG, PNG, WebP</li>
                                    <li><i class="fas fa-check"></i> Clear, high-quality image</li>
                                </ul>
                                <input type="file" class="form-control" id="bookImage" name="bookImage"
                                       accept="image/*" onchange="previewImage(this)">
                            </div>
                        </div>
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-plus-circle"></i>
                    Add Book to Collection
                </button>
            </form>
        </div>
    </main>

    <script>
        function previewImage(input) {
            const preview = document.getElementById('previewImg');
            const defaultIcon = document.getElementById('defaultIcon');

            if (input.files && input.files[0]) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    preview.style.display = 'block';
                    defaultIcon.style.display = 'none';
                    preview.src = e.target.result;
                }

                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = 'none';
                defaultIcon.style.display = 'block';
                preview.src = '';
            }
        }

        function incrementQuantity() {
            const quantityInput = document.getElementById('quantity');
            const currentValue = parseInt(quantityInput.value) || 0;
            quantityInput.value = currentValue + 1;
            validateQuantity(quantityInput);
        }

        function decrementQuantity() {
            const quantityInput = document.getElementById('quantity');
            const currentValue = parseInt(quantityInput.value) || 0;
            if (currentValue > 1) {
                quantityInput.value = currentValue - 1;
            }
            validateQuantity(quantityInput);
        }

        function validateQuantity(input) {
            const errorElement = document.getElementById('quantityError');
            const value = parseInt(input.value) || 0;

            if (value < 1) {
                errorElement.style.display = 'block';
                input.value = 1;
            } else {
                errorElement.style.display = 'none';
            }
        }

        // Form validation
        document.getElementById('addBookForm').addEventListener('submit', function(e) {
            e.preventDefault();

            // Get all required fields
            const isbn = document.getElementById('isbn').value.trim();
            const title = document.getElementById('title').value.trim();
            const authorId = document.getElementById('authorId').value;
            const category = document.getElementById('category').value;
            const publicationDate = document.getElementById('publicationDate').value;
            const quantity = parseInt(document.getElementById('quantity').value) || 0;

            let hasError = false;

            // Validate ISBN
            if (!isbn || !isbn.match(/^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$/)) {
                document.getElementById('isbnError').style.display = 'block';
                hasError = true;
            } else {
                document.getElementById('isbnError').style.display = 'none';
            }

            // Validate Title
            if (!title) {
                hasError = true;
            }

            // Validate Author
            if (!authorId) {
                document.getElementById('authorError').style.display = 'block';
                hasError = true;
            } else {
                document.getElementById('authorError').style.display = 'none';
            }

            // Validate Category
            if (!category) {
                document.getElementById('categoryError').style.display = 'block';
                hasError = true;
            } else {
                document.getElementById('categoryError').style.display = 'none';
            }

            // Validate Publication Date
            if (!publicationDate) {
                document.getElementById('publicationDateError').style.display = 'block';
                hasError = true;
            } else {
                document.getElementById('publicationDateError').style.display = 'none';
            }

            // Validate Quantity
            if (quantity < 1) {
                document.getElementById('quantityError').style.display = 'block';
                hasError = true;
            } else {
                document.getElementById('quantityError').style.display = 'none';
            }

            if (!hasError) {
                const formData = new FormData(this);

                fetch(this.action, {
                    method: 'POST',
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        const successMessage = document.getElementById('successMessage');
                        if (data.success) {
                            successMessage.style.display = 'block';
                            this.reset();
                            document.getElementById('previewImg').style.display = 'none';
                            document.getElementById('defaultIcon').style.display = 'block';
                            setTimeout(() => {
                                successMessage.style.display = 'none';
                            }, 3000);
                        } else {
                            alert(data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred while adding the book');
                    });
            }
        });

        function refreshAuthors() {
            window.location.href = '${pageContext.request.contextPath}/librarian/add-book';
        }
    </script>
</body>
</html>
