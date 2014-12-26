<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
    
    <!-- Setting gate to todays date -->
    <script type="text/javascript">
      document.getElementById('datePicker').valueAsDate = new Date();
    </script>
    
  </head>
  <body>
    <c:choose>
      <c:when  test="${children != null && !children.isEmpty()}">
      <form method="post">
        <input type="hidden" name="gid" value="${group.id}">
        <table>
          <tr><td>Datum</td><td><input id="datePicker" type="date" name="date">
		    <c:if test="${form.hasError('date')}">
		      <div class="greska"><c:out value="${form.getError('date')}" /></div>
		    </c:if></td>
		  </tr>
          <tr><td colspan="2">Odaberite prisutnu djecu</td></tr>
          <tr><td colspan="2">
    	 					 	<c:forEach var="child" items="${children}">
	        						<input type="checkbox" name="children" value="${child.id}">
	        						  <c:out value="${child.firstName}" /> <c:out value="${child.lastName}" />; OIB: <c:out value="${child.oib}" />
	        						<br>
	      						</c:forEach>
    	 				
    	 			
    	 	    </td></tr>
		
		    <tr><td></td><td>
		        <input type="submit" name="metoda"	value="Upiši">
		        </td>
		    </tr>
	     </table>
        </form>
      </c:when>
      <c:when test="${group == null}">
        <p>Trenutno nemate pridjeljenu grupu</p>
      </c:when>
      <c:otherwise>
        <p>Trenutno nema djece u grupi</p>
      </c:otherwise>
    </c:choose>    
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>
