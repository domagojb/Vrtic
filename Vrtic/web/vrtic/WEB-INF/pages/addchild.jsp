<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
  </head>
  <body>
    <p>Upis djeteta:</p>
    
    <form method="post">
      <table>
       <tr><td colspan="2">Odaberite grupu</td></tr>
       <tr><td colspan="2"><select name="group"> 
    	 					 	<c:forEach var="group" items="${groups}">
	        						<option value="${group.id}">
	        						  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
	        						  <c:out value="${group.low}" />-<c:out value="${group.high}" />
	        						</option>
	      						</c:forEach>
    	 					 </select>
    	 					 <c:if test="${form.hasError('group')}">
		         				<div class="greska"><c:out value="${form.getError('group')}" /></div>
		     				 </c:if></td>
    	 	 </td></tr>
         <tr><td colspan="2">Odaberite roditelja ako postoji</td></tr>
    	 <tr><td colspan="2"><select name="parent">
    	 						<option value="-1">Novi roditelj</option> 
    	 					 	<c:forEach var="parent" items="${parents}">
	        						<option value="${parent.id}"><c:out value="${parent.firstName}" /> <c:out value="${parent.lastName}" />; OIB: <c:out value="${parent.oib}" /></option>
	      						</c:forEach>
    	 					 </select>
    	 					 
    	 	 </td></tr>
    	 <tr><td colspan="2">Upisite podatke roditelja ako ne postoji</td></tr>
		 <tr><td>Ime</td><td> <input type="text" name="firstname" value='<c:out value="${form.pFirstName}" />' size ="40">
		     <c:if test="${form.hasError('firstname')}">
		         <div class="greska"><c:out value="${form.getError('firstname')}" /></div>
		     </c:if></td>
		 </tr>
		     
		 <tr><td>Prezime</td><td> <input type="text" name="lastname" value='<c:out value="${form.pLastName}" />' size ="40">
		     <c:if test="${form.hasError('lastname')}">
		         <div class="greska"><c:out value="${form.getError('lastname')}" /></div>
		     </c:if></td>
		 </tr>
		 
		 <tr><td>OIB</td><td> <input type="text" name="oib" value='<c:out value="${form.pOIB}" />' size ="40">
		     <c:if test="${form.hasError('oib')}">
		         <div class="greska"><c:out value="${form.getError('oib')}" /></div>
		     </c:if></td>
		 </tr>
		     
		 <tr><td>Adresa</td><td> <input type="text" name="address" value='<c:out value="${form.address}" />' size ="40">
		     <c:if test="${form.hasError('address')}">
		         <div class="greska"><c:out value="${form.getError('address')}" /></div>
		     </c:if></td>
		 </tr>    
		
		 <tr><td>Telefon</td><td> <input type="text" name="phone" value='<c:out value="${form.phone}" />' size ="40">
		     <c:if test="${form.hasError('phone')}">
		         <div class="greska"><c:out value="${form.getError('phone')}" /></div>
		     </c:if></td>
		 </tr>
		 
		 <tr><td colspan="2">Ako se potražuje pravo na temelju socijalnog statusa</td></tr>
		 <tr><td colspan="2"><input type="checkbox" name="socialstatus" value="1">Označiti ako se traži</td></tr>
		 <tr><td>Primanja (mjesečna)</td><td> <input type="text" name="income" value='<c:out value="${form.income}" />' size ="40">HRK
		     <c:if test="${form.hasError('income')}">
		         <div class="greska"><c:out value="${form.getError('income')}" /></div>
		     </c:if></td>
		 </tr>
		
		 <tr><td colspan="2">Podaci o djetetu</td></tr>
		 <tr><td>Ime</td><td> <input type="text" name="c_firstname" value='<c:out value="${form.cFirstName}" />' size ="40">
		     <c:if test="${form.hasError('c_firstname')}">
		         <div class="greska"><c:out value="${form.getError('c_firstname')}" /></div>
		     </c:if></td>
		 </tr>
		     
		 <tr><td>Prezime</td><td> <input type="text" name="c_lastname" value='<c:out value="${form.cLastName}" />' size ="40">
		     <c:if test="${form.hasError('c_lastname')}">
		         <div class="greska"><c:out value="${form.getError('c_lastname')}" /></div>
		     </c:if></td>
		 </tr>
		 
		 <tr><td>OIB</td><td> <input type="text" name="c_oib" value='<c:out value="${form.cOIB}" />' size ="40">
		     <c:if test="${form.hasError('c_oib')}">
		         <div class="greska"><c:out value="${form.getError('c_oib')}" /></div>
		     </c:if></td>
		 </tr>
		 
		 <tr><td>Spol</td><td><select name="sex"> 
	        				  <option value="m">M</option>
	        				  <option value="f">F</option>
    	 					 </select>
    	 					 
    	 	 </td></tr>
		 <tr><td>Datum rođenja</td><td><input type="date" name="birthdate">
		     <c:if test="${form.hasError('bday')}">
		         <div class="greska"><c:out value="${form.getError('bday')}" /></div>
		     </c:if></td>
		 </tr>
		
		 <tr><td></td><td>
		     <input type="submit" name="metoda"	value="Upiši">
		     </td>
		 </tr>
	  </table>
    </form>
        
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>