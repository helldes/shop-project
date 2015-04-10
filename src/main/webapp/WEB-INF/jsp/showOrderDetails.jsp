<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 25.03.2015
  Time: 12:41
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
    <c:forEach var="detal" items="${listOrderDetails}">
        <tr>
            <td>${detal.getProduct().getName()}</td>
            <td>${detal.getProduct().getCategory().getName()}</td>
            <td>${detal.getProduct().getDescription()}</td>
            <td>${detal.getProduct().getPrice()}</td>
            <td>${detal.getProduct().getBrand().getName()}</td>
            <td>${detal.getQuantity()}</td>
        </tr>
    </c:forEach>
</table>
