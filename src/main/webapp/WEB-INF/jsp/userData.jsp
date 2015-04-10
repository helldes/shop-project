<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 06.04.2015
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/sources/js/jquery-2.1.3.min.js"></script>

<script>
    jQuery.fn.serializeObject = function () {
        var formData = {};
        var formArray = this.serializeArray();

        for (var i = 0, n = formArray.length; i < n; ++i)
            formData[formArray[i].name] = formArray[i].value;

        return formData;
    };

    function saveUserData(idUser) {
        var msg = $('#editDataForm').serializeObject();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/user_saveData',
            contentType: 'application/json',
            data: JSON.stringify(msg),
            success: function () {
                showUserData(idUser)
            },
            error: function () {
                alert('Error');
            }
        });

    }

    function saveUserData2(idUser) {
        var msg = $('#editDataForm').serialize();
        alert("SAVE" + idUser);
        alert(msg);
    }

</script>


<img src="${pageContext.request.contextPath}/sources/img/userData.jpg"/>


<form id="editDataForm" class="form-horizontal" action="javascript:void(null);" onsubmit="saveUserData(${userData.id})">
    <div class="form-group">

        <div class="form-group">
            <label class="col-xs-3 control-label">Id</label>

            <div class="col-xs-5">
                <input type="text" class="form-control" name="id" id="idUserModal" value="${userData.id}" readonly/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Login</label>

            <div class="col-xs-5">
                <input type="text" class="form-control" name="login" id="loginUserModal" value="${userData.login}"
                       readonly/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">First Name</label>

            <div class="col-xs-5">
                <input type="text" class="form-control" name="firstName" value="${userData.firstName}"
                       id="firstNameUserModal"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Last Name</label>

            <div class="col-xs-5">
                <input type="text" class="form-control" name="lastName" id="lastNameUserModal"
                       value="${userData.lastName}"
                        />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">E-Mail</label>

            <div class="col-xs-5">
                <input type="text" class="form-control" name="eMail" id="eMailUserModal" value="${userData.lastName}"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Phone</label>

            <div class="col-xs-5">
                <input type="text" class="form-control" name="phone" id="phoneUserModal" value="${userData.phone}"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Address</label>

            <div class="col-xs-5">
                <input type="text" class="form-control" name="address" id="addressUserModal"
                       value="${userData.address}"/>
            </div>
        </div>


    </div>

    <div class="form-group">
        <div class="col-xs-5 col-xs-offset-9">
            <button type="submit" class="btn btn-default">Save</button>
        </div>
    </div>
</form>
