<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
  <div class="sidebar-header">
    <a href="${pageContext.request.contextPath}/student/dashboard" class="sidebar-logo">
      <i class="fas fa-book-reader"></i>
      <span>LibraryMS</span>
    </a>
  </div>
  <ul class="nav-items">
    <li class="nav-item">
      <a href="${pageContext.request.contextPath}/student/dashboard" class="nav-link ${activeTab == 'dashboard' ? 'active' : ''}">
        <i class="fas fa-home"></i>
        <span>Dashboard</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="${pageContext.request.contextPath}/student/search-books" class="nav-link ${activeTab == 'search-books' ? 'active' : ''}">
        <i class="fas fa-search"></i>
        <span>Search Books</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="${pageContext.request.contextPath}/student/my-books" class="nav-link ${activeTab == 'my-books' ? 'active' : ''}">
        <i class="fas fa-book"></i>
        <span>My Books</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="${pageContext.request.contextPath}/student/history" class="nav-link ${activeTab == 'history' ? 'active' : ''}">
        <i class="fas fa-history"></i>
        <span>Borrowing History</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="${pageContext.request.contextPath}/student/fines" class="nav-link ${activeTab == 'fines' ? 'active' : ''}">
        <i class="fas fa-rupee-sign"></i>
        <span>My Fines</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="${pageContext.request.contextPath}/profile" class="nav-link ${activeTab == 'profile' ? 'active' : ''}">
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