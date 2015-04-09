<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 01.03.2015
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

  function newCategory() {
    var msg = $('#form_category').serialize();
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/admin/category_add',
      data: msg,
      success: function () {
        show('/admin/category_get');
      },
      error: function () {
        alert('Error');
      }
    });
  }

  function editCategory() {
    var msg = $('#editForm').serializeObject();
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/admin/category_edit',
      contentType: 'application/json',
      data: JSON.stringify(msg),
      success: function () {
        show('/admin/category_get');
      },
      error: function () {
        alert('Error');
      }
    });
  }
  function deleteCategory(idCategory) {
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/admin/category_delete',
      data: {idCategory: idCategory, _csrf: "${_csrf.token}"},
      success: function () {
        show('/admin/category_get');
      },
      error: function () {
        alert('Возникла ошибка ');
      }
    });

  }
  function editRow(id, name, parent) {
    document.getElementById("idCategoryModal").value = id;
    document.getElementById("nameCategoryModal").value = name;
    document.getElementById("parentCategoryModal").value = parent;
  }

</script>
<div class="page-header">
  <h3 class="" contenteditable="false">Category</h3>
</div>
<p class=""></p>


<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Edit Category</h4>
      </div>
      <div class="modal-body">
        <!-- The form is placed inside the body of modal -->
        <form id="editForm" class="form-horizontal" action="javascript:void(null);" onsubmit="editCategory()">
          <div class="form-group">

            <div class="form-group">
              <label class="col-xs-3 control-label">Id</label>

              <div class="col-xs-5">
                <input type="text" class="form-control" name="id" id="idCategoryModal" readonly/>
              </div>
            </div>

            <div class="form-group">
              <label class="col-xs-3 control-label">Name</label>

              <div class="col-xs-5">
                <input type="text" class="form-control" name="name" id="nameCategoryModal"/>
              </div>
            </div>

            <div class="form-group">
              <label class="col-xs-3 control-label">Parent</label>

              <div class="col-xs-5">
                <select name="parent" style="color: gray" class="form-control"
                        id="parentCategoryModal">
                  <option style="color: gray" value="0" selected="0">Select Group</option>
                  <c:forEach var="category" items="${categorys}">
                    <c:if test="${category.getParent() == null}">
                      <option value=${category.id}>${category.name} </option>
                    </c:if>
                  </c:forEach>
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


<form id="form_category" action="javascript:void(null);" onsubmit="newCategory()" class="form-inline">
  <div class="form-group">
    <input name="name" placeholder="Name" class="form-control" id="nameCategory">
    <select name="parent" style="color: gray" class="form-control" id="parentCategory">
      <option style="color: gray" value="0" selected="0">Select Group</option>
      <c:forEach var="category" items="${categorys}">
        <c:if test="${category.getParent() == null}">
          <option value=${category.id}>${category.name} </option>
        </c:if>
      </c:forEach>
    </select>
  </div>
  <input type="submit" value="Submit" class="btn btn-default">
  <input type="hidden"
         name="${_csrf.parameterName}"
         value="${_csrf.token}"/>
</form>

<table class="table table-condensed">
  <tr>
    <td>ID</td>
    <td>NAME</td>
    <td>PARENT</td>
    <td>ACTION</td>
  </tr>
  <c:forEach var="category" items="${categorys}">
    <tr>
      <td>${category.id}</td>
      <td>${category.name}</td>
      <td>${category.getParent().getId()}</td>
      <td>
        <a class="btn btn-default" data-toggle="modal" data-target="#editModal"
           onclick="editRow(${category.id},'${category.name}',${category.getParent().getId()})">Edit</a>
        <button id="${category.id}" class="btn btn-default" onclick="deleteCategory(${category.id})">Delete
        </button>
      </td>
    </tr>
  </c:forEach>
</table>

