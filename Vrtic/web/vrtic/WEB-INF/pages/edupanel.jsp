<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> Odgajatelj</title>
        
    <!-- Foundation -->
    <meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	
  	<link rel="stylesheet" href="css/normalize.css">
  	<link rel="stylesheet" href="css/foundation.css">
  	
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
		            <li class="active"><a href="${pageContext.servletContext.contextPath}/userpanel">Odgajateljni panel</a></li>         
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
      <div class="small-12 large-12 columns">
        <h1>Korisnički panel</h1>
      
        <p> Upišite svu djecu koja su prisutna u vrtiću za svaki radni dan.</p>
  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/childrecord?id=${sessionScope['current.user.id']}">Provedi evidenciju</a>
  		<p> Upišite zapis u dnevnik rada. Opišite odrađen posao i vrijeme utrošeno na svaki.</p> 		
  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/educatoractivity?id=${sessionScope['current.user.id']}">Upis u dnevnik rada</a>
  	    <br />
  	    <a href="${pageContext.servletContext.contextPath}/">Vrati se na naslovnicu</a> 	    
  	  </div>
    </div>         
  	
  	<!-- Foundation -->
    <script src="js/vendor/jquery.js"></script>
 	<script src="js/foundation.min.js"></script>
 	<script>
   	 	$(document).foundation();
  	</script>
  	
  </body>
</html>