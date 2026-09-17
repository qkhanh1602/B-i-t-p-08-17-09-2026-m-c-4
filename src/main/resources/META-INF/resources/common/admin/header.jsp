<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/category-ajax">
            <i class="fas fa-cubes me-2 text-warning"></i>IoTStar System
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/category-ajax">
                        <i class="fas fa-folder me-1"></i>Category AJAX
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/product-ajax">
                        <i class="fas fa-box-open me-1"></i>Product AJAX 
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/swagger-ui.html" target="_blank">
                        <i class="fas fa-book me-1 text-info"></i>Swagger 3 UI
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/h2-console" target="_blank">
                        <i class="fas fa-database me-1 text-success"></i>H2 Console
                    </a>
                </li>
            </ul>
            <span class="navbar-text text-light">
                <i class="fas fa-user-circle me-1"></i>Admin: <b>Nguyen Quoc Khanh</b>
            </span>
        </div>
    </div>
</nav>
