<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
  </head>
  <body>
    <p>Ispis djeteta:</p>

	<!-- Forma za selektiranje grupe -->
	<form method="get">
	  <p>Odaberite grupu:</p>
	  <select name="group"> 
	 	<c:forEach var="group" items="${groups}">
		  <option value="${group.id}">
		    <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
		    <c:out value="${group.low}" />-<c:out value="${group.high}" />
		  </option>
		</c:forEach>
	 </select>
	 <input type="submit" name="metoda"	value="Odaberi">
	</form>
    
    <!-- Children list from selected group --> 
    <c:choose>
      <c:when  test="${children != null && children.isEmpty() == false}">
        <p>Odaberite dijete sa liste koje želite ispisati.</p>
        <form method="post">
	      <c:forEach var="child" items="${children}">
	        <input type="radio" name="child" value="<c:out value="${child.id}" />"><c:out value="${child.firstName}" /> <c:out value="${child.lastName}" /> <c:out value="${child.oib}" />
	        <br>
	      </c:forEach>

	      <input type="submit" name="metoda" value="Ispiši">
        </form>
      </c:when>
      <c:when test="${children != null && children.isEmpty()}">
        <p>Trenutno nema djece u grupi</p>
      </c:when>
      <c:otherwise>
        <p>Trenutno nije odabrana grupa</p>
      </c:otherwise>
    </c:choose>    
        
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>