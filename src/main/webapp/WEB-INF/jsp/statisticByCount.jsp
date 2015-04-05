<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 01.04.2015
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table class="table table-condensed">
  <tr>
    <td>NAME</td>
    <td>CATEGORY</td>
    <td>DESCRIPTION</td>
    <td>PRICE</td>
    <td>BRAND</td>
    <td>COUNT</td>
  </tr>
  <c:forEach var="product" items="${mapStaticticByCount}">
    <tr>
      <td>${product.key.name}</td>
      <td>${product.key.getCategory().getName()}</td>
      <td>${product.key.description}</td>
      <td>${product.key.price}</td>
      <td>${product.key.getBrand().getName()}</td>
      <td>${product.value}</td>
    </tr>
  </c:forEach>
</table>

