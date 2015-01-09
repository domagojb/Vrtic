<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en" >

<html>
  <head>
    <title>Dodaj dijete</title>
        
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
		      <h1><a href="#">Naslovnica</a></h1>
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
    
    <form method="post">
		      <div class="row">
    			<div class="large-12 columns"> 
    			  <h1>Upis djeteta:</h1>
                  <label>Odaberite grupu</label>
                    <select name="group"> 
 	 				  <c:forEach var="group" items="${groups}">
      				    <option value="${group.id}">
   						  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
  						  <c:out value="${group.low}" />-<c:out value="${group.high}" />
  						</option>
					  </c:forEach>
 	 			    </select>
 	 			   <c:if test="${form.hasError('group')}">
        		     <div class="greska"><c:out value="${form.getError('group')}" /></div>
    			   </c:if></td>
    	 	     </div>
    	 	   </div>
 
		      <div class="row">
    			<div class="large-12 columns">    	 	
                  <label>Odaberite roditelja ili skrbnika ako već postoji</label>
    	            <select name="parent">
					  <option value="-1">Novi roditelj</option> 
					  <c:forEach var="parent" items="${parents}">
   					    <option value="${parent.id}"><c:out value="${parent.firstName}" /> <c:out value="${parent.lastName}" />; OIB: <c:out value="${parent.oib}" /></option>
 					  </c:forEach>
				    </select>
    	 	      </div>
    	 	    </div>				 
    	 	 
    	     <div class="row">
    		   <div class="large-12 columns">
		         <p>Upišite podatke roditelja ili skrbnika ako ne postoji</p>
		       </div>
		     </div>
		     
		     <div class="row">
    		   <div class="large-6 columns">
				 <label>Ime
				   <input type="text" name="firstname" value='<c:out value="${form.pFirstName}" />' >
				 </label>
			     <c:if test="${form.hasError('firstname')}">
			       <small class="error"><c:out value="${form.getError('firstname')}" /></small>
			     </c:if>
			   </div> 
			 
				     
			   <div class="large-6 columns">
				 <label>Prezime 
				   <input type="text" name="lastname" value='<c:out value="${form.pLastName}" />' >
				 </label>
			     <c:if test="${form.hasError('lastname')}">
			       <small class="error"><c:out value="${form.getError('lastname')}" /></small>
			     </c:if>
			   </div>
			 </div>	 
		     <div class="row">
    		   <div class="large-12 columns">
				 <label>OIB 
				 <input type="text" name="oib" value='<c:out value="${form.pOIB}" />' >
				 </label>
			     <c:if test="${form.hasError('oib')}">
			       <small class="error"><c:out value="${form.getError('oib')}" /></small>
			     </c:if>
			   </div>
			 </div>
				     
		     <div class="row">
    		   <div class="large-12 columns">
				 
				 <label>Adresa 
				   <input type="text" name="address" value='<c:out value="${form.address}" />' >
				 </label>
			     <c:if test="${form.hasError('address')}">
			       <small class="error"><c:out value="${form.getError('address')}" /></small>
			     </c:if>
			   </div>
			 </div>
				    
		     <div class="row">
    		   <div class="large-12 columns">				
				 <label>Telefon
				   <input type="text" name="phone" value='<c:out value="${form.phone}" />' >
				 </label>
			     <c:if test="${form.hasError('phone')}">
			       <small class="error"><c:out value="${form.getError('phone')}" /></small>
			     </c:if>
			   </div>
			 </div>
				 
		     <div class="row">
    		   <div class="large-12 columns">
		         <p>Ako se potražuje pravo na temelju socijalnog statusa</p>
		       </div>
		     </div>
				 
		     <div class="row">
    		   <div class="large-4 columns">				 
				 <input type="checkbox" name="socialstatus" value="1" id="checkbox1"><label for="checkbox1">Označiti ako se traži</label>
			   </div>
    		   <div class="large-8 columns">
    		     <div class="row collapse">				 
				   <label>Primanja (mjesečna)</label>
				   <div class="small-9 columns">
				     <input type="text" name="income" value='<c:out value="${form.income}" />' >
				   </div>
				   <div class="small-3 columns">
          		     <span class="postfix">HRK</span>
        		   </div>
        		 </div>
				 <c:if test="${form.hasError('income')}">
				   <small class="error"><c:out value="${form.getError('income')}" /></small>
				 </c:if>			     
			   </div>
			 </div> 
				
		     <div class="row">
    		   <div class="large-12 columns">
		         <p>Upišite podatke djeteta</p>
		       </div>
		     </div>
		     
		     <div class="row">
    		   <div class="large-6 columns">
			     <label>Ime
				  <input type="text" name="c_firstname" value='<c:out value="${form.cFirstName}" />' >
				 </label>
			     <c:if test="${form.hasError('c_firstname')}">
			       <small class="error"><c:out value="${form.getError('c_firstname')}" /></small>
			     </c:if>
			   </div>
			
    		   <div class="large-6 columns">				     
				 <label>Prezime
				   <input type="text" name="c_lastname" value='<c:out value="${form.cLastName}" />' >
				 </label>
			     <c:if test="${form.hasError('c_lastname')}">
			       <small class="error"><c:out value="${form.getError('c_lastname')}" /></small>
			     </c:if>
			   </div>
			 </div>
				 
		     <div class="row">
    		   <div class="large-12 columns">				 
				 <label>OIB
				   <input type="text" name="c_oib" value='<c:out value="${form.cOIB}" />'>
				 </label>
			     <c:if test="${form.hasError('c_oib')}">
			       <small class="error"><c:out value="${form.getError('c_oib')}" /></small>
			     </c:if>
			   </div>
			 </div>	 

		     <div class="row">
    		   <div class="large-3 columns">				 
				 <label>Spol
				   <select name="sex"> 
			         <option value="m">M</option>
			         <option value="f">F</option>
		    	   </select>
		    	 </label>
		       </div>
    		   <div class="large-9 columns">				 
		         <label>Datum rođenja
				   <input type="date" name="birthdate">
				 </label>
			     <c:if test="${form.hasError('bday')}">
			       <small class="error"><c:out value="${form.getError('bday')}" /></small>
			     </c:if>
			   </div>
			 </div>
			 <div class="row">
    		   <div class="large-12 columns">
		         <input class="button" type="submit" name="method"	value="Upis">
		       </div>
		     </div>	
    </form>
        
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
    
    <!-- Foundation -->
    <script src="${pageContext.servletContext.contextPath}/js/vendor/jquery.js"></script>
 	<script src="${pageContext.servletContext.contextPath}/js/foundation.min.js"></script>
 	<script>
   	 	$(document).foundation();
  	</script>
  </body>
</html>