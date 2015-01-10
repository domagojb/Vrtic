<%@page import="hr.fer.zemris.opp.model.users.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> "Tulipan" - Odgajatelj</title>
    <!-- Foundation -->
    <meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	
  	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/normalize.css">
  	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/foundation.css">
  	
  	<script src="${pageContext.servletContext.contextPath}/js/vendor/modernizr.js"></script>
  </head>
  <body>
    <!-- TOP BAR -->
  	<div class="row">
  	  <div class="twelve columns">
	  	<nav class="top-bar contain-to-grid" data-topbar role="navigation">
		  <ul class="title-area">
		    <li class="name">
		      <h1><a href="${pageContext.servletContext.contextPath}">Naslovnica</a></h1>
		    </li>
		     <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
		    <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
		  </ul>
		
		  <section class="top-bar-section">
		    <!-- Right Nav Section -->
		    <ul class="right">
		      <c:choose >
		        <c:when test="${sessionScope['current.user.id'] != null}">
		          <li><a href="#">${sessionScope['current.user.fn']} ${sessionScope['current.user.ln']}</a><li>
		          <li><a href="${pageContext.servletContext.contextPath}/logout" class="button">Logout</a></li>
		        </c:when>
		        <c:otherwise>
			   	  <li><a href="#">Trenutno niste ulogirani</a></li>
			    </c:otherwise>
			  </c:choose>
		    </ul>
		
		    <!-- Left Nav Section -->
		    <ul class="left">
		      <li><a href="${pageContext.servletContext.contextPath}/pages/onama.html">O nama</a></li>
		      <c:if test="${sessionScope['current.user.id'] != null}">
		        <c:choose>
		          <c:when test="${sessionScope['current.user.t'] == 'adm'}">
		            <li><a href="${pageContext.servletContext.contextPath}/userpanel">Administrativni panel</a></li>
		          </c:when>
		          <c:when test="${sessionScope['current.user.t'] == 'edu'}">
		            <li><a href="${pageContext.servletContext.contextPath}/userpanel">Odgajateljni panel</a></li>         
		          </c:when>
		          <c:when test="${sessionScope['current.user.t'] == 'acc'}">
		            <li><a href="${pageContext.servletContext.contextPath}/userpanel">Računovodstveni panel</a></li>
		          </c:when>
		        </c:choose>
	          </c:if>
		    </ul>
		  </section>
		</nav>
	  </div>
	</div> <!-- TOP BAR END -->
	
  	<div class="row">
  	  <div class="twelve columns">	
  	  <h1>Pregled dnevnika rada odgajatelja</h1>
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
	  	          <input class="small button" type="submit" value="Odaberi">
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
  	  </div>
  	</div>
  	
  	<!-- Foundation -->
    <script src="${pageContext.servletContext.contextPath}/js/vendor/jquery.js"></script>
 	<script src="${pageContext.servletContext.contextPath}/js/foundation.min.js"></script>
 	<script>
   	 	$(document).foundation();
  	</script>
  </body>
</html>