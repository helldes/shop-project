
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

  function sumPriceOrder(id, price, idOrder) {
    var coun = document.getElementById('count'+id).value;
    //  var newTotalPrice = coun*price;
    if (coun > 99){
      alert("So math count!");
      coun=99;
      document.getElementById('count'+id).value = coun;
      //document.getElementById('lb' + id).textContent = (coun * price).toFixed(2);
    }else {
      $.ajax({
        type: 'POST',
        url: '${pageContext.request.contextPath}/orders/changeQuantity',
        data: {idProduct:id, idOrder:idOrder, countQuantity:coun},
        success: function () {
        },
        error: function (data) {
          alert(data);
          alert('Error');
        }
      });
      //  document.getElementById("TPriceModal").value = "";
      //  document.getElementById("TPriceModal").value = newTotalPrice;
      //  document.getElementById('lb' + id).textContent = (coun * price).toFixed(2);
    }
  }

  function printDiv(divId) {
    window.frames["print_frame"].document.body.innerHTML= document.getElementById(divId).innerHTML;
    window.frames["print_frame"].window.focus();
    window.frames["print_frame"].window.print();
  }

  function deleteProductFromOrder(idProduct) {
    var idOrders = document.getElementById("idOrderModal").value;
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/orders/deleteDetail',
      data: {idProduct:idProduct, idOrder:idOrders},
      success: function (data) {
        alert(data);
        showOrderDetailsProduct(idOrders);
      },
      error: function (data) {
        alert(data);
        alert('Error');
      }
    });
  }

</script>


<table class="table table-condensed">
  <tr>
    <td>NAME</td>
    <td>CATEGORY</td>
    <td>DESCRIPTION</td>
    <td>PRICE</td>
    <td>BRAND</td>
    <td>COUNT</td>
    <td>DELETE</td>
  </tr>
  <c:forEach var="productInOrder" items="${listOrderDetails2}">
    <tr>
      <td>${productInOrder.getProduct().getName()}</td>
      <td>${productInOrder.getProduct().getCategory().getName()}</td>
      <td>${productInOrder.getProduct().getDescription()}</td>
      <td>${productInOrder.getProduct().getPrice()}</td>
      <td>${productInOrder.getProduct().getBrand().getName()}</td>
      <td><input id="count${productInOrder.getProduct().getId()}" name="count${productInOrder.getProduct().getId()}}" type="number" style="width: 3em;" value="${productInOrder.getQuantity()}" min="1" max="99"
                 onchange="sumPriceOrder('${productInOrder.getProduct().getId()}',${productInOrder.getProduct().getPrice()},'${IdOrder}')">
      </td>
      <td>
        <button id="${productInOrder.getProduct().getId()}" onclick="deleteProductFromOrder(${productInOrder.getProduct().getId()})"
                class="glyphicon glyphicon-remove"></button>
      </td>
    </tr>
  </c:forEach>
</table>


