<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>"Tulipan"</title>
  </head>
  <body>
  	<h2>Otvaranje upisa:</h2>
  
    <c:choose>
      <c:when test="${msg != null}">
        <p>${msg}</p>
      </c:when>
      <c:otherwise>
	    <p>Sljedeće grupe imaju mjesta i bit će otvorene za upis:</p>
	    <ul>
	      <c:forEach var="group" items="${openGroups}">
			<li>
			  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
			  <c:out value="${group.low}" />-<c:out value="${group.high}" />
			</li>
		  </c:forEach>
	    </ul>
	
	    <p>Sljedeće grupe su trenutno pune i neće biti razmatrane prilikom upisa</p>
	    <ul>
	      <c:forEach var="group" items="${closedGroups}">
			<li>
			  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
			  <c:out value="${group.low}" />-<c:out value="${group.high}" />
			</li>
		  </c:forEach>
	    </ul>   
	        
	    <p>Želite li nastaviti?</p>
	    <form>
	      <input type="submit" name="method" value="Otvori upis">
	    </form>
	  </c:otherwise>	    
    </c:choose>
    
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>