<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Otvaranje prijava</title>
    
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
	  	<h1>Otvaranje prijava</h1>
	  
	    <c:choose>
	      <c:when test="${msg != null}">
	        <div data-alert class="alert-box info radius">
			  ${msg}
			  <a href="#" class="close">&times;</a>
			</div>
	      </c:when>
	      <c:otherwise>
		    <p>Sljedeće grupe imaju mjesta i bit će otvorene za upis:</p>
		    <c:if test="${openGroups.isEmpty()}">
		      <div data-alert class="alert-box warning radius">
			    Nema grupa koje imaju mjesta
			    <a href="#" class="close">&times;</a>
			  </div>
		      </c:if>
		    <ul>
		      <c:forEach var="group" items="${openGroups}">
				<li>
				  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
				  <c:out value="${group.low}" />-<c:out value="${group.high}" />
				</li>
			  </c:forEach>
		    </ul>
		
		    <p>Sljedeće grupe su trenutno pune i neće biti razmatrane prilikom upisa:</p>
		    <ul>
		      <c:if test="${closedGroups.isEmpty()}">
		        <div data-alert class="alert-box info radius">
				  Nema punih grupa
				  <a href="#" class="close">&times;</a>
				</div>
		      </c:if>
		      <c:forEach var="group" items="${closedGroups}">
				<li>
				  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
				  <c:out value="${group.low}" />-<c:out value="${group.high}" />
				</li>
			  </c:forEach>
		    </ul>   
		        
		    <p>Želite li nastaviti?</p>
		    <form>
		      <input class="button" type="submit" name="method" value="Otvori upis">
		    </form>
		  </c:otherwise>	    
	    </c:choose>
	    
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