<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> "Tulipan" - Odgajatelj</title>
  </head>
  <body>
  	<ul>
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/childrecord?id=${sessionScope['current.user.id']}">Provedi evidenciju</a></li>
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/educatoractivity?id=${sessionScope['current.user.id']}">Upis u dnevnik rada</a></li>
  	</ul>
  	<a href="${pageContext.servletContext.contextPath}/">Vrati se na naslovnicu</a>
  	
  </body>
</html>