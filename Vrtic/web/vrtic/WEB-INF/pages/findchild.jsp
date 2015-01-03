<%@page import="hr.fer.zemris.opp.model.users.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> "Tulipan" - Odgajatelj</title>
  </head>
  <body>
    <!-- Search form -->
    <p>Pretraži bazu:</p>
  	<form>
  	  <table>
  	    <tr>
  	      <td>Ime</td>
  	      <td><input type="text" name="firstName"></td>
  	    </tr>
  	    <tr>
  	      <td>Prezime</td>
  	      <td><input type="text" name="lastName"></td>
  	    </tr>
  	    <tr>
  	      <td>OIB</td>
  	      <td><input type="text" name="oib"></td>
  	    </tr>
  	  </table>
  	  <input type="submit" name="method" value="Pretrazi">
  	</form>
	  
	<!-- By group list -->
	<p>Pronadji po grupi</p>
	<form method="get">
	  <select name="group"> 
	 	<c:forEach var="group" items="${groups}">
		  <option value="${group.id}">
		    <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
		    <c:out value="${group.low}" />-<c:out value="${group.high}" />
		  </option>
		</c:forEach>
	 </select>
	 <input type="submit" name="method"	value="Odaberi">
	</form> 
	
	<c:if test="${children != null}">
	  <p>Rezultati:</p>
	  <c:if test="${children.isEmpty()}">
	    <p>Nema rezultata ili grupa ne sadrži djecu</p>
	  </c:if>
	  <ul>
	  <c:forEach var="child" items="${children}">
	    <li><a>${child.firstName} ${child.lastName} OIB: ${child.oib}</a></li>
	  </c:forEach>
	  </ul>
	</c:if>
	
  	<a href="${pageContext.servletContext.contextPath}/userpanel">Povratak na izbornik</a>
  	
  </body>
</html>