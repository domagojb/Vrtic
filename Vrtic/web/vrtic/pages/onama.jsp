<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>O nama</title>
    
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
	    <h1>O nama</h1>
			 
	    <p>Dječji vrtić <i>Tulipa</i> provodi program predškolskog odgoja i naobrazbe u novoizgrađenom objektu. Vrtić se nalazi u gradovima diljem Hrvatske. 
	       Svi vrtići su opremljeni prostorima pratećeg sadržaja: suvremeno opremljenom kuhinjom, praonicom i velikim prostorom  za proširenu komunikaciju.  
	       Jedan dio tog prostora osmišljen je za provođenje programa predškole koja  se u vrtiću provodi dva puta tjedno. 
	       Za vrijeme kišnih dana tu provodimo tjelesne aktivnosti  i  tjelovježbu.
		</p>
		
		<h3>Vizija našeg vrtića</h3>

		<p>Vrtić u kojem se dijete osjeća prihvaćano, sretno i sigurno, u kojem prevladava pozitivno ozračje, kako za dijete, tako i za roditelje i zaposlene u vrtiću.
		</p>
 

		<h3>Misija</h3>

		<p>Vrtić  koji omogućava  djetetu  da u optimalnim uvjetima uči, zadovolji i razvija svoje tjelesne, intelektualne, emocionalne i socijalne vještine i sposobnosti. Kvalitetan odgojno obrazovni rad, stalno stručno usavršavanje, ekipiranje stručnog tima. Jačanje suradnje i partnerstva s roditeljima i društvenom zajednicom.
		<p/>
		
		<h3>Upisi</h3>
		<p>Prijave za upis u vrtić se otvaraju dva puta godišnje. Jednom u jesen, te jednom u proljeće. Točni datumi će biti objavljeni na našim stranicama.
		</p>
		
		<h3>Kontakt</h3>
		<p>vrtic@tulipan.hr</p>
		<p>01 / 666 - 555</p>
		      
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