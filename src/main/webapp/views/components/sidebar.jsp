<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/views/librarian/dashboard.jsp" class="sidebar-logo">
            <i class="fas fa-book-reader"></i>
            <span>LibraryMS</span>
        </a>
    </div>
    <ul class="nav-items">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/dashboard.jsp" class="nav-link ${param.activePage == 'dashboard' ? 'active' : ''}">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/add-books.jsp" class="nav-link ${param.activePage == 'add-books' ? 'active' : ''}">
                <i class="fas fa-plus-circle"></i>
                <span>Add Books</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/view-books.jsp" class="nav-link ${param.activePage == 'view-books' ? 'active' : ''}">
                <i class="fas fa-book"></i>
                <span>View Books</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/author.jsp" class="nav-link ${param.activePage == 'author' ? 'active' : ''}">
                <i class="fas fa-pen-fancy"></i>
                <span>Manage Authors</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/edit-books.jsp" class="nav-link ${param.activePage == 'edit-books' ? 'active' : ''}">
                <i class="fas fa-edit"></i>
                <span>Edit Books</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/librarian/borrowed-books.jsp" class="nav-link ${param.activePage == 'borrowed-books' ? 'active' : ''}">
                <i class="fas fa-clipboard-list"></i>
                <span>Borrowed Books</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/librarian/return-history" class="nav-link ${param.activePage == 'return-history' ? 'active' : ''}">
                <i class="fas fa-history"></i>
                <span>Return History</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/views/profile.jsp" class="nav-link ${param.activePage == 'profile' ? 'active' : ''}">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </li>
    </ul>
    <!-- Logout Section -->
    <div class="logout-section">
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</aside>

<!-- Mobile Menu Toggle -->
<div class="mobile-menu-toggle" id="mobileMenuToggle">
    <i class="fas fa-bars"></i>
</div>

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
</script> 