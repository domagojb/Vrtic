<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Dodaj grupu</title>

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
        <h1>Dodajte novu grupu vrtića</h1>
    
    <form id="groupForm" method="post">
      <div class="row">
        <div class="large-12 columns"> 
    	  <label>Odaberite objekt kojem želite dodati grupu</label>
    	  <select name="workplace"> 
		 	<c:forEach var="workplace" items="${workplaces}">
			  <option value="${workplace.id}"><c:out value="${workplace.address}" />, <c:out value="${workplace.town}" /></option>
			</c:forEach>
		  </select>
		  <c:if test="${form.hasError('workplace')}">
  		    <small class="error"><c:out value="${form.getError('workplace')}" /></small>
		  </c:if>
		</div>
 	  </div>
 	  
      <div class="row">
        <div class="large-4 columns">	 
		  <label>Donja granična dob
		    <input type="text" name="low" value='<c:out value="${form.low}" />' >
		  </label>
	     <c:if test="${form.hasError('low')}">
	       <small class="error"><c:out value="${form.getError('low')}" /></small>
	     </c:if>
		</div>
        <div class="large-4 columns">	 
		  <label>Gornja granična dob
		    <input type="text" name="high" value='<c:out value="${form.high}" />' >
		  </label>
	      <c:if test="${form.hasError('high')}">
	        <small class="error"><c:out value="${form.getError('high')}" /></small>
	      </c:if>
		</div>
        <div class="large-4 columns">	 
		  <label>Kapacitet
		    <input type="text" name="capacity" value='<c:out value="${form.capacity}" />' >
		  </label>
	      <c:if test="${form.hasError('capacity')}">
	        <small class="error"><c:out value="${form.getError('capacity')}" /></small>
	      </c:if>
		</div>
        
        <div class="large-12 columns">	 
		  <label>Odaberite odgajatelje</label>
			<select name="educators" multiple> 
		 	  <c:forEach var="educator" items="${educators}">
    			<option value="${educator.id}"><c:out value="${educator.firstName}"></c:out> <c:out value="${educator.lastName}"></c:out></option>
  			  </c:forEach>
 			</select>
 		  <c:if test="${form.hasError('educators')}">
      		<small class="error"><c:out value="${form.getError('educators')}" /></small>
  		  </c:if>
    	</div>
    	
        <div class="large-12 columns">	 
	 	  <input class="button" type="submit" name="metoda" value="Spremi">
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