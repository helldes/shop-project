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


    function editProduct() {
        var msg = $('#editForm').serializeObject();
  //      var idProduct = document.getElementById();
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
        $.get("${pageContext.request.contextPath}/admin/product_details/"+id, function (data) {
            document.getElementById("editCountProductModal").value = data[0];
            document.getElementById("editProductAttribute").value = data[1];

        });
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
                <form id="addForm" class="form-horizontal" action="javascript:void(null);"  enctype="multipart/form-data" >
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
                        <div class="form-group">
                            <label class="col-xs-3 control-label">measure</label>

                            <div class="col-xs-5 col-lg-6">
                                <select name="addAttributeProductModal" style="color: gray" class="form-control"
                                        id="addAttributeProductModal">
                                    <c:forEach var="attribute" items="${attributes}">
                                        <option value="${attribute.id}">${attribute.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">Count</label>

                            <div class="col-xs-5  col-lg-6">
                                <input type="number" min="0"  class="form-control" name="addCountProductModal"
                                       id="addCountProductModal"/>
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
                            <label class="col-xs-3 control-label">Measure</label>

                            <div class="col-xs-5 col-lg-6">
                                <input type="text" name="attribute" id="editProductAttribute" class="form-control" disabled="disabled"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-3 control-label">Count</label>

                            <div class="col-xs-5  col-lg-6">
                                <input type="number" min="0"  class="form-control" name="count"
                                       id="editCountProductModal"/>
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
