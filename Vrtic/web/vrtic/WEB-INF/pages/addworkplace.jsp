<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
    
    <!-- Dynamic form adding -->
    <script>
	  function createGroupForm()
	  {
	     var table = document.getElementById('formTable');
	     var newGroupAge = document.createElement('input');
	     newGroupAge.type = "text";
	     newGroupAge.name = "group[]";
	     newGroupAge.size = "40";
	     newGroupAge.placeholder = "format: X-Y where x is the lowest age and y is the highest age";
	      
	     var tr = document.createElement('tr');
	     var td1 = document.createElement('td');
	     var td2 = document.createElement('td');
	    
	     td1.innerHTML = "Dobna skupina";
	    
	     td2.appendChild(newGroupAge);
	      
	     tr.appendChild(td1);
	     tr.appendChild(td2);
	     table.appendChild(tr);
	     
	     var newGroupAge = document.createElement('select');
	     newGroupAge.type = "text";
	     newGroupAge.name = "group[]";
	     newGroupAge.size = "40";
	     
	     var td1 = document.createElement('td');
	     var td2 = document.createElement('td');
	     
	     td1.innerHTML = "Odgajatelji";
		    
	     td2.appendChild(newGroupAge);
	      
	     tr.appendChild(td1);
	     tr.appendChild(td2);
	     table.appendChild(tr);
	     
	  }
    </script>
  </head>
  <body>
    <p>Dodaj novi objekt vrtića:</p>
    
    <form id="workplaceForm" method="post">
    <table id="formTable">
		 <tr><td>Adresa</td><td> <input type="text" name="address" value='<c:out value="${form.address}" />' size ="40">
		     <c:if test="${form.hasError('address')}">
		         <div class="greska"><c:out value="${form.getError('address')}" /></div>
		     </c:if></td>
		 </tr>
		 <tr><td>Grad</td><td> <input type="text" name="town" value='<c:out value="${form.town}" />' size ="40">
		     <c:if test="${form.hasError('town')}">
		         <div class="greska"><c:out value="${form.getError('town')}" /></div>
		     </c:if></td>
		 </tr>
		 
	</table>
	 	 <p>
	 	   <input type="submit" name="metoda" value="Spremi">
	 	 </p>
    </form>
        
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>