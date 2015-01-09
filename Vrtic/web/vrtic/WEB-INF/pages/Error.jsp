<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Greška!</title>
    
    <!-- Foundation -->
    <meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	
  	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/normalize.css">
  	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/foundation.css">
  	
  	<script src="js/vendor/modernizr.js"></script>
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
		          <li><a href="logout" class="button">Logout</a></li>
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
  	    <h1>Pogreška!</h1>
  	  </div>
  	</div>
  	<div class="row">
	  <div class="large-12 columns">
  	    <p>${userErrorMessage}</p>
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