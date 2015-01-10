<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Dodaj korisnika</title>
    
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
      <div class="large-12 columns">
        <h1>Dodajte novog korisnika</h1>
        
        <form method="post">
         <div class="row">
           <div class="large-6 columns">
             <label>Ime 
		       <input type="text" name="firstname" value='<c:out value="${form.firstName}" />' >
		 	 </label>
		     <c:if test="${form.hasError('firstname')}">
		       <small class="error"><c:out value="${form.getError('firstname')}" /></small>
		     </c:if>
	       </div>
	 
		   <div class="large-6 columns">
		     <label>Prezime
		       <input type="text" name="lastname" value='<c:out value="${form.lastName}" />' >
		     </label>
		     <c:if test="${form.hasError('lastname')}">
		       <small class="error"><c:out value="${form.getError('lastname')}" /></small>
		     </c:if>
	       </div>
	     </div>
		 
         <div class="row">
           <div class="large-6 columns">		 
		     <label>Korisničko ime
		       <input type="text" name="nick" value='<c:out value="${form.nick}" />' >
		     </label>
		     <c:if test="${form.hasError('nick')}">
		       <small class="error"><c:out value="${form.getError('nick')}" /></small>
		     </c:if>
		   </div>
		   
		   <div class="large-6 columns">
		     <label>Lozinka 
		       <input type="password" name="password" value='' >
		     </label>
		     <c:if test="${form.hasError('password')}">
		       <small class="error"><c:out value="${form.getError('password')}" /></small>
		     </c:if>
		   </div>
		 </div>
		 
         <div class="row">
           <div class="large-6 columns">			 
		     <label>Tip računa</label>
		     <input id="radio1" type="radio" name="userType" value="edu" checked><label for="radio1">Odgajatelj</label>
			 <input id="radio2" type="radio" name="userType" value="acc"><label for="radio2">Računovođa</label>
		   </div>
		
		   <div class="large-6 columns">			 		 
		     <input class="button" type="submit" name="metoda"	value="Primjeni">
		   </div>
		 </div>
        </form>
        
        <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
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