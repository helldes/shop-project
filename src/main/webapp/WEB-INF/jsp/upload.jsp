<%--
  Created by IntelliJ IDEA.
  User: helldes
  Date: 03.04.2015
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<form method="POST" enctype="multipart/form-data" action="/upload">
  File to upload: <input type="file" name="file">
  <br /> Name:
  <input  type="text" name="name"><br /> <br />
  <input type="submit" value="Upload"> Press here to upload the file!
</form>
</body>
</html>
