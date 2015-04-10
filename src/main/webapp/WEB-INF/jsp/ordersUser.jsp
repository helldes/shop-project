<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 05.04.2015
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

    function showOrderDetailsProduct(idOrder) {
        $('#showOrderDetailsEdit').empty();
        $.get("${pageContext.request.contextPath}/orderDetails/" + idOrder, function (data) {
            $('#showOrderDetailsEdit').html(data);
        });
    }

</script>

<div class="page-header">
    <h3 class="" contenteditable="false">Orders</h3>
</div>
<p class=""></p>

<table class="table table-condensed">
    <tr>
        <td>ID</td>
        <td>DATE</td>
        <td>STATUS</td>
        <td>ADDRESS</td>
        <td>TOTAL PRICE</td>
        <td>ACTION</td>
    </tr>

    <c:forEach var="orderWork" items="${orders}">
        <tr>
            <td>${orderWork.order_id}</td>
            <td>${orderWork.date}</td>
            <td>${orderWork.status}</td>
            <td>${orderWork.customAddress}</td>
            <td>${orderWork.totalPrice}</td>
            <td>
                <a href="" onclick="showOrderDetails(${orderWork.order_id})" class="btn btn-default" data-toggle="modal"
                   data-target="#OrderModal">View</a>
            </td>
        </tr>
    </c:forEach>

</table>

<div class="modal fade" id="OrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel8" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="FormCartProduct" name="FormCartProduct" action="javascript:void(null);">
                <div class="form-group">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Детализация заказа</h4>
                    </div>

                    <div id="showOrderDetails" class="modal-body">

                    </div>


                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    </form>
</div>
