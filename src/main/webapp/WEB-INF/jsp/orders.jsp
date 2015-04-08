<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 11.03.2015
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${pageContext.request.contextPath}/sources/js/jquery.maskedinput.min.js"></script>
<script>
    jQuery(function ($) {
        $("#noOrder").mask("999999");
    });

    $(document).ready(function () {
        var now = new Date();
        var month = (now.getMonth() + 1);
        var day = now.getDate();
        if (month < 10)
            month = "0" + month;
        if (day < 10)
            day = "0" + day;
        var today = now.getFullYear() + '-' + month + '-' + day;
        $('#date1').val(today);
        $('#date2').val(today);
    });

    function SaveEditOrder() {
        var idOrder = document.getElementById("idOrderModal").value;
        var address = document.getElementById("AddressModal").value;
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/orders/saveDetail',
            data: {address: address, idOrder: idOrder},
            success: function (data) {
                $('#editOrder').hide();
                show('/orders/orders_get');
            },
            error: function (data) {
                alert(data);
                alert('Error');
            }
        });
    }

    function showOrderDetailsProduct(idOrder) {
        $('#showOrderDetailsEdit').empty();
        $.get("${pageContext.request.contextPath}/orders/product/" + idOrder, function (data) {
            $('#showOrderDetailsEdit').html(data);
        });
    }

    function editAllDetails(id, date, loginUser, phone, status, address, totalPrice) {
        showOrderDetailsProduct(id);
        document.getElementById("idOrderModal").value = id;
        document.getElementById("DateModal").value = date;
        document.getElementById("UserModal").value = loginUser;
        document.getElementById("PhoneModal").value = phone;
        if (status == 0) {
            document.getElementById("StatusModal").value = 'Не отработан';
        }
        if (status == 1) {
            document.getElementById("StatusModal").value = 'Отработан';
        }
        document.getElementById("AddressModal").value = address;
        document.getElementById("TPriceModal").value = totalPrice;

    }

    function ToOrder() {
        var idOrder = document.getElementById('hideIdOrder').value;
        $.get("${pageContext.request.contextPath}/orders/done/" + idOrder, function (data) {
            $('#myContent').html(data);
        });
    }

    function changeSearchOrder() {
        var sel = document.getElementById("sort").value;
        if (sel == 0) {
            $('#noOrder').hide();
            $('#date1').hide();
            $('#date2').hide();
            $('#submitSearch').hide();
        }

        if (sel == 1) {
            $('#noOrder').show();
            document.getElementById('noOrder').value = '';
            $('#date1').hide();
            $('#date2').hide();
            $('#submitSearch').show();
        }
        if (sel == 2) {
            $('#noOrder').hide();
            document.getElementById('noOrder').value = 0;
            $('#date1').show();
            $('#date2').show();
            $('#submitSearch').show();
        }
        if (sel == 3) {
            $('#noOrder').hide();
            document.getElementById('noOrder').value = 0;
            $('#date1').show();
            $('#date2').hide();
            $('#submitSearch').show();
        }
    }

    function SearchOrders() {
        var sel = document.getElementById("sort").value;
        var noOrder = document.getElementById("noOrder").value;
        var date1 = document.getElementById("date1").value;
        var date2 = document.getElementById("date2").value;
        //Validation
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/orders/search',
            data: {sel: sel, idOrder: noOrder, date1: "date1", date2: "date2"},
            success: function (data) {

                show('/orders/orders_get');
            },
            error: function (data) {
                alert(data);
                alert('Error');
            }
        });
    }

    function parseDate(input) {
        var parts = input.split('-');
        // new Date(year, month [, day [, hours[, minutes[, seconds[, ms]]]]])
        return new Date(parts[0], parts[1] - 1, parts[2]); // Note: months are 0-based
    }

    function SearchOrders2() {
        var sel = document.getElementById("sort").value;
        var noOrder = document.getElementById("noOrder").value;
        var date1 = document.getElementById("date1").value;
        var date2 = document.getElementById("date2").value;
        var dateNew1 = parseDate(date1);
        var dateNew2 = parseDate(date2);

        if (sel == 2) {
            if ((dateNew2 - dateNew1) > 0) {
                $.get("${pageContext.request.contextPath}/orders/search", {
                    sel: sel,
                    idOrder: noOrder,
                    date1: date1,
                    date2: date2
                })
                        .done(function (data) {
                            $("#myContent").html(data);
                        });
            } else {
                alert("Даты некоректны!");
            }
        } else {
            $.get("${pageContext.request.contextPath}/orders/search", {
                sel: sel,
                idOrder: noOrder,
                date1: date1,
                date2: date2
            })
                    .done(function (data) {
                        $("#myContent").html(data);
                    });

        }
    }
</script>

<table width="100%">
    <tr>
        <td align="left" width="30%">
            <label class="col-xs-3 control-label"><h4>Orders</h4></label>
        </td>
        <td width="200px">
            <select name="sort" style="color: gray" onchange="changeSearchOrder()"
                    id="sort">
                <option value="0">укажите критерии поиска</option>
                <option value="1">по номеру ордера</option>
                <option value="2">за период дат</option>
                <option value="3">за день</option>
            </select>
        </td>
        <td align="left" width="350px">
            <input type="text" hidden="true" id="noOrder" name="noOrder" data-mask-reverse="true" data-mask="999999">
            <input type="date" hidden="true" id="date1" name="date1">
            <input type="date" hidden="true" id="date2" name="date2">
        </td>
        <td align="left">
            <button id="submitSearch" name="submitSearch" hidden="true" onclick="SearchOrders2()">применить</button>
        </td>
    </tr>
</table>
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
                <a href="" onclick="showOrderDetails(${orderWork.order_id})" class="btn btn-default" data-toggle="modal"
                   data-target="#OrderModal">View</a>
                <a class="btn btn-default" onclick="editAllDetails('${orderWork.order_id}','${orderWork.date}',
                        '${orderWork.user.getLogin()}', '${orderWork.user.getPhone()}','${orderWork.status}','${orderWork.customAddress}','${orderWork.totalPrice}')"
                   data-toggle="modal" data-target="#editOrder">Edit</a>
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
                <a href="" onclick="showOrderDetails(${orderDone.order_id})" class="btn btn-default" data-toggle="modal"
                   data-target="#OrderModal">View</a>
                <a class="btn btn-default" data-toggle="modal" data-target="#editOrder"
                   onclick="editAllDetails('${orderDone.order_id}',
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
                        <button type="submit" class="btn btn-primary">Отгрузить</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                        <input type="hidden" id="hideIdOrder" name="hideIdOrder">
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

                        <div class="col-xs-5 col-xs-offset-8">
                            <a class="btn btn-default" href="javascript:printDiv('editOrder')">Print</a>
                            <button onclick="SaveEditOrder()" class="btn btn-default">Save</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<iframe name="print_frame" width="0" height="0" frameborder="0" src="about:blank"></iframe>
<!-- -->