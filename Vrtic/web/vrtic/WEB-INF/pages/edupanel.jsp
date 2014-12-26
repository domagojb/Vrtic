<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> "Tulipan" - Odgajatelj</title>
  </head>
  <body>
  	<ul>
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/childrecord?id=${sessionScope['current.user.id']}">Provedi evidenciju</a></li>
  	  <br>  
  	  <a href="${pageContext.servletContext.contextPath}/">Vrati se na naslovnicu</a>
  	</ul>
  </body>
</html>