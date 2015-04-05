<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    jQuery.fn.serializeObject = function () {
        var formData = {};
        var formArray = this.serializeArray();

        for(var i = 0, n = formArray.length; i < n; ++i)
            formData[formArray[i].name] = formArray[i].value;

        return formData;
    };

    function editUser() {
        var msg = $('#editForm').serializeObject();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin/user_edit',
            contentType: 'application/json',
            data: JSON.stringify(msg),
            success: function () {
                show('/admin/user_get');
            },
            error: function () {
                alert('Error');
            }
        });
    }
    function disableUser(idUser) {
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin/user_disable',
            data: {idUser: idUser, _csrf: "${_csrf.token}"},
            success: function () {
                show('/admin/user_get');
            },
            error: function () {
                alert('Возникла ошибка ');
            }
        });

    }
    function editRow(id, login, role, firstName, lastNAme, phone, address, mail) {
        document.getElementById("idUserModal").value = id;
        document.getElementById("loginUserModal").value = login;
        document.getElementById("firstNameUserModal").value = firstName;
        document.getElementById("lastNameUserModal").value = lastNAme;
        document.getElementById("eMailUserModal").value = mail;
        document.getElementById("phoneUserModal").value = phone;
        document.getElementById("addressUserModal").value = address;
        document.getElementById("roleUserModal").value = role;
    }
</script>


<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Edit User</h4>
            </div>
            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form id="editForm" class="form-horizontal" action="javascript:void(null);" onsubmit="editUser()">
                    <div class="form-group">

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Id</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="id" id="idUserModal" readonly/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Login</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="login" id="loginUserModal"
                                       readonly/>
                            </div>
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
                                <input type="text" class="form-control" name="lastName" id="lastNameUserModal"
                                        />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">E-Mail</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="eMail" id="eMailUserModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Phone</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="phone" id="phoneUserModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Address</label>

                            <div class="col-xs-5">
                                <input type="text" class="form-control" name="address" id="addressUserModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Role</label>

                            <div class="col-xs-5">
                                <select name="role" style="color: gray" class="form-control" id="roleUserModal">
                                    <option value="1" selected="1">ADMIN</option>
                                    <option value="2" selected="2">MANAGER</option>
                                    <option value="3" selected="3">USER</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-5 col-xs-offset-9">
                            <button type="submit" class="btn btn-default">Save</button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                </form>
            </div>
        </div>
    </div>
</div>


<div class="page-header">
    <h3 class="" contenteditable="false">Users</h3>
</div>
<p class=""></p>
<table class="table table-condensed">
    <tr>
        <td>ID</td>
        <td>LOGIN</td>
        <td>E-MAIL</td>
        <td>FIRST NAME</td>
        <td>LAST NAME</td>
        <td>PHONE</td>
        <td>ADDRESS</td>
        <td>DISABLE</td>
        <td>ROLE</td>
        <td>ACTION</td>
    </tr>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.id}</td>
            <td>${user.login}</td>
            <td>${user.eMail}</td>
            <td>${user.firstName}</td>
            <td>${user.lastName}</td>
            <td>${user.phone}</td>
            <td>${user.address}</td>
            <td>${user.disable}</td>
            <td>${user.getRole().getName()}</td>
            <td><a class="btn btn-default" data-toggle="modal" data-target="#editModal"
                   onclick="editRow('${user.id}','${user.login}','${user.getRole().getId()}','${user.firstName}'
                           ,'${user.lastName}', '${user.phone}', '${user.address}', '${user.eMail}')">Edit</a>

                <button id="${user.id}" onclick="disableUser(${user.id})" class="btn btn-default">Disable</button>
            </td>
        </tr>
    </c:forEach>
</table>
