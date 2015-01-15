<%@page import="java.util.List"%>
<%@page import="hr.fer.zemris.opp.model.Group"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en" >

<html>
  <head>
    <title>"Tulipan"</title>
    
    <link rel="stylesheet" type="text/css" href="css/forms.css">
    
    <!-- Foundation -->
    <meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	
  	<link rel="stylesheet" href="css/normalize.css">
  	<link rel="stylesheet" href="css/foundation.css">
  	
  	<script src="js/vendor/modernizr.js"></script>
    
    <script language="javascript">
    	function addGroup() {
    		var foo = document.getElementById("fooBar");
    		var a = foo.childNodes.length;
    		var d = <%=((Integer)((List<Group>)request.getAttribute("groups")).size())%>;  
    		if (a < (d+2)) {
    			var element = document.getElementById("id_group").cloneNode(true);
    		
    			foo.appendChild(element);
    		}
    	}
    	
    	function removeGroup() {
    		var foo = document.getElementById("fooBar");
    		var c = foo.childNodes.length;
    	    if (c > 2) {
				foo.removeChild(foo.lastChild);
    		}
    	}
    </script>
    
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
		          <li><a href="${pageContext.servletContext.contextPath}/logout" class="button">Logout</a></li>
		        </c:when>
		        <c:otherwise>
			   	  <li><a href="#">Trenutno niste ulogirani</a></li>
			    </c:otherwise>
			  </c:choose>
		    </ul>
		
		    <!-- Left Nav Section -->
		    <ul class="left">
		      <li><a href="${pageContext.servletContext.contextPath}/pages/onama.jsp">O nama</a></li>
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
  
    <!-- START BODY ROW-->
    <div class="row">
       <!-- START LEFT BODY -->
       <div class="small-12 large-8 columns"> 
	    <c:choose>
	      <c:when test="${signUpOpen == true}">
	        <h1>Prijave</h1>
	        <p>Otvorene su prijave za upis djece u vrtić. Ako želite upisati dijete, popunite formular ispod.</p>
	        <c:choose>
	          <c:when test="${alert == true}">
	      	    <div data-alert class="alert-box alert radius">
 				  Postoje greške u formularu
  				  <a href="#" class="close">&times;</a>
		  	    </div>
		  	  </c:when>
		  	  <c:when test="${confirmation == true}">
	      	    <div data-alert class="alert-box success radius">
 				  Prijava je uspješno poslana
  				  <a href="#" class="close">&times;</a>
		  	    </div>
		  	  </c:when>
			</c:choose>
		    <form method="post">
		      
		      
		      <div class="row">
    			<div class="large-12 columns"> 
    			  <label>Poredajte grupe u koje želite upisati dijete po prioritetu.</label>
    			  
		          <ol id="fooBar">
				    <li id="id_group">
  					  <select name="group"> 
 					    <c:forEach var="group" items="${groups}">
    						<option value="${group.id}">
    						  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
    						  Dobna skupina: <c:out value="${group.low}" /> do <c:out value="${group.high} godina/e" />
    						</option>
  						</c:forEach>
 					 </select>
 				   </li>			 
 	 			 </ol>
 	 			 
 	 			 <c:if test="${form.hasError('group')}">
     		       <small class="error"><c:out value="${form.getError('group')}" /></small>
  			     </c:if>
		       </div> 			  
		     </div>
		     
		     <div class="row">
    		   <div class="large-6 columns">	 	
		         <input class="small button" type="button" value="Dodaj grupu" onclick="addGroup()"> 
		       </div>
		       <div class="large-6 columns">	 	
		         <input class="small button" type="button" value="Makni grupu" onclick="removeGroup()">
		       </div>
		     </div>
		     
		     <div class="row">
    		   <div class="large-12 columns">
		         <p>Upišite podatke roditelja ili skrbnika</p>
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
		     <input class="button" type="submit" name="method"	value="Upis">				     				 			  
		   </form>
	      </c:when>
	      <c:otherwise>
	        <h1>Vrtić "Tulipan"</h1>
	        <p>Upisi u vrtić trenutno nisu otvoreni. Upisi se otvaraju svake godine dva puta. U proljeće i jesen. Izuzetno se upisi otvaraju
	           ako postoji puno mjesta u određenim grupama vrtića.</p>
	        <p>U vrtić se može upisati bilo koje dijete koje zadovoljava dobnu skupinu neke grupe u vrtiću.</p>
	        <p>Saznajte više o našim vrtićima na <a href="${pageContext.servletContext.contextPath}/pages/onama.jsp">ovdje</a>.
	      </c:otherwise>
	    </c:choose>
      </div>
      
      <!-- START RIGHT BODY -->
      <div class="small-12 large-4 columns">
	  	<c:choose>
	      <c:when test="${sessionScope['current.user.id'] != null}">
	        <p>Trenutno ste ulogirani kao ${sessionScope['current.user.fn']} ${sessionScope['current.user.ln']} <a href="logout">Logout</a></p>
	        <h3>Brzi panel</h3>
	        <c:choose>
	          <c:when test="${sessionScope['current.user.t'] == 'adm'}">
	            <div class="row">
	              <div class="small-12 large-12 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/adduser">Dodaj novog korisnika</a>
			  	  </div>
			    </div>
			    <div class="row">
			      <div class="small-6 large-6 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/removeuser">Obrisi korisnika</a>
			  	  </div>
			  	  <div class="small-6 large-6 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/edituser">Izmjeni korisnika</a>
			  	  </div>
			    </div>
			    <div class="row">
	              <div class="small-12 large-6 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/addworkplace">Dodaj objekt</a>
			  	  </div>
			  	  <div class="small-12 large-6 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/addgroup">Dodaj grupu</a> 
			  	  </div>
			  	</div>
			  	<div class="row">			  	
			      <div class="small-12 large-6 columns">		
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/removeworkplace">Obriši objekt</a> 
			  	  </div>
			  	  <div class="small-12 large-6 columns">	
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/removegroup">Obriši grupu</a>	
			  	  </div>
			  	</div>
			    <div class="row">			  	
			  	  <div class="small-12 large-6 columns">			  	 
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/addchild">Upiši dijete</a>  
			  	  </div>
			  	  <div class="small-12 large-6 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/removechild">Ispiši dijete</a>
			  	  </div>
			    </div>
			    <div class="row">			  	
			      <div class="small-12 large-6 columns">		
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/opensignup">Otvori prijave</a> 
			  	  </div>
			  	  <div class="small-12 large-6 columns">	
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/closesignup">Zatvori prijave</a>	
			  	  </div>
			  	</div>
	          </c:when>
	          <c:when test="${sessionScope['current.user.t'] == 'edu'}">
	            <div class="row">
	              <div class="small-12 large-12 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/childrecord?id=${sessionScope['current.user.id']}">Provedi evidenciju</a>
			  	  </div>
			    </div>
			    <div class="row">
	              <div class="small-12 large-12 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/educatoractivity?id=${sessionScope['current.user.id']}">Upis u dnevnik rada</a>
			  	  </div>
			    </div>         
	          </c:when>
	          <c:when test="${sessionScope['current.user.t'] == 'acc'}">
	            <div class="row">
	              <div class="small-12 large-12 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/veiwactivitylogs">Pregledaj dnevnike rada</a>
			  	  </div>
			    </div>
			    <div class="row">
	              <div class="small-12 large-12 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/eduworktime">Izračun mjesečnog rada odgajatelja</a>
			  	  </div>
			    </div>
			    <div class="row">
	              <div class="small-12 large-12 columns">
			  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/findchild">Pregled evidencije djece</a>
			  	  </div>
			    </div>  
	          </c:when>
	        </c:choose>
	      </c:when>
	      <c:otherwise>
	      	<p>Trenutno niste ulogirani.</p>
	      	<!-- Login form -->
		    <form method="post">
		      <div class="row">
    			<div class="large-12 columns">
    			  <label>Korisničko ime 
    			    <input type="text" name="username" placeholder="Korisničko ime">
    			  </label>
    			</div>
    		  </div>
    		  
		      <div class="row">
    			<div class="large-12 columns">
    			  <label>
			        Zaporka
			        <input type="password" name="password"  placeholder="Zaporka">
			      </label>
			    </div>
			  </div>
			  <c:if test="${loginError != null}">
			     <small class="error"><c:out value="${loginError}" /></small>
			  </c:if>
			  <input class="button" type="submit" name="method" value="Log in"> 
		    </form>
		    <!-- End login form -->
	      </c:otherwise>
	    </c:choose>
      </div> <!-- END RIGHT/UPPER BODY -->
      
    </div>     <!-- END BODY ROW-->
    
    <!-- Foundation -->
    <script src="js/vendor/jquery.js"></script>
 	<script src="js/foundation.min.js"></script>
 	<script>
   	 	$(document).foundation();
  	</script>
  </body>
</html>