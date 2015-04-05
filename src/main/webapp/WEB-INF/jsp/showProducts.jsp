<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 10.03.2015
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/sources/js/jquery-2.1.3.min.js"></script>
<script>

    function buy(id, price) {
        sessionStorage.setItem(id, price);
        document.getElementById("boxSum").innerHTML = sessionStorage.length;

        $.get("${pageContext.request.contextPath}/boxSum/" + id);
    }
</script>

<html>
<head>
    <title>Products</title>
    <style>
        .ratio {
            height: 150px;
        }

        .description {
            width: 120px;
            height: 40px;
            overflow: hidden;
            -ms-text-overflow: ellipsis;
            text-overflow: ellipsis;
        }

        .clip {
            width: 170px;
            white-space: nowrap; /* Запрещаем перенос строк */
            overflow: hidden; /* Обрезаем все, что не помещается в область */
            text-overflow: ellipsis; /* Добавляем многоточие */
            display: block;
        }
    </style>
</head>
<body>
<div class="row" style="margin-right: 0px; margin-left: 0px; ">
        <c:forEach var="product" items="${ProductsByCategory}">
            <div class="col-lg-3 col-md-3" style="border:1px solid lightgray;">
                <div>
                    <img class="thumbnail" src="${pageContext.request.contextPath}/sources/img/${product.code}.jpg"
                         width="304" height="236"
                         alt=""
                         style="margin-bottom: 0px;border-top-width: 0px;border-right-width: 0px;border-bottom-width: 0px;border-left-width: 0px;">

                    <div class="caption">
                        <h4 class="pull-right" style="color: orangered">${product.price}грн</h4>
                        <h4 class="pull-left">${product.category.name}</h4>
                        <h4>
                            <div class="clip"><a href="#${product.id}"
                                                 title="${product.brand.name}&nbsp;${product.name}">${product.brand.name}&nbsp;${product.name}</a>
                            </div>
                        </h4>
                        <h6 style="margin-bottom: 0px; margin-top: 0px; ">
                            <a onclick="buy('${product.id}', '${product.price}')" class="btn btn-primary pull-right"
                               title="Купить" role="button" style="margin-right: -20;"><span
                                    class="glyphicon glyphicon-shopping-cart"></span></a>

                            <div class="description pull-left">
                                <p>${product.description}</p>
                            </div>
                        </h6>
                    </div>
                </div>
            </div>
        </c:forEach>
</div>

</body>
</html>
