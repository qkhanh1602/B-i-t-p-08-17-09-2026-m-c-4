<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>var contextPath = "${pageContext.request.contextPath}";</script>
    <title><sitemesh:write property='title'>IoTStar System</sitemesh:write></title>
    <sitemesh:write property='head'/>
</head>
<body class="bg-light">
    <header class="row g-0">
        <div class="col">
            <%@ include file="/common/admin/header.jsp" %>
        </div>
    </header>
    <main class="container py-4">
        <div class="row">
            <div class="col">
                <sitemesh:write property='body'/>
            </div>
        </div>
    </main>
    <footer class="row g-0">
        <div class="col">
            <%@ include file="/common/admin/footer.jsp" %>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
