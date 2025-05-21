<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>Edit Book - LibraryMS</title>
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
            --sidebar-width: 260px;
            --header-height: 70px;
            --shadow-sm: 0 2px 10px rgba(108, 99, 255, 0.1);
            --shadow-md: 0 4px 20px rgba(108, 99, 255, 0.15);
            --shadow-lg: 0 10px 40px rgba(108, 99, 255, 0.2);
            --border-radius: 16px;
            --card-radius: 14px;
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

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
            min-height: 100vh;
        }

        .header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .page-title i {
            color: var(--primary-color);
        }

        .edit-form-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.1);
        }

        .image-preview {
            width: 200px;
            height: 300px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 1rem;
            box-shadow: var(--shadow-sm);
        }

        .image-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
        }

        .btn-primary {
            background: var(--gradient-bg);
            color: white;
        }

        .btn-secondary {
            background: #e2e8f0;
            color: var(--dark-color);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            justify-content: flex-end;
        }

        .alert {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .alert-success {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .alert-error {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .file-input-container {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }

        .file-input {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
            width: 100%;
            height: 100%;
        }

        .file-input-label {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: var(--light-color);
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            color: var(--dark-color);
            transition: var(--transition);
        }

        .file-input-label:hover {
            background: #e2e8f0;
        }

        .file-name {
            margin-top: 0.5rem;
            font-size: 0.9rem;
            color: #666;
        }
    </style>
</head>
<body>
    <!-- Include the common sidebar -->
    <jsp:include page="../components/sidebar.jsp">
        <jsp:param name="activePage" value="edit-books"/>
    </jsp:include>

    <div class="main-content">
        <div class="header">
            <h1 class="page-title">
                <i class="fas fa-edit"></i>
                Edit Book
            </h1>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${successMessage}
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${errorMessage}
            </div>
        </c:if>

        <div class="edit-form-container">
            <form action="${pageContext.request.contextPath}/librarian/edit-book" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="bookId" value="${book.id}">
                
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="isbn">ISBN</label>
                        <input type="text" id="isbn" name="isbn" class="form-control" value="${book.isbn}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="title">Title</label>
                        <input type="text" id="title" name="title" class="form-control" value="${book.title}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="authorId">Author</label>
                        <select id="authorId" name="authorId" class="form-control" required>
                            <c:forEach items="${authors}" var="author">
                                <option value="${author.id}" ${author.id == book.authorId ? 'selected' : ''}>
                                    ${author.authorName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="category">Category</label>
                        <select id="category" name="category" class="form-control" required>
                            <option value="Fiction" ${book.category == 'Fiction' ? 'selected' : ''}>Fiction</option>
                            <option value="Non-Fiction" ${book.category == 'Non-Fiction' ? 'selected' : ''}>Non-Fiction</option>
                            <option value="Science" ${book.category == 'Science' ? 'selected' : ''}>Science</option>
                            <option value="Technology" ${book.category == 'Technology' ? 'selected' : ''}>Technology</option>
                            <option value="History" ${book.category == 'History' ? 'selected' : ''}>History</option>
                            <option value="Philosophy" ${book.category == 'Philosophy' ? 'selected' : ''}>Philosophy</option>
                            <option value="Biography" ${book.category == 'Biography' ? 'selected' : ''}>Biography</option>
                            <option value="Business" ${book.category == 'Business' ? 'selected' : ''}>Business</option>
                            <option value="Computers" ${book.category == 'Computers' ? 'selected' : ''}>Computers</option>
                            <option value="Art" ${book.category == 'Art' ? 'selected' : ''}>Art & Design</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="quantity">Quantity</label>
                        <input type="number" id="quantity" name="quantity" class="form-control" value="${book.quantity}" min="0" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="publicationDate">Publication Date</label>
                        <input type="date" id="publicationDate" name="publicationDate" class="form-control" 
                               value="<fmt:formatDate value="${book.publicationDate}" pattern="yyyy-MM-dd"/>" required>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label">Cover Image</label>
                        <div class="image-preview">
                            <c:choose>
                                <c:when test="${not empty book.coverImage}">
                                    <img src="${pageContext.request.contextPath}/uploads/books/${book.coverImage}" 
                                         alt="Book cover" id="coverPreview">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/default-book-cover.svg" 
                                         alt="Default cover" id="coverPreview">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="file-input-container">
                            <input type="file" id="coverImage" name="coverImage" class="file-input" 
                                   accept="image/*" onchange="previewImage(this)">
                            <label for="coverImage" class="file-input-label">
                                <i class="fas fa-upload"></i>
                                Choose New Cover Image
                            </label>
                        </div>
                        <div class="file-name" id="fileName"></div>
                    </div>
                </div>

                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/views/librarian/view-books.jsp" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function previewImage(input) {
            const preview = document.getElementById('coverPreview');
            const fileNameDisplay = document.getElementById('fileName');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    preview.src = e.target.result;
                }
                
                reader.readAsDataURL(input.files[0]);
                fileNameDisplay.textContent = input.files[0].name;
            }
        }

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    alert.style.transition = 'opacity 0.5s ease';
                    setTimeout(() => alert.remove(), 500);
                }, 5000);
            });
        });
    </script>
</body>
</html> 
