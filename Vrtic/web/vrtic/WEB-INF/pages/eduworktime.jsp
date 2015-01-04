<%@page import="hr.fer.zemris.opp.model.users.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> "Tulipan" </title>
  </head>
  <body>
   	
   	<form>
   	  Mjesec <input name="month" type="number" min="1" max="12">
   	  Godina <input name="year" type="number" min="0">
   	  Odgajatelj <select name="educator">
   	               <c:forEach var="educator" items="${educators}">
   	                 <option value="${educator.id}">${educator.firstName} ${educator.lastName}; ${educator.nick}</option>
   	               </c:forEach>
   	             </select>
   	  <input type="submit" value="Odaberi">
   	</form>
   	
   	<c:if test="${educator == null}">
   	  <p>Trenutno nije odabran ni jedan odgajatelj</p>
   	</c:if>
   	
    <c:if test="${educator != null}">
   	  <p>Prikaz za mjesec ${month} i godinu ${year}</p>
   	  <p>${educator.firstName} ${educator.lastName}; ${educator.nick}</p>
   	  <p>${educator.group.workplace.address}, <c:out value="${educator.group.workplace.town}" /> <c:out value="${educator.group.low}" />-<c:out value="${educator.group.high}" /></p>
   	  
  	    
  	    <h4>Efektivni rad u grupi</h4>
  	    <p>Utrošeno vrijeme: ${eW} minuta.
  	    <p>Zadovoljava kriterij: ${eW_b}</p>
  	    
  	    <h4>Priprema za rad</h4>
  	    <p>Utrošeno vrijeme: ${wP} minuta.
  	    <p>Zadovoljava kriterij: ${wP_b}</p>
  	    
  	    
  	    <h4>Stručno usavršavanje</h4>
  	    <p>Utrošeno vrijeme: ${s} minuta.
  	    <p>Zadovoljava kriterij: ${s_b}</p>
  	    
  	    
  	    <h4>Suradnja s roditeljima</h4>
  	    <p>Utrošeno vrijeme: ${pW} minuta.
  	    <p>Zadovoljava kriterij: ${pW_b}</p>  	    

   	</c:if>
    
   	
  	<a href="${pageContext.servletContext.contextPath}/userpanel">Povratak na izbornik</a>
  	
  </body>
</html>