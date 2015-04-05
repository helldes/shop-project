<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/sources/js/bootstrap-modal.js"></script>
<script src="${pageContext.request.contextPath}/sources/js/jquery-2.1.3.min.js"></script>
<script>
    jQuery.fn.serializeObject = function () {
        var formData = {};
        var formArray = this.serializeArray();

        for(var i = 0, n = formArray.length; i < n; ++i)
            formData[formArray[i].name] = formArray[i].value;

        return formData;
    };

    function editProduct() {
        var msg = $('#editForm').serializeObject();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin/product_edit',
            contentType: 'application/json',
            data: JSON.stringify(msg),
            success: function () {
                show('/admin/product_get');
            },
            error: function () {
                alert('Error');
            }
        });
    }

    $("#addForm").submit(function(e)
    {
        var formData = new FormData(this);
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/product_add',
            type: 'POST',
            data:  formData,
            mimeType:"multipart/form-data",
            contentType: false,
            cache: false,
            processData:false,
            success: function(data, textStatus, jqXHR)
            {
                show('/admin/product_get');
            },
            error: function(jqXHR, textStatus, errorThrown)
            {
            }
        });
    });
    function openModalEditAttribute(idProduct){
        alert(idProduct);
        $('#myModalEditAttribute').modal('toggle');
        alert("STOP");
    }

    function addAttribute() {
        var msg = $('#addForm').serialize();
        alert(msg);
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin/product_add',
            data: msg,
            success: function () {
                show('/admin/product_editAttribute');
            },
            error: function () {
                alert('Error');
            }
        });
    }

    function deleteProduct(idProduct) {
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin/product_delete',
            data: {idProduct: idProduct, _csrf: "${_csrf.token}"},
            success: function () {
                show('/admin/product_get');
            },
            error: function () {
                alert('Возникла ошибка ');
            }
        });

    }
    function editRow(id, code, name, category, description, price, brand, disable) {
        document.getElementById("idProductModal").value = id;
        document.getElementById("codeProductModal").value = code;
        document.getElementById("nameProductModal").value = name;
        document.getElementById("categoryProductModal").value = category;
        document.getElementById("descriptionProductModal").value = description;
        document.getElementById("priceProductModal").value = price;
        document.getElementById("brandProductModal").value = brand;
        document.getElementById("disableProductModal").value = disable;
    }
</script>
<style>
    .description {
        width: 250px;
        height: 80px;
        overflow: hidden;
        -ms-text-overflow: ellipsis;
        text-overflow: ellipsis;
    }
</style>
<!--- Modal Add -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Add Product</h4>
            </div>
            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form id="addForm" class="form-horizontal" action="javascript:void(null);"  enctype="multipart/form-data">
                    <div class="form-group">

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Code</label>

                            <div class="col-xs-5 col-lg-6">
                                <input type="text" class="form-control" name="addCodeProductModal"
                                       id="addCodeProductModal"
                                        />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Name</label>

                            <div class="col-xs-5 col-lg-6">
                                <input type="text" class="form-control" name="addNameProductModal"
                                       id="addNameProductModal"
                                        />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Category</label>

                            <div class="col-xs-5 col-lg-6">
                                <select name="addCategoryProductModal" style="color: gray" class="form-control"
                                        id="addCategoryProductModal">
                                    <option value="Select" selected>Select</option>
                                    <c:forEach var="category" items="${categorys}">
                                        <c:if test="${category.parent != null}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Description</label>

                            <div class="col-xs-5  col-lg-6">
                                <input type="text" class="form-control" name="addDescriptionProductModal"
                                       id="addDescriptionProductModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Price</label>

                            <div class="col-xs-5  col-lg-6">
                                <input type="text" class="form-control" name="addPriceProductModal"
                                       id="addPriceProductModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Brand</label>

                            <div class="col-xs-5 col-lg-6">
                                <select name="addBrandProductModal" style="color: gray" class="form-control"
                                        id="addBrandProductModal">
                                    <option value="Select" selected>Select</option>
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.id}">${brand.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">Image</label>

                            <div class="col-xs-5  col-lg-6">
                                <input type="file" class="form-control" name="addFileProductModal"
                                       id="addFileProductModal"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-5 col-xs-offset-9">
                            <button type="submit" class="btn btn-default">Save</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<!--- Modal Edit -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Edit Product</h4>
            </div>
            <div class="modal-body">
                <!-- The form is placed inside the body of modal -->
                <form id="editForm" class="form-horizontal" action="javascript:void(null);">
                    <div class="form-group">

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Id</label>

                            <div class="col-xs-5 col-lg-6">
                                <input type="text" class="form-control" name="id" id="idProductModal"
                                       readonly/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Code</label>

                            <div class="col-xs-5 col-lg-6">
                                <input type="text" class="form-control" name="code" id="codeProductModal"
                                        />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Name</label>

                            <div class="col-xs-5 col-lg-6">
                                <input type="text" class="form-control" name="name" id="nameProductModal"
                                        />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Category</label>

                            <div class="col-xs-5 col-lg-6">
                                <select name="category" style="color: gray" class="form-control"
                                        id="categoryProductModal">
                                    <c:forEach var="category" items="${categorys}">
                                        <c:if test="${category.parent != null}">
                                            <option value="${category.id}"
                                                    selected="${category.id}">${category.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Description</label>

                            <div class="col-xs-5  col-lg-6">
                                <input type="text" class="form-control" name="description"
                                       id="descriptionProductModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Price</label>

                            <div class="col-xs-5  col-lg-6">
                                <input type="text" class="form-control" name="price"
                                       id="priceProductModal"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-3 control-label">Brand</label>

                            <div class="col-xs-5 col-lg-6">
                                <select name="brand" style="color: gray" class="form-control"
                                        id="brandProductModal">
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.id}" selected="${brand.id}">${brand.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-xs-3 control-label">Disable</label>

                            <div class="col-xs-5 col-lg-6">
                                <select name="disable" style="color: gray" class="form-control"
                                        id="disableProductModal">
                                    <option value="true" selected="true">true</option>
                                    <option value="false" selected="false">false</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-5 col-xs-offset-9">
                                <button  class="btn btn-default" onclick="openModalEditAttribute(document.getElementById('idProductModal').value)">edit Attribute</button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-5 col-xs-offset-9">
                            <button type="submit" class="btn btn-default"  onclick="editProduct()">Save</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->


