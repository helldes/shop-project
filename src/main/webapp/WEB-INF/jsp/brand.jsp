<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 14.03.2015
  Time: 16:07
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/sources/js/jquery-2.1.3.min.js"></script>
<script>
  jQuery.fn.serializeObject = function () {
    var formData = {};
    var formArray = this.serializeArray();

    for(var i = 0, n = formArray.length; i < n; ++i)
      formData[formArray[i].name] = formArray[i].value;

    return formData;
  };

  function newBrand() {
    var msg = $('#form_brand').serializeObject();
    $.ajax({
      url: '${pageContext.request.contextPath}/admin/brand_add',
      type:"POST",
      contentType: 'application/json',
      data: JSON.stringify(msg),
      success: function () {
        show('/admin/brand_get');
      },
      error: function () {
        alert('Error');
      }
    });
  }
  function editBrand() {
    var msg = $('#editForm').serializeObject();
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/admin/brand_edit',
      contentType: 'application/json',
      data: JSON.stringify(msg),
      success: function () {
        show('/admin/brand_get');
      },
      error: function () {
        alert('Error');
      }
    });
  }
  function deleteBrand(idBrand) {
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/admin/brand_delete',
      data: {idBrand: idBrand, _csrf: "${_csrf.token}"},
      success: function () {
        show('/admin/brand_get');
      },
      error: function () {
        alert('Возникла ошибка ');
      }
    });

  }
  function editRow(id, name) {
    document.getElementById("idBrandModal").value = id;
    document.getElementById("nameBrandModal").value = name;
  }

</script>
<div class="page-header">
  <h3 class="" contenteditable="false">Brand</h3>
</div>
<p class=""></p>


<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Edit Brand</h4>
      </div>
      <div class="modal-body">
        <!-- The form is placed inside the body of modal -->
        <form id="editForm" class="form-horizontal" action="javascript:void(null);" onsubmit="editBrand()">
          <div class="form-group">

            <div class="form-group">
              <label class="col-xs-3 control-label">Id</label>

              <div class="col-xs-5">
                <input type="text" class="form-control" name="id" id="idBrandModal" readonly/>
              </div>
            </div>

            <div class="form-group">
              <label class="col-xs-3 control-label">Name</label>

              <div class="col-xs-5">
                <input type="text" class="form-control" name="name" id="nameBrandModal"/>
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


<form id="form_brand" action="javascript:void(null);" onsubmit="newBrand()" class="form-inline">
  <div class="form-group">
    <input name="name" placeholder="Name" class="form-control" id="nameBrand">
  </div>
  <input type="submit" value="Submit" class="btn btn-default">
</form>

<table class="table table-condensed">
  <tr>
    <td>ID</td>
    <td>NAME</td>
    <td>ACTION</td>
  </tr>
  <c:forEach var="brand" items="${brands}">
    <tr>
      <td>${brand.id}</td>
      <td>${brand.name}</td>
      <td>
        <a class="btn btn-default" data-toggle="modal" data-target="#editModal"
           onclick="editRow(${brand.id},'${brand.name}')">Edit</a>
        <button id="${brand.id}" class="btn btn-default" onclick="deleteBrand(${brand.id})">Delete
        </button>
      </td>
    </tr>
  </c:forEach>
</table>

