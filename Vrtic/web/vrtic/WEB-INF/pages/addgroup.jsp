<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic - dodaj grupu</title>
  </head>
  <body>
    <p>Dodaj novu grupu vrtića:</p>
    
    <form id="groupForm" method="post">
    <table>
    	 <tr><td colspan="2">Odaberite objekt kojem želite dodati grupu</td></tr>
    	 <tr><td colspan="2"><select name="workplace"> 
    	 					 	<c:forEach var="workplace" items="${workplaces}">
	        						<option value="${workplace.id}"><c:out value="${workplace.address}" />, <c:out value="${workplace.town}" /></option>
	      						</c:forEach>
    	 					 </select>
    	 					 <c:if test="${form.hasError('workplace')}">
		         				<div class="greska"><c:out value="${form.getError('workplace')}" /></div>
		     				 </c:if></td>
    	 	 </td></tr>
		 <tr><td>Donja granična dob</td><td> <input type="text" name="low" value='<c:out value="${form.low}" />' size ="10">
		     <c:if test="${form.hasError('low')}">
		         <div class="greska"><c:out value="${form.getError('low')}" /></div>
		     </c:if></td>
		 </tr>
		 <tr><td>Gornja granična dob</td><td> <input type="text" name="high" value='<c:out value="${form.high}" />' size ="10">
		     <c:if test="${form.hasError('high')}">
		         <div class="greska"><c:out value="${form.getError('high')}" /></div>
		     </c:if></td>
		 </tr>
		 <tr><td>Kapacitet</td><td> <input type="text" name="capacity" value='<c:out value="${form.capacity}" />' size ="10">
		     <c:if test="${form.hasError('capacity')}">
		         <div class="greska"><c:out value="${form.getError('capacity')}" /></div>
		     </c:if></td>
		 </tr>
		 <tr><td colspan="">Odaberite odgajatelje</td>
			 <td colspan=""><select name="educators" multiple> 
    	 					 	<c:forEach var="educator" items="${educators}">
	        						<option value="${educator.id}"><c:out value="${educator.firstName}"></c:out> <c:out value="${educator.lastName}"></c:out></option>
	      						</c:forEach>
    	 					 </select>
    	 					 <c:if test="${form.hasError('educators')}">
		         				<div class="greska"><c:out value="${form.getError('educators')}" /></div>
		     				 </c:if>
    	 	 </td></tr>
	</table>
	 	 <p>
	 	   <input type="submit" name="metoda" value="Spremi">
	 	 </p>
    </form>
        
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>