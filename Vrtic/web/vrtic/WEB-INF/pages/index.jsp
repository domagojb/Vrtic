<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>"Tulipan"</title>
    
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
		  <tr><td></td><td><input type="submit" name="method" value="Log in"></td></tr>
		 </table>
	    </form>
	    <!-- End login form -->
      </c:otherwise>
    </c:choose>
      
    <c:if test="${confirmationMsg != null }">
      <p>${confirmationMsg}</p>
    </c:if>
      
    <c:choose>
      <c:when test="${signUpOpen == true}">
	    <form method="post">
	      <table>
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
	    	 	
	       <tr><td></td><td><input type="button" value="Dodaj grupu" onclick="add()"> <input type="button" value="Makni grupu" onclick="removeGroup()"></td></tr>
	       
	    	 <tr><td colspan="2">Upišite podatke roditelja ili skrbnika</td></tr>
			 <tr><td>Ime</td><td> <input type="text" name="firstname" value='<c:out value="${form.pFirstName}" />' size ="40">
			     <c:if test="${form.hasError('firstname')}">
			         <div class="greska"><c:out value="${form.getError('firstname')}" /></div>
			     </c:if></td>
			 </tr>
			     
			 <tr><td>Prezime</td><td> <input type="text" name="lastname" value='<c:out value="${form.pLastName}" />' size ="40">
			     <c:if test="${form.hasError('lastname')}">
			         <div class="greska"><c:out value="${form.getError('lastname')}" /></div>
			     </c:if></td>
			 </tr>
			 
			 <tr><td>OIB</td><td> <input type="text" name="oib" value='<c:out value="${form.pOIB}" />' size ="40">
			     <c:if test="${form.hasError('oib')}">
			         <div class="greska"><c:out value="${form.getError('oib')}" /></div>
			     </c:if></td>
			 </tr>
			     
			 <tr><td>Adresa</td><td> <input type="text" name="address" value='<c:out value="${form.address}" />' size ="40">
			     <c:if test="${form.hasError('address')}">
			         <div class="greska"><c:out value="${form.getError('address')}" /></div>
			     </c:if></td>
			 </tr>    
			
			 <tr><td>Telefon</td><td> <input type="text" name="phone" value='<c:out value="${form.phone}" />' size ="40">
			     <c:if test="${form.hasError('phone')}">
			         <div class="greska"><c:out value="${form.getError('phone')}" /></div>
			     </c:if></td>
			 </tr>
			 
			 <tr><td colspan="2">Ako se potražuje pravo na temelju socijalnog statusa</td></tr>
			 <tr><td colspan="2"><input type="checkbox" name="socialstatus" value="1">Označiti ako se traži</td></tr>
			 <tr><td>Primanja (mjesečna)</td><td> <input type="text" name="income" value='<c:out value="${form.income}" />' size ="40">HRK
			     <c:if test="${form.hasError('income')}">
			         <div class="greska"><c:out value="${form.getError('income')}" /></div>
			     </c:if></td>
			 </tr>
			
			 <tr><td colspan="2">Podaci o djetetu</td></tr>
			 <tr><td>Ime</td><td> <input type="text" name="c_firstname" value='<c:out value="${form.cFirstName}" />' size ="40">
			     <c:if test="${form.hasError('c_firstname')}">
			         <div class="greska"><c:out value="${form.getError('c_firstname')}" /></div>
			     </c:if></td>
			 </tr>
			     
			 <tr><td>Prezime</td><td> <input type="text" name="c_lastname" value='<c:out value="${form.cLastName}" />' size ="40">
			     <c:if test="${form.hasError('c_lastname')}">
			         <div class="greska"><c:out value="${form.getError('c_lastname')}" /></div>
			     </c:if></td>
			 </tr>
			 
			 <tr><td>OIB</td><td> <input type="text" name="c_oib" value='<c:out value="${form.cOIB}" />' size ="40">
			     <c:if test="${form.hasError('c_oib')}">
			         <div class="greska"><c:out value="${form.getError('c_oib')}" /></div>
			     </c:if></td>
			 </tr>
			 
			 <tr><td>Spol</td><td><select name="sex"> 
		        				  <option value="m">M</option>
		        				  <option value="f">F</option>
	    	 					 </select>
	    	 					 
	    	 	 </td></tr>
			 <tr><td>Datum rođenja</td><td><input type="date" name="birthdate">
			     <c:if test="${form.hasError('bday')}">
			         <div class="greska"><c:out value="${form.getError('bday')}" /></div>
			     </c:if></td>
			 </tr>
			
			 <tr><td></td><td>
			     <input type="submit" name="method"	value="Upis">
			     </td>
			 </tr>
		  </table>
	    </form>
      </c:when>
      <c:otherwise>
        <p>Upisi u vrtić trenutno nisu otvoreni</p>
      </c:otherwise>
    </c:choose>
    
  </body>
</html>