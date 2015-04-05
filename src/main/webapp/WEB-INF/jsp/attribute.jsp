<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 20.03.2015
  Time: 22:29
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

  function newAttribute() {
    var msg = $('#form_attribute').serializeObject();
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/admin/attribute_add',
      contentType: 'application/json',
      data: JSON.stringify(msg),
      success: function (data) {
        show('/admin/attribute_get');
      },
      error: function () {
        alert('Error');
      }
    });
  }
  function editAttribute() {
    var msg = $('#editForm').serializeObject();
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/admin/attribute_edit',
      contentType: 'application/json',
      data: JSON.stringify(msg),
      success: function () {
        show('/admin/attribute_get');
      },
      error: function () {
        alert('Error');
      }
    });
  }
  function deleteAttribute(idAttribute) {
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/admin/attribute_delete',
      data: {idAttribute: idAttribute, _csrf: "${_csrf.token}"},
      success: function () {
        show('/admin/attribute_get');
      },
      error: function () {
        alert('Возникла ошибка ');
      }
    });

  }
  function editRow(id, name, size, description) {
    document.getElementById("idAttributeModal").value = id;
    document.getElementById("nameAttributeModal").value = name;
    document.getElementById("sizeAttributeModal").value = size;
    document.getElementById("descriptionAttributeModal").value = description;
  }

</script>
<div class="page-header">
  <h3 class="" contenteditable="false">Attribute</h3>
</div>
<p class=""></p>


<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Edit Attribute</h4>
      </div>
      <div class="modal-body">
        <!-- The form is placed inside the body of modal -->
        <form id="editForm" class="form-horizontal" action="javascript:void(null);" onsubmit="editAttribute()">
          <div class="form-group">

            <div class="form-group">
              <label class="col-xs-3 control-label">Id</label>

              <div class="col-xs-5">
                <input type="text" class="form-control" name="id" id="idAttributeModal" readonly/>
              </div>
            </div>

            <div class="form-group">
              <label class="col-xs-3 control-label">Name</label>

              <div class="col-xs-5">
                <input type="text" class="form-control" name="name" id="nameAttributeModal"/>
              </div>
            </div>

            <div class="form-group">
              <label class="col-xs-3 control-label">Size</label>

              <div class="col-xs-5">
                <input type="text" class="form-control" name="size" id="sizeAttributeModal"/>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-xs-3 control-label">Description</label>

            <div class="col-xs-5">
              <input type="text" class="form-control" name="description" id="descriptionAttributeModal"/>
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


<form id="form_attribute" action="javascript:void(null);" onsubmit="newAttribute()" class="form-inline">
  <div class="form-group">
    <input name="name" placeholder="Name" class="form-control" id="nameAttribute">
    <input name="size" placeholder="Size" class="form-control" id="sizeAttribute">
    <input name="description" placeholder="Description" class="form-control" id="descriptionAttribute">
  </div>
  <input type="submit" value="Submit" class="btn btn-default">
</form>

<table class="table table-condensed">
  <tr>
    <td>ID</td>
    <td>NAME</td>
    <td>SIZE</td>
    <td>DESCRIPTION</td>
    <td>ACTION</td>
  </tr>
  <c:forEach var="attribute" items="${attributes}">
    <tr>
      <td>${attribute.id}</td>
      <td>${attribute.name}</td>
      <td>${attribute.size}</td>
      <td>${attribute.description}</td>
      <td>
        <a class="btn btn-default" data-toggle="modal" data-target="#editModal"
           onclick="editRow(${attribute.id},'${attribute.name}','${attribute.size}', '${attribute.description}')">Edit</a>
        <button id="${attribute.id}" class="btn btn-default" onclick="deleteAttribute(${attribute.id})">Delete
        </button>
      </td>
    </tr>
  </c:forEach>
</table>

