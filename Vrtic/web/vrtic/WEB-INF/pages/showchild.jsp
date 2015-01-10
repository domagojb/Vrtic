<%@page import="hr.fer.zemris.opp.model.users.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> Pregled djeteta </title>
    
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
	   	<div class="row">
	   	  <div class="large-6 columns">  	   	
		   	<h1>Pregeld djeteta</h1>
		   	
		   	<table>
		   	  <tr>
		   	    <td>Ime i prezime</td>
		   	    <td>${child.firstName} ${child.lastName}</td>
		   	  </tr>
		   	  <tr>
		   	    <td>OIB</td>
		   	    <td>${child.oib}
		   	  </td>
		   	  <tr>
		   	    <td>Datum rođenja</td>
		   	    <td>${child.birthdate}
		   	  </td>
		   	</table>
		   	
		   	<h4>Informacije o roditelju</h4>
		   	
		   	<table>
		   	  <tr>
		   	    <td>Ime i prezime</td>
		   	    <td>${child.parent.firstName} ${child.parent.lastName}</td>
		   	  </tr>
		   	  <tr>
		   	    <td>Adresa</td>
		   	    <td>${child.parent.address}
		   	  </td>
		   	  <tr>
		   	    <td>Kontakt</td>
		   	    <td>${child.parent.phone}
		   	  </td>
		   	</table>
		  </div>
	   	  <div class="large-6 columns">  	   			  
		   	<h4>Tablica uplata i dolazaka</h4>
		   	
		   	<!-- Form for year selection -->
		   	<p>Odaberite godinu za koju želite ispis uplata i dolazaka</p>
		   	<form>
		   	  <input type="hidden" name="id" value="${child.id}">
		   	  <div class="row">
		   	    <div class="large-12 columns">
			   	  <div class="row">
			   	    <div class="large-6 columns">	   	    
				   	  <select name="paymentyear">
				   	    <c:forEach var="year" items="${years}">
				   	      <option value="${year}">${year}</option>
				   	    </c:forEach>
				   	  </select>
				   	</div>
			   	    <div class="large-6 columns">	   	    			   	
			   	  	  <input class="small button" type="submit" value="Odaberi">
			   	  	</div>
			   	  </div>
		   	  	</div>
		   	 </div>
		   	</form>
		   	
		   	<p>Prikaz za <c:out value="${selectedPaymentYear}" /> godinu</p>
		   	<c:set var="month" value="0" scope="page" />
		    <table>
		      <thead>
		        <tr>
		          <td>Mjesec</td><td>Uplaćeno</td><td>Broj dolazaka</td>
		        </tr>
		      </thead>
		      <tbody>
		        <tr>
		          <td>Siječanj</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Veljača</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Ožujak</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Travanj</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Svibanj</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Lipanj</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Srpanj</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Kolovoz</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Rujan</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Listopad</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Studeni</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		          <c:set var="month" value="${month + 1}" scope="page" />
		        </tr>
		         <tr>
		          <td>Prosinac</td>
		          <td><c:out value="${paymentStrings.get(month)}"/></td>
		          <td><c:out value="${attendanceCount.get(month) }" /></td>
		        </tr>
		      </tbody>
		    </table>
	      </div>
	    </div>    	   	
		<a href="${pageContext.servletContext.contextPath}/userpanel/findchild">Povratak na prethodnu stranicu</a>
	  	<a href="${pageContext.servletContext.contextPath}/userpanel">Povratak na izbornik</a>
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