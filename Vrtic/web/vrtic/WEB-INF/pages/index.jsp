<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
  </head>
  <body>
  	<c:choose>
      <c:when test="${sessionScope['current.user.id'] != null}">
        <p>Trenutno ste ulogirani kao ${sessionScope['current.user.fn']} ${sessionScope['current.user.ln']} <a href="logout">Logout</a></p>
        <c:choose>
          <c:when test="${sessionScope['current.user.t'] == 'adm'}">
            <a href="${pageContext.servletContext.contextPath}/userpanel">Administrativni panel</a>
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
	    <table>
	      <tr><td>Korisničko ime</td><td> <input type="text" name="username"  size ="40"></td></tr>
		  <tr><td>Zaporka</td><td> <input type="password" name="password"  size ="40"></td></tr>
		  <tr><td colspan="2"><c:if test="${loginError != null}">
		                          <div class="greska"><c:out value="${loginError}" /></div>
		                      </c:if></td></tr>
		  <tr><td></td><td><input type="submit" name="loginMethod" value="Login"></td></tr>
		 </table>
	    </form>
	    <!-- End login form -->
      </c:otherwise>
    </c:choose>
      
    
  </body>
</html>