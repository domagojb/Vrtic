<%@page import="hr.fer.zemris.opp.model.users.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> "Tulipan" </title>
    
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
	
    <!-- Search form -->
  	<div class="row">
  	  <div class="twelve columns">
  	    <h1>Pregled djece</h1>
 
	  	<div class="row">
	  	  <div class="large-6 columns"> 	  
		    <h4>Pretraži bazu</h4>
		  	<form>
		  	  <div class="row">
	  	  		<div class="large-12 columns">
		  	      <label>Ime
		  	        <input type="text" name="firstName">
		  	      </label>
		  	    </div>
		  	  </div>
		  	  <div class="row">
	  	  		<div class="large-12 columns">
	  	  		  <label>Prezime
		  	        <input type="text" name="lastName">
		  	      </label>
		  	    </div>
		  	  </div>
		  	  <div class="row">
	  	  		<div class="large-12 columns">
		  	      <label>OIB
		  	        <input type="text" name="oib"></td>
		  	      </label>
		  	    </div>
		  	  </div>
		  	  <div class="row">
	  	  		<div class="large-12 columns">		  	  
		  	  	  <input class="small button" type="submit" name="method" value="Pretraga">
		  	    </div>
		  	  </div>		  	  
		  	</form>
	 	  </div>
	  	  <div class="large-6 columns"> 	   
			<!-- By group list -->
			<h4>Pronađi po grupi</h4>
			<form method="get">
			  <label>Odaberite grupu</label>
			  <select name="group"> 
			 	<c:forEach var="group" items="${groups}">
				  <option value="${group.id}">
				    <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
				    <c:out value="${group.low}" />-<c:out value="${group.high}" />
				  </option>
				</c:forEach>
			 </select>
			 <input class="small button" type="submit" name="method" value="Odaberi">
			</form> 
		  </div>
		</div>
		
		<c:if test="${children != null}">
		  <h4>Rezultat pretrage</h4>
		  <c:if test="${children.isEmpty()}">
		    <p>Nema rezultata ili grupa ne sadrži djecu</p>
		  </c:if>
		  <ul>
		  <c:forEach var="child" items="${children}">
		    <li><a href="${pageContext.servletContext.contextPath}/userpanel/showchild?id=${child.id}">${child.firstName} ${child.lastName} OIB: ${child.oib}</a></li>
		  </c:forEach>
		  </ul>
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