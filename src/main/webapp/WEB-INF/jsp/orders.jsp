<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 11.03.2015
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    function SaveEditOrder(){
        var id_order = document.getElementById("idOrderModal").value;
        alert("Сохранение изменений ордера № " + id_order);
    }

    function showOrderDetailsProduct(idOrder) {
        $('#showOrderDetailsEdit').empty();
        $.get("${pageContext.request.contextPath}/orders/product/"+idOrder, function (data) {
            $('#showOrderDetailsEdit').html(data);
        });
    }

    function editAllDetails(id, date, loginUser, phone, status, address, totalPrice){
        showOrderDetailsProduct(id);
        document.getElementById("idOrderModal").value = id;
        document.getElementById("DateModal").value = date;
        document.getElementById("UserModal").value = loginUser;
        document.getElementById("PhoneModal").value = phone;
        if (status == 0) {document.getElementById("StatusModal").value = 'Не отработан';}
        if (status == 1) {document.getElementById("StatusModal").value = 'Отработан';}
        document.getElementById("AddressModal").value = address;
        document.getElementById("TPriceModal").value = totalPrice;

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
        <td>USER</td>
        <td>PHONE</td>
        <td>STATUS</td>
        <td>ADDRESS</td>
        <td>TOTAL PRICE</td>
        <td>ACTION</td>
    </tr>

    <c:forEach var="orderWork" items="${ordersInWork}">
        <tr>
            <td>${orderWork.order_id}</td>
            <td>${orderWork.date}</td>
            <td>${orderWork.user.getLogin()}</td>
            <td>${orderWork.user.getPhone()}</td>
            <td>${orderWork.status}</td>
            <td>${orderWork.customAddress}</td>
            <td>${orderWork.totalPrice}</td>
            <td>
                <a href="" onclick="showOrderDetails(${orderWork.order_id})" class="btn btn-default" data-toggle="modal" data-target="#OrderModal">View</a>
                <a class="btn btn-default" onclick="editAllDetails('${orderWork.order_id}','${orderWork.date}',
                        '${orderWork.user.getLogin()}', '${orderWork.user.getPhone()}','${orderWork.status}','${orderWork.customAddress}','${orderWork.totalPrice}')"
                   data-toggle="modal" data-target="#editOrder" >Edit</a>
            </td>
        </tr>
    </c:forEach>

    <c:forEach var="orderDone" items="${ordersDone}">
        <tr>
            <td>${orderDone.order_id}</td>
            <td>${orderDone.date}</td>
            <td>${orderDone.user.getLogin()}</td>
            <td>${orderDone.user.getPhone()}</td>
            <td>${orderDone.status}</td>
            <td>${orderDone.customAddress}</td>
            <td>${orderDone.totalPrice}</td>
            <td>
                <a href="" onclick="showOrderDetails(${orderDone.order_id})" class="btn btn-default" data-toggle="modal" data-target="#OrderModal">View</a>
                <a class="btn btn-default" data-toggle="modal" data-target="#editOrder" onclick="editAllDetails('${orderDone.order_id}',
                        '${orderDone.date}','${orderDone.user.getLogin()}', '${orderWork.user.getPhone()}','${orderDone.status}','${orderDone.customAddress}',
                        '${orderDone.totalPrice}')">Edit</a>
            </td>
        </tr>
    </c:forEach>
</table>

<div class="modal fade" id="OrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel8" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="FormCartProduct" name="FormCartProduct" action="javascript:void(null);" onsubmit="ToOrder()">
                <div class="form-group">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Детализация заказа</h4>
                    </div>

                    <div id="showOrderDetails" class="modal-body">

                    </div>


                    <div class="modal-footer">
                        <label>Address</label>
                        <input id="customAddess" name="customAddess" type="text"
                               placeholder="укажите адрес доставки">
                        <button type="submit" class="btn btn-primary">Отгрузить</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    </form>
</div>

<!-- Modal Edit Order -->
<div class="modal fade" id="editOrder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel11" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Edit Order</h4>
            </div>
            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form id="editForm" class="form-horizontal" action="javascript:void(null);">
                    <div class="form-group">

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Id</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="idOrderModal" id="idOrderModal" readonly/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Date</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="DateModal" id="DateModal"
                                       readonly/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Login</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="UserModal" id="UserModal"
                                       readonly/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Phone</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="PhoneModal" id="PhoneModal"
                                       readonly/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Status</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="StatusModal"
                                       id="StatusModal" readonly/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Address</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="AddressModal" id="AddressModal"
                                        />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Total Price</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="TPriceModal" id="TPriceModal" readonly/>
                            </div>
                        </div>

                        <div id="showOrderDetailsEdit" class="modal-body">

                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-5 col-xs-offset-9">
                            <button onclick="SaveEditOrder()" class="btn btn-default">Save</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!--  -->