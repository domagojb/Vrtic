<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti - ADMIN PANEL</title>
  </head>
  <body>
  	<ul>
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/adduser">Dodaj novog korisnika</a></li>
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/removeuser">Obrisi korisnika</a></li>
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/edituser">Izmjeni korisnika</a></li>
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/addworkplace">Dodaj objekt</a></li>
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/addgroup">Dodaj grupu</a></li>  	
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/addchild">Upiši dijete</a></li>  
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/removechild">Ispiši dijete</a></li> 	
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/opensignup">Otvori prijave</a></li> 	
  	  <li><a href="${pageContext.servletContext.contextPath}/userpanel/closesignup">Zatvori prijave</a></li> 	
  	  <br>  
  	  <a href="${pageContext.servletContext.contextPath}/">Vrati se na naslovnicu</a>
  	</ul>
  </body>
</html>