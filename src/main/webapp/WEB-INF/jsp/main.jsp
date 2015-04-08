<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 27.02.2015
  Time: 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fnn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="${pageContext.request.contextPath}/sources/js/jquery-2.1.3.min.js"></script>
<script>
    jQuery.fn.serializeObject = function () {
        var formData = {};
        var formArray = this.serializeArray();

        for(var i = 0, n = formArray.length; i < n; ++i)
            formData[formArray[i].name] = formArray[i].value;

        return formData;
    };
    jQuery(function($){
        $("#phoneUserModal").mask("(999)-999-9999");
    });

    function LoginUser(){
        var pass = document.forms["loginForm"]["j_password"].value;
        document.forms["loginForm"]["j_password"].value = CryptoJS.SHA1(pass);
    }

    function phonenumber(phone) {
        var phoneNumberPattern = /^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/;
        return phoneNumberPattern.test(phone);
    }

    function registrationUser() {
        var pass = document.forms["registrationForm"]["passwordUserModal"].value;
        var rpass = document.forms["registrationForm"]["passwordRetryUserModal"].value;
        var login = document.forms["registrationForm"]["loginUserModal"].value;
        var phone = document.forms["registrationForm"]["phoneUserModal"].value;
        if (login == null || login == '') {
            alert("Input Login");
        } else {
            var param = {loginUserModal: login};
            $.ajax({
                type: 'POST',
                url: '/login_check',
                data: param,
                success: function (data) {
                    var loginBoolean = data;
                    if (loginBoolean == 'true') {
                        alert('this Login is already registered')
                    } else {
                        if (pass == null || pass == '') {
                            alert("Input password");
                        } else {
                            if (pass !== rpass) {
                                alert("Passwords do not match");
                            } else {
                                if (phone == null || phone == '') {
                                    alert("Input Phone number");
                                } else {
                                    if (phonenumber(phone)) {
                                        document.forms["registrationForm"]["passwordUserModal"].value = CryptoJS.SHA1(pass);
                                        document.forms["registrationForm"]["passwordRetryUserModal"].value = CryptoJS.SHA1(pass);
                                        var msg = $('#registrationForm').serializeObject();
                                        $.ajax({
                                            type: 'POST',
                                            url: '${pageContext.request.contextPath}/user_registration',
                                            contentType: 'application/json',
                                            data: JSON.stringify(msg),
                                            success: function (data) {
                                                $("#closer").trigger( "click" );
                                            },
                                            error: function () {
                                                alert('Error save User');
                                            }
                                        });
                                    } else {
                                        alert("Phone number format:  (XXX)-XXX-XXXX")
                                    }
                                }
                            }
                        }
                    }
                },
                error: function (data) {
                    alert('Error Get Login');
                }
            });
        }
    }

    function ShowProducts(id_path) {
        $.get("${pageContext.request.contextPath}/categories/" + id_path, function (data) {
            $("#contentProduct").html(data);
        });
    }

    function ShowShopKart() {
        $('#showCart').empty();
        $.get("${pageContext.request.contextPath}/ShopCart_get", function (data) {
            $('#showCart').html(data);
        });
    }
    function deleteShopCardProduct(id) {

        $('#showCart').empty();
        $.get("${pageContext.request.contextPath}/cardDelProduct/" + id, function (data) {
            sessionStorage.removeItem(id);
            document.getElementById("boxSum").innerHTML = sessionStorage.length;
            $('#showCart').html(data);
            if (sessionStorage.length == 0) {
                $('#bsubmit').hide();
                $('#labelbay').hide();
                $('#phoneNumber').hide();
            }

        });
    }
    function ToOrder() {
        var msg = $('#FormCartProduct').serialize();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/getOrder',
            data: msg,
            success: function () {
                alert("Заказ принят в работу");
                $('#CartModal').hide();
                $('body').css('overflow', 'auto');
                sessionStorage.clear();
                document.getElementById("boxSum").innerHTML = sessionStorage.length;
            },
            error: function () {
                alert('Error !!!!!');
            }
        });

    }

    function sessionClear() {
        sessionStorage.clear();
    }

    $(document).ready(function () {
        $("#CartModal").on('show.bs.modal', function () {
            if (sessionStorage.length == 0) {
                $('#bsubmit').hide();
                $('#labelbay').hide();
                $('#phoneNumber').hide();
            } else {
                $('#bsubmit').show();
                $('#labelbay').show();
                $('#phoneNumber').show();
            }
        });
    });

</script>

<html>
<head>


    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/sources/css/shop-item.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sources/css/bootstrap-theme.min.css">
    <script src="${pageContext.request.contextPath}/sources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/sources/js/bootstrap-dropdown.js"></script>
    <script src="${pageContext.request.contextPath}/sources/js/sha1.js"></script>
    <script src="${pageContext.request.contextPath}/sources/js/jquery.maskedinput.min.js"></script>
