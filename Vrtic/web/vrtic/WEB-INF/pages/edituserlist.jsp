<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
  </head>
  <body>
    <c:choose>
      <c:when  test="${users != null && users.isEmpty() == false}">
        <p>Odaberite korisnika sa liste kojeg želite izmejniti.</p>
        <form method="post">
	      <select name="user">
            <c:forEach var="user" items="${users}">
              <option value="<c:out value="${user.id}" />">
                <c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /> <c:out value="${user.nick}" />
              </option>
            </c:forEach>
	      </select>

	      <input type="submit" name="method" value="Izmjeni podatke">
	      <input type="submit" name="method" value="Izmjeni lozinku">
	      
        </form>
        <p>Izmjenite grupe odgajatelja</p>
        <p>Odaberite odgajatelja sa liste kojem želite dodjeliti/izmejniti grupu</p>
        
        <c:choose>
          <c:when test="${educators.isEmpty() == false}">
            <form method="post">
              <select name="educator">
	            <c:forEach var="user" items="${educators}">
	              <option value="<c:out value="${user.id}" />">
	                <c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /> <c:out value="${user.nick}" />
	              </option>
	            </c:forEach>
	          </select>
	          
	          <p>Odaberite grupu</p>
	          
		      <select name="group"> 
				 <c:forEach var="group" items="${groups}">
					<option value="${group.id}">
					  <c:out value="${group.workplace.address}" />, <c:out value="${group.workplace.town}" /> 
					  <c:out value="${group.low}" />-<c:out value="${group.high}" />
					</option>
			     </c:forEach>
			  </select>
			  
	          <input type="submit" name="method" value="Izmjeni grupu">
	      
          </form>
          </c:when>
          <c:otherwise>
            <p>Trenutno nema odgajatelja u sustavu</p>
          </c:otherwise>
        </c:choose>
      </c:when>
      <c:otherwise>
        <p>Trenutno nema korisnika</p>
      </c:otherwise>
    </c:choose>    
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>
