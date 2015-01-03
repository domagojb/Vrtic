<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Payment simulator 2015.</title>
  </head>
  <body>
    <p>Simulator mjesece uplate</p>

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
    <c:if test="${error != null}">
      <p>Greska pri upisu: <c:out value="${error}"></c:out></p>
    </c:if>
    <c:choose>
      <c:when  test="${children != null && children.isEmpty() == false}">
        <p>Odaberite dijete sa liste za koje želite izvršiti uplatu</p>
        <form method="post">
	      <c:forEach var="child" items="${children}">
	        <input type="radio" name="child" value="<c:out value="${child.id}" />"><c:out value="${child.firstName}" /> <c:out value="${child.lastName}" /> <c:out value="${child.oib}" />
	        <br>
	      </c:forEach>
		  Godina: <input type="number" name="year">
		  Mjesec: <input type="number" name="month" min="1" max="12">
	      <input type="submit" name="metoda" value="Uplati">
        </form>
      </c:when>
      <c:when test="${children != null && children.isEmpty()}">
        <p>Trenutno nema djece u grupi</p>
      </c:when>
      <c:otherwise>
        <p>Trenutno nije odabrana grupa</p>
      </c:otherwise>
    </c:choose>    
        
    <a href="${pageContext.servletContext.contextPath}">Natrag na homepage</a>
  </body>
</html>