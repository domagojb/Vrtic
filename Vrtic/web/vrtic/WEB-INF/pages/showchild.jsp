<%@page import="hr.fer.zemris.opp.model.users.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title> "Tulipan" </title>
  </head>
  <body>
   	
   	<p>Ispis djeteta</p>
   	
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
   	
   	<p>Informacije o roditelju</p>
   	
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
   	
   	<p>Tablica uplata</p>
   	
   	<!-- Form for year selection -->
   	<p>Odaberite godinu za koju želite ispis uplata i dolazaka</p>
   	<form>
   	  <input type="hidden" name="id" value="${child.id}">
   	  <select name="paymentyear">
   	    <c:forEach var="year" items="${years}">
   	      <option value="${year}">${year}</option>
   	    </c:forEach>
   	  </select>
   	  <input type="submit" value="Odaberi">
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
    
    
   	
	<a href="${pageContext.servletContext.contextPath}/userpanel/findchild">Povratak na prethodnu stranicu</a>
  	<a href="${pageContext.servletContext.contextPath}/userpanel">Povratak na izbornik</a>
  	
  </body>
</html>