<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 08.04.2015
  Time: 18:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
  jQuery.fn.serializeObject = function () {
    var formData = {};
    var formArray = this.serializeArray();

    for(var i = 0, n = formArray.length; i < n; ++i)
      formData[formArray[i].name] = formArray[i].value;

    return formData;
  };

  function deleteNews(idNews){
    $.get("${pageContext.request.contextPath}/orders/news_delete/"+idNews, function (data) {
      showNews('/news_get');
    });
  }

  function addNews() {
    var msg = $('#FormAddNews').serializeObject();
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/orders/news_add',
      contentType: 'application/json',
      data: JSON.stringify(msg),
      success: function () {
        showNews('/news_get');
      },
      error: function () {
        alert('Error');
      }
    });
  }

</script>
<div class="page-header">
  <h3 class="" contenteditable="false">News</h3>
</div>
<p class=""></p>
<form id="FormAddNews" action="javascript:void(null);" onsubmit="addNews()">
<div>
  <label>Title</label><input type="text" id="title" name="title"/>
  <label>Description</label><input type="text" id="description" name="description"/>
  <input type="submit" value="Add"/>
</div>
</form>

<table class="table table-condensed">
<tr>
  <td>ID</td>
  <td>TITLE</td>
  <td>DESCRIPTION</td>
  <td>ACTION</td>
</tr>
<c:forEach var="news" items="${listNews}">

  <tr>
    <td>${news.id}</td>
    <td>${news.title}</td>
    <td>${news.description}</td>
    <td><button onclick="deleteNews(${news.id})">Удалить</button></td>
  </tr>
</c:forEach>
</table>


