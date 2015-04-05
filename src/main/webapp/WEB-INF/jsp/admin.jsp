<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 28.02.2015
  Time: 13:15
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="true"%>
<html>
<head>
    <meta charset="utf-8">
    <title>Admins page</title>
    <script src="${pageContext.request.contextPath}/sources/js/bootstrap-modal.js"></script>
    <script src="${pageContext.request.contextPath}/sources/js/jquery-2.1.3.min.js"></script>
    <link href="${pageContext.request.contextPath}/sources/css/admin.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/sources/css/shop-item.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sources/css/bootstrap-theme.min.css">
    <script src="${pageContext.request.contextPath}/sources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/sources/js/bootstrap-dropdown.js"></script>


</head>

<body>
<script>
    function showOrderDetails(idOrder) {
        $('#showOrderDetails').empty();
        $.get("${pageContext.request.contextPath}/orders/"+idOrder, function (data) {
            $('#showOrderDetails').html(data);
        });
    }
    function show(path) {
        $.get("${pageContext.request.contextPath}" + path, function (data) {
            $("#myContent").html(data);
        });
    }
</script>
<div id="header" class="navbar navbar-default navbar-fixed-top">
    <div class="navbar-header">
        <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse"><i
                class="icon-reorder"></i>

        </button>
        <a class="navbar-brand" href="/">
            Site
        </a>

    </div>
    <nav class="collapse navbar-collapse">
        <ul class="nav navbar-nav">
            <li><a href="#" onclick="show('/orders/orders_get')" class="">Orders</a>

            </li>
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Navbar Item 2<b
                    class="caret"></b></a>

                <ul class="dropdown-menu">
                    <li><a href="#" class="">Navbar Item2 - Sub Item 1</a>
                    </li>
                </ul>
            </li>
            <li><a href="#" class="">Navbar Item 3</a>

            </li>
        </ul>
        <ul class="nav navbar-nav pull-right">
            <li class="dropdown"><a href="#" id="nbAcctDD" class="dropdown-toggle" data-toggle="dropdown"><i
                    class="icon-user"></i>${pageContext.request.userPrincipal.name}<i class="icon-sort-down"></i></a>

                <ul class="dropdown-menu pull-right">
                    <li><a href="/j_spring_security_logout"> Logout</a>
                    </li>
                </ul>
            </li>
        </ul>
    </nav>
</div>
<div id="wrapper" class="">
    <div id="sidebar-wrapper" class="col-md-1">
        <div id="sidebar" class="">
            <ul class="nav list-group">
                <li onclick="show('/admin/category_get')"><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>Category</a>

                </li>
                <li onclick="show('/admin/brand_get')"><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>Brand</a>

                </li>
                <li onclick="show('/admin/attribute_get')"><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>Attribute</a>

                </li>
                <li onclick="show('/admin/product_get')"><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>Product</a>

                </li>
                <li onclick="show('/admin/user_get')"><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>Users</a>

                </li>
            </ul>
        </div>
    </div>
    <div id="main-wrapper" class="col-md-11 pull-right">
        <div id="main" class="">
            <div id="myContent"></div>
        </div>
    </div>
</div>

</body>
</html>

