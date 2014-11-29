<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
  </head>
  <body>
    <p>Dodaj novog korisnika:</p>
    
    <form method="post">
    <table>
		 <tr><td>Ime</td><td> <input type="text" name="firstname" value='<c:out value="${form.firstName}" />' size ="40">
		     <c:if test="${form.hasError('firstname')}">
		         <div class="greska"><c:out value="${form.getError('firstname')}" /></div>
		     </c:if></td>
		 </tr>
		     
		 <tr><td>Prezime</td><td> <input type="text" name="lastname" value='<c:out value="${form.lastName}" />' size ="40">
		     <c:if test="${form.hasError('lastname')}">
		         <div class="greska"><c:out value="${form.getError('lastname')}" /></div>
		     </c:if></td>
		 </tr>
		 
		 <tr><td>Korisničko ime</td><td> <input type="text" name="nick" value='<c:out value="${form.nick}" />' size ="40">
		     <c:if test="${form.hasError('nick')}">
		         <div class="greska"><c:out value="${form.getError('nick')}" /></div>
		     </c:if></td>
		 </tr>
		     
		 <tr><td>Lozinka</td><td> <input type="password" name="password" value='' size ="40">
		     <c:if test="${form.hasError('password')}">
		         <div class="greska"><c:out value="${form.getError('password')}" /></div>
		     </c:if></td>
		 </tr>
		 <tr><td>Tip računa</td><td><input type="radio" name="userType" value="edu" checked>Odgajatelj<br>
									<input type="radio" name="userType" value="acc">Računovođa</td>
		 </tr>
		
		 <tr><td></td><td>
		     <input type="submit" name="metoda"	value="Register">
		     </td>
		 </tr>
	</table>
    </form>
        
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>