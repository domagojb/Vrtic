<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
  </head>
  <body>
    <p>Dodaj novog korisnika:</p>
    
    <c:choose>
      <c:when  test="${users != null}">
      <p>Odaberite korisnike sa liste koje želite obrisati.</p>
      <form method="post">
	      <c:forEach var="user" items="${users}">
	        <input type="radio" name="users" value="<c:out value="${user.nick}" />"><c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /> <c:out value="${user.nick}" />
	        <br>
	      </c:forEach>

	      <input type="submit" name="metoda" value="remove">
        </form>
      </c:when>
      <c:otherwise>
        <p>Trenutno nema korisnika</p>
      </c:otherwise>
    </c:choose>    
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>
