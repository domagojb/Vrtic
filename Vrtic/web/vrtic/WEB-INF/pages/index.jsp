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
    	function add() {
    		var element = document.getElementById("id_group").cloneNode(true);
    		
    		var foo = document.getElementById("fooBar");
    		foo.appendChild(element);
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
  	<!-- Navigation toolbar -->
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
		          <li>${sessionScope['current.user.fn']} ${sessionScope['current.user.ln']} <li>
		          <li><a href="logout" class="button">Logout</a></li>
		        </c:when>
		        <c:otherwise>
			   	  <li>Trenutno niste ulogirani</li>
			    </c:otherwise>
			  </c:choose>
		    </ul>
		
		    <!-- Left Nav Section -->
		    <ul class="left">
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
	</div>
  
    <!-- START BODY ROW-->
    <div class="row">
       <!-- START LEFT BODY -->
       <div class="small-12 large-8 columns">
	    <c:if test="${confirmationMsg != null }">
	      <p>${confirmationMsg}</p>
	    </c:if>
	    
	    <c:choose>
	      <c:when test="${signUpOpen == true}">
	        <h1>Prijave</h1>
	        <p>Otvorene su prijave za upis djece u vrtić. Ako želite upisati dijete, popunite formular ispod.</p>
	        <c:if test="${form.hasErrors() }">
	      	  <div data-alert class="alert-box alert round">
 				Postoje greške u formularu
  				<a href="#" class="close">&times;</a>
		  	 </div>
			</c:if>
		    <form method="post">
		      <table class="form_table">
		       <tr><td colspan="2"><p>Poredajte grupe u koje želite upisati dijete po prioritetu.</p></td></tr>
		       
		       <tr><td colspan="2"><ol id="fooBar">
		       					     <li id="id_group">
		       					       <select name="group"> 
		    	 					 	  <c:forEach var="group" items="${groups}">
			        						<option value="${group.id}">
			        						  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
			        						  <c:out value="${group.low}" />-<c:out value="${group.high}" />
			        						</option>
			      						  </c:forEach>
		    	 					   </select>
		    	 				    </li>			 
		    	 	 			  </ol>
		    	 	 			  <c:if test="${form.hasError('group')}">
				        		    <div class="greska"><c:out value="${form.getError('group')}" /></div>
				     			  </c:if>
		    	 	 			  
				     </td>
				     				 
		    	 	 </tr>
		    	 	
		       <tr><td></td><td><input class="small button" type="button" value="Dodaj grupu" onclick="add()"> <input class="small button" type="button" value="Makni grupu" onclick="removeGroup()"></td></tr>
		       
		    	 <tr><td colspan="2">Upišite podatke roditelja ili skrbnika</td></tr>
				 <tr><td class="form_td_info_text">Ime</td><td> <input type="text" name="firstname" value='<c:out value="${form.pFirstName}" />' size ="40">
				     <c:if test="${form.hasError('firstname')}">
				         <div class="greska"><c:out value="${form.getError('firstname')}" /></div>
				     </c:if></td>
				 </tr>
				     
				 <tr><td class="form_td_info_text">Prezime</td><td> <input type="text" name="lastname" value='<c:out value="${form.pLastName}" />' size ="40">
				     <c:if test="${form.hasError('lastname')}">
				         <div class="greska"><c:out value="${form.getError('lastname')}" /></div>
				     </c:if></td>
				 </tr>
				 
				 <tr><td class="form_td_info_text">OIB</td><td> <input type="text" name="oib" value='<c:out value="${form.pOIB}" />' size ="40">
				     <c:if test="${form.hasError('oib')}">
				         <div class="greska"><c:out value="${form.getError('oib')}" /></div>
				     </c:if></td>
				 </tr>
				     
				 <tr><td class="form_td_info_text">Adresa</td><td> <input type="text" name="address" value='<c:out value="${form.address}" />' size ="40">
				     <c:if test="${form.hasError('address')}">
				         <div class="greska"><c:out value="${form.getError('address')}" /></div>
				     </c:if></td>
				 </tr>    
				
				 <tr><td class="form_td_info_text">Telefon</td><td> <input type="text" name="phone" value='<c:out value="${form.phone}" />' size ="40">
				     <c:if test="${form.hasError('phone')}">
				         <div class="greska"><c:out value="${form.getError('phone')}" /></div>
				     </c:if></td>
				 </tr>
				 
				 <tr><td colspan="2">Ako se potražuje pravo na temelju socijalnog statusa</td></tr>
				 <tr><td colspan="2"><input type="checkbox" name="socialstatus" value="1">Označiti ako se traži</td></tr>
				 <tr><td class="form_td_info_text">Primanja (mjesečna)</td><td> <input type="text" name="income" value='<c:out value="${form.income}" />' size ="40">HRK
				     <c:if test="${form.hasError('income')}">
				         <div class="greska"><c:out value="${form.getError('income')}" /></div>
				     </c:if></td>
				 </tr>
				
				 <tr><td colspan="2">Podaci o djetetu</td></tr>
				 <tr><td class="form_td_info_text">Ime</td><td> <input type="text" name="c_firstname" value='<c:out value="${form.cFirstName}" />' size ="40">
				     <c:if test="${form.hasError('c_firstname')}">
				         <div class="greska"><c:out value="${form.getError('c_firstname')}" /></div>
				     </c:if></td>
				 </tr>
				     
				 <tr><td class="form_td_info_text">Prezime</td><td> <input type="text" name="c_lastname" value='<c:out value="${form.cLastName}" />' size ="40">
				     <c:if test="${form.hasError('c_lastname')}">
				         <div class="greska"><c:out value="${form.getError('c_lastname')}" /></div>
				     </c:if></td>
				 </tr>
				 
				 <tr><td class="form_td_info_text">OIB</td><td> <input type="text" name="c_oib" value='<c:out value="${form.cOIB}" />' size ="40">
				     <c:if test="${form.hasError('c_oib')}">
				         <div class="greska"><c:out value="${form.getError('c_oib')}" /></div>
				     </c:if></td>
				 </tr>
				 
				 <tr><td class="form_td_info_text">Spol</td><td><select name="sex"> 
			        				  <option value="m">M</option>
			        				  <option value="f">F</option>
		    	 					 </select>
		    	 					 
		    	 	 </td></tr>
				 <tr><td class="form_td_info_text">Datum rođenja</td><td><input type="date" name="birthdate">
				     <c:if test="${form.hasError('bday')}">
				         <div class="greska"><c:out value="${form.getError('bday')}" /></div>
				     </c:if></td>
				 </tr>
				
				 <tr><td></td><td>
				     <input class="button" type="submit" name="method"	value="Upis">
				     </td>
				 </tr>
			  </table>
		    </form>
	      </c:when>
	      <c:otherwise>
	        <p>Upisi u vrtić trenutno nisu otvoreni</p>
	      </c:otherwise>
	    </c:choose>
      </div>
      
      <!-- START RIGHT BODY -->
      <div class="small-12 large-4 columns">
	  	<c:choose>
	      <c:when test="${sessionScope['current.user.id'] != null}">
	        <p>Trenutno ste ulogirani kao ${sessionScope['current.user.fn']} ${sessionScope['current.user.ln']} <a href="logout">Logout</a></p>
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
	            <a href="${pageContext.servletContext.contextPath}/userpanel">Odgajateljni panel</a>          
	          </c:when>
	          <c:when test="${sessionScope['current.user.t'] == 'acc'}">
	            <a href="${pageContext.servletContext.contextPath}/userpanel">Računovodstveni panel</a>
	          </c:when>
	        </c:choose>
	      </c:when>
	      <c:otherwise>
	      	<p>Trenutno niste ulogirani.</p>
	      	<!-- Login form -->
		    <form method="post">
		    <table class="form_table">
		      <tr><td class="form_td_info_text">Korisničko ime</td><td> <input type="text" name="username"  size ="40"></td></tr>
			  <tr><td class="form_td_info_text">Zaporka</td><td> <input type="password" name="password"  size ="40"></td></tr>
			  <tr><td colspan="2"><c:if test="${loginError != null}">
			                          <div class="greska"><c:out value="${loginError}" /></div>
			                      </c:if></td></tr>
			  <tr><td></td><td><input class="button" type="submit" name="method" value="Log in"></td></tr>
			 </table>
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