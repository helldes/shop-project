<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 18.03.2015
  Time: 8:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
    function sumPrice(id, price) {
        var coun = document.getElementById('count'+id).value;
        if (coun > 99){
            alert("So math count!");
            coun=99;
            document.getElementById('count'+id).value = coun;
            document.getElementById('lb' + id).textContent = (coun * price).toFixed(2);
        }else {
            document.getElementById('lb' + id).textContent = (coun * price).toFixed(2);
        }
    }
</script>


<table class="table table-condensed">
    <tr>
        <td>NAME</td>
        <td>CATEGORY</td>
        <td>DESCRIPTION</td>
        <td>PRICE</td>
        <td>BRAND</td>
        <td>COUNT</td>
        <td>ACTION</td>
    </tr>
    <c:forEach var="product" items="${shoppingCart}">
        <tr>
            <td>${product.name}</td>
            <td>${product.getCategory().getName()}</td>
            <td>${product.description}</td>
            <td><label id="lb${product.id}">${product.price}</label></td>
            <td>${product.getBrand().getName()}</td>
            <td><input id="count${product.id}" name="count${product.id}" type="number" style="width: 3em;" value="1" min="1" max="99"
                       onchange="sumPrice('${product.id}',${product.price})"></td>
            <td>
                <button id="${product.id}" onclick="deleteShopCardProduct(${product.id})"
                        class="glyphicon glyphicon-remove"></button>
            </td>
        </tr>
    </c:forEach>
</table>

