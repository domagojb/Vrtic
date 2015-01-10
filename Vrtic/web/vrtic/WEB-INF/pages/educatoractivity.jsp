<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Dnevnik rada</title>
    
    <!-- Setting gate to todays date -->
    <script type="text/javascript">
      document.getElementById('datePicker').valueAsDate = new Date();
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
  	    <h1>Dnevnik rada</h1>
  	    
	    <form method="post">
	      <input type="hidden" name="uid" value="${uid}">
	      <div class="row">
	        <div class="large-6 columns">
	          <label>Datum
	          	<input id="datePicker" type="date" name="date">
	          </label>
	   	      <c:if test="${form.hasError('date')}">
	            <div class="greska"><c:out value="${form.getError('date')}" /></div>
	          </c:if>
	        </div>
	      </div>
	      
	 	  <h4>Efektivni rad u grupi</h4>
	 		
	      <div class="row">
	        <div class="large-4 columns">
	          <div class="row collapse">
	          	<label>Utrošeno vrijeme</label>
	            <div class="large-8 columns">
	              <input name="ew_h" type="number" min="0" value="0" >
	            </div>
	            <div class="large-4 columns">
	              <span class="postfix">minuta</span>	              
	            </div>
	          </div>
	        </div>
	      </div>
	      
	      <div class="row">
	        <div class="large-12 columns">
				<label>Opis rada
				  <textarea name="ew"></textarea>
				</label>
	        </div>
	      </div>
	      
	      <h4>Priprema za rad</h4>
	      
	      <div class="row">
	        <div class="large-4 columns">
	          <div class="row collapse">
	        	<label>Utrošeno vrijeme</label>	          
	            <div class="large-8 columns">
	              <input name="wp_h" type="number" min="0" value="0" >
	            </div>
	            <div class="large-4 columns">
	              <span class="postfix">minuta</span>	              
	            </div>
	          </div>
	        </div>
	      </div>
	      
	      <div class="row">
	        <div class="large-12 columns">
				<label>Opis rada
				  <textarea name="wp"></textarea>
				</label>
	        </div>
	      </div>
	        
	      <h4>Stručno usavršavanje</h4>
	      
	      <div class="row">
	        <div class="large-4 columns">
	          <div class="row collapse">
	        	<label>Utrošeno vrijeme</label>	          
	            <div class="large-8 columns">
	              <input name="spec_h" type="number" min="0" value="0" >
	            </div>
	            <div class="large-4 columns">
	              <span class="postfix">minuta</span>	              
	            </div>
	          </div>
	        </div>
	      </div>
	      
	      <div class="row">
	        <div class="large-12 columns">
				<label>Opis rada
				  <textarea name="spec"></textarea>
				</label>
	        </div>
	      </div>
	        
	      <h4>Suradnja s roditeljima</h4>
	      <div class="row">
	        <div class="large-4 columns">
	          <div class="row collapse">
	          	<label>Utrošeno vrijeme</label>	          
	            <div class="large-8 columns">
	              <input name="pw_h" type="number" min="0" value="0" >
	            </div>
	            <div class="large-4 columns">
	              <span class="postfix">minuta</span>	              
	            </div>
	          </div>
	        </div>
	      </div>
	      
	      <div class="row">
	        <div class="large-12 columns">
				<label>Opis rada
				  <textarea name="pw"></textarea>
				</label>
	        </div>
	      </div>
	
	      <div class="row">
	        <div class="large-12 columns">
		      <input class="button" type="submit" name="metoda"	value="Upiši">
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
