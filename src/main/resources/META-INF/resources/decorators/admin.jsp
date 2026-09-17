<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>
    <title><sitemesh:write property='title'>Admin Dashboard</sitemesh:write></title>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script>
        if (typeof $.fn.modal === 'undefined' && typeof bootstrap !== 'undefined') {
            $.fn.modal = function(action) {
                return this.each(function() {
                    var inst = bootstrap.Modal.getOrCreateInstance(this);
                    if (action === 'show') inst.show();
                    else if (action === 'hide') inst.hide();
                    else if (action === 'toggle') inst.toggle();
                });
            };
        }
    </script>
</body>
</html>
