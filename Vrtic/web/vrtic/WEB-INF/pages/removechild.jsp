<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Ispis djeteta</title>
    
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
	    <h1>Ispis djeteta</h1>
	
		<div class="row">
		  <div class="large-6 columns">
			<!-- Forma za selektiranje grupe -->
			<form method="get">
			  <p>Odaberite grupu</p>
			  <select name="group"> 
			 	<c:forEach var="group" items="${groups}">
				  <option value="${group.id}">
				    <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
				    <c:out value="${group.low}" />-<c:out value="${group.high}" />
				  </option>
				</c:forEach>
			 </select>
			 <input class="small button" type="submit" name="metoda" value="Odaberi">
			</form>
	      </div>
		  <div class="large-6 columns">    
		    <!-- Children list from selected group --> 
		    <c:choose>
		      <c:when  test="${children != null && children.isEmpty() == false}">
		        <p>Odaberite dijete sa liste koje želite ispisati</p>
		        <form method="post">
			      <c:forEach var="child" items="${children}">
			        <input type="radio" name="child" value="<c:out value="${child.id}" />">
			        <label><c:out value="${child.firstName}" /> <c:out value="${child.lastName}" /> OIB: <c:out value="${child.oib}" /></label>
			        <br>
			      </c:forEach>
		
			      <input class="button" type="submit" name="metoda" value="Ispiši">
		        </form>
		      </c:when>
		      <c:when test="${children != null && children.isEmpty()}">
		        <p>Trenutno nema djece u grupi</p>
		      </c:when>
		      <c:otherwise>
		        <p>Trenutno nije odabrana grupa</p>
		      </c:otherwise>
		    </c:choose>    
	      </div>
	    </div> 
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