<div class="modal" id="myModal2" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Second Modal title</h4>
            </div><div class="container"></div>
            <div class="modal-body">
                Content for the dialog / modal goes here.
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary">Save changes</a>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModalEditAttribute" tabindex="-1" role="dialog" aria-labelledby="myModalLabel0" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel0">Attribute  Add/Edit</h4>
            </div>
            <form id="formEditAttribute" class="form-horizontal" action="javascript:void(null);" onsubmit="addAttribute()">
            <div class="modal-body">
                <div class="form-group">
                    <label class="col-xs-3 control-label">Select Attribute</label>

                    <div class="col-xs-3  col-lg-3">
                        <select name="attributeProductModal" style="color: gray" class="form-control"
                                id="attributeProductModal">
                            <option value="0" selected>Select</option>
                            <c:forEach var="attribute" items="${attributes}">
                                <option value="${attribute.id}">${attribute.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-xs-3  col-lg-3">
                        <input type="text" class="form-control" name="attributeValueProductModal" value="0"
                               id="attributeValueProductModal"/>
                    </div>
                    <input type="hidden" id="idProduct" name="idProduct">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            </form>
        </div>
    </div>
</div>


<div class="page-header">
    <h3 class="" contenteditable="false">Products</h3>
    <a class="btn btn-default pull-rigth" data-toggle="modal" data-target="#addModal">Add Product</a>
</div>
<p class=""></p>
<table class="table table-condensed">
    <tr>
        <td>ID</td>
        <td>CODE</td>
        <td>NAME</td>
        <td>CATEGORY</td>
        <td>DESCRIPTION</td>
        <td>PRICE</td>
        <td>BRAND</td>
        <td>DISABLE</td>
        <td>ACTION</td>
    </tr>

    <c:forEach var="product" items="${products}">
        <tr>
            <td>${product.id}</td>
            <td>${product.code}</td>
            <td>${product.name}</td>
            <td>${product.getCategory().getName()}</td>
            <td class="description">${product.description}</td>
            <td>${product.price}</td>
            <td>${product.getBrand().getName()}</td>
            <td>${product.disable}</td>
            <td><a class="btn btn-default" data-toggle="modal" data-target="#editModal" data-backdrop="static"
                   onclick="editRow('${product.id}','${product.code}', '${product.name}', '${product.getCategory().getId()}'
                           , '${product.description}', '${product.price}', '${product.getBrand().getId()}','${product.disable}')">Edit</a>

                <button id="${product.id}" onclick="deleteProduct(${product.id})" class="btn btn-default">Delete
                </button>
            </td>
        </tr>
    </c:forEach>


</table>
