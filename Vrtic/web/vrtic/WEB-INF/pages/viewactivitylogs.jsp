<%@page import="hr.fer.zemris.opp.model.users.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> "Tulipan" - Odgajatelj</title>
  </head>
  <body>
  	
  	  <!-- Selection form -->
  	  <c:choose>
  	    <c:when test="${educators.isEmpty() == false }">
	  	  <form>
	  	    <!-- Educator list -->
	  	    <select name="user" onchange="this.form.submit()">
	  	      <c:forEach var="user" items="${educators}">
	  	        <option value="${user.id}" <c:if test="${selected_user.id == user.id }"> selected</c:if>
	  	       ><c:out value="${user.firstName}" /> <c:out value="${user.lastName}" />; <c:out value="${user.nick}" />
	  	        </option>
	  	      </c:forEach>
	  	    </select>
	  	    <!-- End Educator list -->
	  	  </form>
	  	    <!-- Log list -->
	  	    <c:choose>
	  	      <c:when test="${logs != null && logs.isEmpty() == false }">
	  	        <form>
	  	          <select name="log">
	  	      	    <c:forEach var="log" items="${logs}">
	  	              <option value="${log.id}"><c:out value="${log.date}" /></option>
	  	            </c:forEach>
	  	          </select>
	  	          <input type="submit" value="Odaberi">
	  	 	    </form>
	  	      </c:when>
	  	      <c:when test="${logs == null}">
	  	        <p>Trenutno nije odabran korisnik.</p>
	  	      </c:when>
	  	      <c:otherwise>
	  	        <p>Trenutno nema zapisa za odabranog korisnika</p>
	  	      </c:otherwise>
	  	    </c:choose>
	  	    <!-- End Log list -->
	  	    
	  	    
  	    </c:when>
  	    <c:otherwise>
  	      <p>Trenutno nema korisnika</p>
  	    </c:otherwise>
  	  </c:choose>
  	  
  	  <!-- Log print -->
  	  <c:if test="${log != null}">
  	  
  	    <h2>Ispis dnevnika</h1>
  	    <p>${log.educator.firstName} ${log.educator.lastName}</p>
  	    <p>${log.date}</p>
  	    
  	    <h4>Efektivni rad u grupi</h4>
  	    <p>Utrošeno vrijeme: ${log.workHour_eW} minuta.
  	    <p>Zapis u dnevnik</p>
  	    <p>
  	      <c:if test="${log.effectiveWork == null || log.effectiveWork.isEmpty()}">
  	        Nema zapisa.
  	      </c:if>
  	      <c:out value="${log.effectiveWork}"></c:out>
  	    </p>
  	    
  	    <h4>Priprema za rad</h4>
  	    <p>Utrošeno vrijeme: ${log.workHour_wP} minuta.
  	    <p>Zapis u dnevnik</p>
  	    <p>
  	      <c:if test="${log.workPreparation == null || log.workPreparation.isEmpty()}">
  	        Nema zapisa.
  	      </c:if>
  	      <c:out value="${log.workPreparation}"></c:out>
  	    </p>
  	    
  	    <h4>Stručno usavršavanje</h4>
  	    <p>Utrošeno vrijeme: ${log.workHour_s} minuta.
  	    <p>Zapis u dnevnik</p>
  	    <p>
  	      <c:if test="${log.specialization == null || log.specialization.isEmpty()}">
  	        Nema zapisa.
  	      </c:if>
  	      <c:out value="${log.specialization}"></c:out>
  	    </p>
  	    
  	    <h4>Suradnja s roditeljima</h4>
  	    <p>Utrošeno vrijeme: ${log.workHour_pW} minuta.
  	    <p>Zapis u dnevnik</p>
  	    <p>
  	      <c:if test="${log.parentWork == null || log.parentWork.isEmpty()}">
  	        Nema zapisa.
  	      </c:if>
  	      <c:out value="${log.parentWork}"></c:out>
  	    </p> 	
  	        
  	  </c:if>
	  
  	<a href="${pageContext.servletContext.contextPath}/userpanel">Povratak na izbornik</a>
  	
  </body>
</html>