<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> Admin panel</title>
        
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
		            <li><a href="${pageContext.servletContext.contextPath}/userpanel">Odgajateljni panel</a></li>         
		          </c:when>
		          <c:when test="${sessionScope['current.user.t'] == 'acc'}">
		            <li class="active"><a href="${pageContext.servletContext.contextPath}/userpanel">Računovodstveni panel</a></li>
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
      </div>
    </div>
  	<div class="row">
      <div class="small-12 large-4 columns">    
        <p> Dodajte novog korisnika, odnosno zaposlenika.</p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/adduser">Dodaj novog korisnika</a>  
      </div>		
      <div class="small-12 large-4 columns">    
		<p> Obrišite određenog korisnika iz sustava.</p> 		
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/removeuser">Obriši korisnika</a>		
	  </div>
	  <div class="small-12 large-4 columns">    
		<p> Izmjenite podatke nekom korisniku. </p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/edituser">Izmjeni korisnika</a>	
	  </div>
	</div>
	<div class="row">
      <div class="small-12 large-4 columns">
		<p> Dodajte novi objekt vrtića u sustav </p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/addworkplace">Dodaj objekt</a>	
      </div>
      <div class="small-12 large-4 columns">
		<p> Dodajte novu grupu određenom objektu </p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/addgroup">Dodaj grupu</a>	 
	  </div>
	  <div class="small-12 large-4 columns">
		<p> Naknadno upišite djete u vrtić </p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/addchild">Upiši dijete</a> 	
	  </div>
	</div>
	<div class="row">
	  <div class="small-12 large-4 columns">		
	    <p>Obrišite objekt iz sustava.</p>
  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/removeworkplace">Obriši objekt</a> 
  	  </div>
  	  <div class="small-12 large-4 columns">	
  	    <p>Obrišite grupu iz sustava.</p>
  	    <a class="button" href="${pageContext.servletContext.contextPath}/userpanel/removegroup">Obriši grupu</a>	
  	  </div>
      <div class="small-12 large-4 columns">
		<p> Ispišite dijete iz vrtića </p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/removechild">Ispiši dijete</a> 
	  </div>
	</div>
	<div class="row">
      <div class="small-12 large-4 columns">
		<p> Otvorite prijave u vrtić. </p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/opensignup">Otvori prijave</a> 
	  </div>
	  <div class="small-12 large-4 columns">
		<p> Zatvorite prijave </p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/closesignup">Zatvori prijave</a>  
	  </div>
	  <div class="small-12 large-4 columns">
	  </div>  
	</div>
  	<div class="row">
  	  <div class="large-6 columns">    
  	    <h2>Funkcije računovođe</h2>
  	    <p> Odradite funkcije računovođe. </p>
  	    <br>
  	    <p> Pregledajte dnevnike rada za svakog odgajatelja.</p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/veiwactivitylogs">Pregledaj dnevnike rada</a>
  		<p> Pregledajte stanje utrošenog rada svakog odgajatelja za određen mjesec. Izraćun plaće se obavlja prema stanju na kraju svakog mjeseca.</p> 		
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/eduworktime">Izračun mjesečnog rada odgajatelja</a>
		<p> Pregledajte za svako dijete broj dolazaka za svaki mjesec te stanje uplata za svaki mjesec. </p>
		<a class="button" href="${pageContext.servletContext.contextPath}/userpanel/findchild">Pregled evidencije djece</a>
	  </div>
	  <div class="small-12 large-6 columns">
        <h2>Funkcije odgajatelja</h2>
        <p> Odradite funkcije odgajatelja</p>
      
        <form method="post">
          <label>Odaberite odgajatelja za kojeg želite odraditi funkciju
            <select name="educator"> 
		 	  <c:forEach var="educator" items="${educators}">
			    <option value="${educator.id}"><c:out value="${educator.firstName}"></c:out> <c:out value="${educator.lastName}"></c:out></option>
			  </c:forEach>
		    </select>
          </label>
          <p> Upišite svu djecu koja su prisutna u vrtiću za svaki radni dan.</p>
          <input type="submit" name="method" class="button" value="Provedi evidenciju">
  		  <p> Upišite zapis u dnevnik rada. Opišite odrađen posao i vrijeme utrošeno na svaki.</p> 		
          <input type="submit" name="method" class="button" value="Upis u dnevnik rada">
        </form>
  	    	    
  	  </div>
	</div>	
	
	<div class="row">
	  <div class="larger-12 columns">
		<br>
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
