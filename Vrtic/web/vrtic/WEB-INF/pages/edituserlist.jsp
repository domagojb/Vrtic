<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Izmjena korisnika</title>
    
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
	    <h1>Izmjena korisnika</h1>
	    <c:choose>
	      <c:when  test="${users != null && users.isEmpty() == false}">
	        <div class="row">
	          <!-- LEFT SIDE -->
	          <div class="large-6 columns">
		        <h2>Izmjenite podatke korisnika</h2>
		        
		        <form method="post">
				  <div class="row">
				    <div class="large-12 columns">	  
				      <label>Odaberite korisnika sa liste kojeg želite izmejniti</label>        
			      	  <select name="user">
		                <c:forEach var="user" items="${users}">
		                  <option value="<c:out value="${user.id}" />">
		                    <c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /> <c:out value="${user.nick}" />
		                  </option>
		                </c:forEach>
			          </select>
		            </div>
		          </div>
		          <div class="row">
				    <div class="large-6 columns">	  	          
			      	  <input class="button" type="submit" name="method" value="Izmijeni podatke">
			        </div>
				    <div class="large-6 columns">	  		      
			      	  <input class="button" type="submit" name="method" value="Izmijeni lozinku">
			        </div>
			      </div>	      
		        </form>
	          </div>
	          
	          <!-- RIGHT SIDE -->
	          <div class="large-6 columns">	        
		        <h2>Izmjenite grupu odgajatelja</h2>
		        <c:choose>
		          <c:when test="${educators.isEmpty() == false}">
		            <form method="post">
					  <div class="row">
					    <div class="large-12 columns">	 
					      <label>Odaberite odgajatelja sa liste kojem želite dodjeliti/izmejniti grupu</label>           
			              <select name="educator">
				            <c:forEach var="user" items="${educators}">
				              <option value="<c:out value="${user.id}" />">
				                <c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /> <c:out value="${user.nick}" />
				              </option>
				            </c:forEach>
				          </select>
				        </div>
			          </div>
					  <div class="row">			          
					    <div class="large-12 columns">	 
					      <label>Odaberite grupu</label>
			          
					      <select name="group"> 
							 <c:forEach var="group" items="${groups}">
								<option value="${group.id}">
								  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
								  <c:out value="${group.low}" />-<c:out value="${group.high}" />
								</option>
						     </c:forEach>
						  </select>
					    </div>
					  </div>
					  
					  <div class="row">
					    <div class="large-12 columns">					  
			          	  <input class="button" type="submit" name="method" value="Izmijeni grupu">
			          	</div>
			          </div>		      
		            </form>
		          </c:when>
		          <c:otherwise>
		            <p>Trenutno nema odgajatelja u sustavu</p>
		          </c:otherwise>
		        </c:choose>
	          </div>
	        </div>
	      </c:when>
	      <c:otherwise>
	        <p>Trenutno nema korisnika</p>
	      </c:otherwise>
	    </c:choose>  
	      
	    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
      </div>
    </div>
  </body>
</html>