</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/"><span class="glyphicon glyphicon-home"></span>&nbsp;Home</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse pull-right" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="" onclick="ShowShopKart()" id="shoppingCart" data-toggle="modal" data-target="#CartModal">
                        <span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;Корзина:<label
                            id="boxSum">${fnn:length(shoppingCart)}</label></a>
                </li>
                <li>
                    <a href="/about">About</a>
                </li>
                <li>
                    <c:if test="${pageContext.request.userPrincipal.name != null}">
                        <a href="/login/main">My page</a>
                    </c:if>
                </li>
                <li class="dropdown">
                    <a href="#" id="nbAcctDD" class="dropdown-toggle" data-toggle="dropdown">My Account<span
                            class="caret"></span></a>
                    <ul class="dropdown-menu pull-right">
                        <c:if test="${pageContext.request.userPrincipal.name == null}">
                            <li><a data-toggle="modal" data-target="#RegistrationModal">Registration</a></li>
                        </c:if>
                        <c:if test="${pageContext.request.userPrincipal.name != null}">
                            <li><a href="/login/main">${pageContext.request.userPrincipal.name}</a></li>
                        </c:if>
                        <li class="divider"></li>
                        <c:if test="${pageContext.request.userPrincipal.name == null}">
                            <li><a data-toggle="modal" data-target="#loginModal">Login</a>
                            </li>
                        </c:if>
                        <c:if test="${pageContext.request.userPrincipal.name != null}">
                            <li><a href="<c:url value='/j_spring_security_logout' />" onclick="sessionClear()">Log
                                Out</a></li>
                        </c:if>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->


    <!--- BOXSUM-->


    <!---END  BOXSUM-->


</nav>

<!-- Page Content -->
<div class="container">

    <div class="row">

        <div class="col-md-3">
            <p class="lead">Super Shop "GeekHub"</p>

            <div class="list-group">

                <c:forEach var="categoryUser" items="${categorysForUser}">
                    <c:if test="${categoryUser.getParent() == null}">
                        <ul class="nav nav-stacked"><a href="#" onclick="ShowProducts(${categoryUser.getId()});" style="color:#000080"><h4>${categoryUser.name}</h4></a>

                            <c:forEach var="podCategoryUser" items="${categorysForUser}">
                                <c:if test="${podCategoryUser.getParent().getId() == categoryUser.getId()}">
                                    <li><a style="color:#0000FF" href="#"
                                           onclick="ShowProducts(${podCategoryUser.getId()});"
                                           class="list-group-item">${podCategoryUser.name}</a></li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </c:if>
                </c:forEach>

            </div>
        </div>

        <div class="col-md-9">

            <div class="thumbnail">

                <div id="contentProduct">
                    <c:forEach var="news" items="${listNews}">
                        <div class="page-header">
                            <h3 class="" contenteditable="false">${news.title}</h3>
                        </div>
                        <p class=""></p>
                        <h5>${news.description}</h5>
                    </c:forEach>
                </div>

            </div>

        </div>

    </div>

</div>
<!-- /.container -->

<div class="container">

    <hr>

    <!-- Footer -->
    <footer>
        <div class="row">
            <div class="col-lg-12">
                <p>Copyright &copy; GeekHub 2015</p>
            </div>
        </div>
    </footer>

</div>
<!-- /.container -->
<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Login</h4>
            </div>

            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form id="loginForm" method="post" onsubmit="LoginUser()" class="form-horizontal"
                      action="<c:url value='/j_spring_security_check' />">
                    <div class="form-group">
                        <label class="col-xs-3 control-label">Username</label>

                        <div class="col-xs-5">
                            <input type="text" class="form-control" name="j_username"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-3 control-label">Password</label>

                        <div class="col-xs-5">
                            <input type="password" class="form-control" name="j_password"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-5 col-xs-offset-3">
                            <button type="submit" class="btn btn-default">Login</button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="RegistrationModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Registration User</h4>
            </div>
            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form id="registrationForm" class="form-horizontal" action="javascript:void(null);"
                      onsubmit="registrationUser()">
                    <div class="form-group">

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Login</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="login" id="loginUserModal"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">Password</label>

                            <div class="col-xs-5">
                                <input type="password" class="form-control" name="password"
                                       id="passwordUserModal"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">Password</label>

                            <div class="col-xs-5">
                                <input type="password" class="form-control" name="password"
                                       id="passwordRetryUserModal"/>
                            </div>
                            <h5>
                                <small>(retry password)</small>
                            </h5>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">First Name</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="firstName"
                                       id="firstNameUserModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Last Name</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="lastName"
                                       id="lastNameUserModal"
                                        />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">E-Mail</label>

                            <div class="col-xs-5">
                                <input type="email" class="form-control" name="eMail" id="eMailUserModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Phone</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" data-mask-reverse="true" data-mask="(000)-000-0000" name="phone" id="phoneUserModal"/>
                            </div>
                            <h5>
                                <small>(Format: (XXX)-XXX-XXXX)</small>
                            </h5>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Address</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="address"
                                       id="addressUserModal"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-5 col-xs-offset-9">
                            <button type="submit" class="btn btn-default">Save</button>
                            <button type="button" id="closer" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Modal Show ShopCart -->
<div class="modal fade" id="CartModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel7" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="FormCartProduct" name="FormCartProduct" action="javascript:void(null);" onsubmit="ToOrder()">
                <div class="form-group">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Корзина</h4>
                    </div>

                    <div id="showCart" class="modal-body">

                    </div>


                    <div class="modal-footer">
                        <c:if test="${pageContext.request.userPrincipal.name == null}">
                            <label id="labelbay" name="labelbay">Купить в один клик : </label>
                            <input id="phoneNumber" name="phoneNumber" type="tel"
                                   placeholder="укажите номер мобильного">
                        </c:if>
                        <c:if test="${pageContext.request.userPrincipal.name != null}">
                            <input id="phoneNumber" name="phoneNumber" type="hidden" value="0">
                        </c:if>
                        <button type="submit" id="bsubmit" name="bsubmit" class="btn btn-primary">Купить</button>

                        <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    </form>
</div>

<!--  -->

</body>
</html>
