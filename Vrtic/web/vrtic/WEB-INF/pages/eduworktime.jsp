<%@page import="hr.fer.zemris.opp.model.users.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> Pregled rada odgajatelja </title>
    
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
  	    <h1>Uvid u mjesečne radne aktivnosti odgajatelja</h1>
	   	<form>
	   	  <div class="row">
	   	    <div class="large-2 columns">
	   	      <label>Mjesec 
	   	        <input name="month" type="number" min="1" max="12" required>
	   	      </label>
	   	    </div>
	   	    <div class="large-2 columns">
	   	      <label>Godina 
	   	        <input name="year" type="number" min="0" required>
	   	      </label>
	   	    </div>
	   	    <div class="large-6 columns">
	   	      <label>Odgajatelj</label> 
	   	      <select name="educator">
                <c:forEach var="educator" items="${educators}">
                  <option value="${educator.id}">${educator.firstName} ${educator.lastName}; ${educator.nick}</option>
                </c:forEach>
	   	      </select>
	   	    </div>
	   	    <div class="large-2 columns">
	   	  	  <input class="button" type="submit" value="Odaberi">
	   	    </div>
	   	  </div>
	   	</form>
	   	
	   	<c:if test="${educator == null}">
	   	  <p>Trenutno nije odabran ni jedan odgajatelj</p>
	   	</c:if>
	   	
	    <c:if test="${educator != null}">
	   	  <p>Prikaz za mjesec <i>${month}</i> i godinu <i>${year}</i></p>
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
	
		  <h4>Ukupno</h4>
		  <p>Ukupno utrošeno ${wh} minuta</p>
		  <p>Bruto plaća po 30 kn/h: ${pay} </p>
	   	</c:if>
	    	   	
	  	<a href="${pageContext.servletContext.contextPath}/userpanel">Povratak na izbornik</a>
	  </div>
	</div>
  	
  </body>
</html>