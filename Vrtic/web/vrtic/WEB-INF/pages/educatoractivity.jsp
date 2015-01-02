<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Tulipan</title>
    
    <!-- Setting gate to todays date -->
    <script type="text/javascript">
      document.getElementById('datePicker').valueAsDate = new Date();
    </script>
    
  </head>
  <body>
   
    <form method="post">
      <input type="hidden" name="uid" value="${uid}">
      <table>
        <tr><td>Datum</td><td><input id="datePicker" type="date" name="date">
   	    <c:if test="${form.hasError('date')}">
          <div class="greska"><c:out value="${form.getError('date')}" /></div>
        </c:if></td>
 		</tr>
        <tr><td colspan="2"><b>Efektivni rad u grupi</b></td></tr>
        <tr><td>Utrošeno vrijeme</td>
            <td><input name="ew_h" type="number" min="0" value="0" size="4"> minuta
        </td>
        </tr>
        <tr><td>Opis rada</td><td><textarea name="ew" cols="50" rows="5"></textarea></td></tr>
        
        <tr><td colspan="2"><b>Priprema za rad</b></td></tr>
        <tr><td>Utrošeno vrijeme</td>
            <td><input name="wp_h" type="number" min="0" value="0" size="4"> minuta
        </td>
        </tr>
        <tr><td>Opis rada</td><td><textarea name="wp" cols="50" rows="5"></textarea></td></tr>
        
         <tr><td colspan="2"><b>Stručno usavršavanje</b></td></tr>
        <tr><td>Utrošeno vrijeme</td>
            <td><input name="spec_h" type="number" min="0" value="0" size="4"> minuta
        </td>
        </tr>
        <tr><td>Opis rada</td><td><textarea name="spec" cols="50" rows="5"></textarea></td></tr>
        
        <tr><td colspan="2"><b>Suradnja s roditeljima</b></td></tr>
        <tr><td>Utrošeno vrijeme</td>
            <td><input name="pw_h" type="number" min="0" value="0" size="4"> minuta
        </td>
        </tr>
        <tr><td>Opis rada</td><td><textarea name="pw" cols="50" rows="5"></textarea></td></tr>

	   <tr><td></td><td>
	     <input type="submit" name="metoda"	value="Upiši">
	     </td>
	   </tr>
     </table>
   </form>
      
    <a href="${pageContext.servletContext.contextPath}/userpanel">Vrati se na izbornik</a>
  </body>
</html>
