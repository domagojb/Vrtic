<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
    
    <!-- Dynamic form adding -->
    <script>
	  function createGroupForm()
	  {
	     var table = document.getElementById('formTable');
	     var newGroupAge = document.createElement('input');
	     newGroupAge.type = "text";
	     newGroupAge.name = "group[]";
	     newGroupAge.size = "40";
	     newGroupAge.placeholder = "format: X-Y where x is the lowest age and y is the highest age";
	      
	     var tr = document.createElement('tr');
	     var td1 = document.createElement('td');
	     var td2 = document.createElement('td');
	    
	     td1.innerHTML = "Dobna skupina";
	    
	     td2.appendChild(newGroupAge);
	      
	     tr.appendChild(td1);
	     tr.appendChild(td2);
	     table.appendChild(tr);
	     
	     var newGroupAge = document.createElement('select');
	     newGroupAge.type = "text";
	     newGroupAge.name = "group[]";
	     newGroupAge.size = "40";
	     
	     var td1 = document.createElement('td');
	     var td2 = document.createElement('td');
	     
	     td1.innerHTML = "Odgajatelji";
		    
	     td2.appendChild(newGroupAge);
	      
	     tr.appendChild(td1);
	     tr.appendChild(td2);
	     table.appendChild(tr);
	     
	  }
	    
    </script>
    
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
        <h1>Dodajte novi objekt vrtića</h1>
    
    	<form id="workplaceForm" method="post">
  		<div class="row">
  	  	  <div class="large-12 columns">    	  
		    <label>Adresa 
		      <input type="text" name="address" value='<c:out value="${form.address}" />'>
		    </label>
		    <c:if test="${form.hasError('address')}">
		      <small class="error"><c:out value="${form.getError('address')}" /></small>
		    </c:if>
		  </div>
		</div>
  		<div class="row">
  	  	  <div class="large-12 columns">
  	  	    <label>Grad
  	  	      <input type="text" name="town" value='<c:out value="${form.town}" />'>
  	  	    </label>
		    <c:if test="${form.hasError('town')}">
		      <small class="error"><c:out value="${form.getError('town')}" /></small>
		    </c:if>
		  </div>
		</div>
  		<div class="row">
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