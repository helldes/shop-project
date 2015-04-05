<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 25.03.2015
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="true"%>
<html>
<head>
  <meta charset="utf-8">
  <title>Manager page</title>
  <script src="${pageContext.request.contextPath}/sources/js/jquery-2.1.3.min.js"></script>
  <link href="${pageContext.request.contextPath}/sources/css/admin.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/sources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/sources/css/bootstrap-theme.min.css">
  <script src="${pageContext.request.contextPath}/sources/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/sources/js/bootstrap-dropdown.js"></script>

</head>

<body>
<script>
  function showOrderDetails(idOrder) {
    $('#showOrderDetails').empty();
    $.get("${pageContext.request.contextPath}/orderDetails/"+idOrder, function (data) {
      $('#showOrderDetails').html(data);
    });
  }
  function show(id) {
    $.get("${pageContext.request.contextPath}/orderUser/" + id , function (data) {
      $("#myContent").html(data);
    });
  }

  function showNews(path) {
    $.get("${pageContext.request.contextPath}" + path, function (data) {
      $("#myContent").html(data);
    });
  }

  function showStatistic(path){
    $.get("${pageContext.request.contextPath}/orders/" + path, function (data) {
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
        <li onclick="show(${user.id})"><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>My Orders</a>
        </li>

        <li onclick="showNews('/news_get')"><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>News</a>
        </li>

        <li onclick=""><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>My Account</a>
        </li>

        <li onclick="showStatistic('/statistic_CountBuyProduct')"><a class="list-group-item" href="#"><i class="icon-home icon-1x"></i>Statistic</a>
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

