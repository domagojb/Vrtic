<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Vrtic buducnosti</title>
  </head>
  <body>
    <p>Članovi grupe dboppg:</p>
    <ol>
    	<!--  jednostava foreach petlja kojom mogu prolaziti kroz liste :)
    	svaki prolaz stavit ce jedan element u var korisnik -->
		<c:forEach var="korisnik" items="${korisnici}">
			<!--  jsp ocekuje da su razredi kojima zelimo dohvatiti atribute
			napisani po java beans standardu (imaju get i set metode koje sadrze 
			nazive atributa. npr za String ime postoji getIme();;;;
			on to onda interno parsisra i prevodi u java kod i izvrsi -->
			<li>${korisnik.ime} ${korisnik.prezime}</li>		
		</c:forEach>
		<!--  unutar jspa moguce je i direktno pisati java kod (isto ko i php)
		al je to nepreporucljivo jer postoje ovi jednostavni htmlu slicni tagovi
		ko sto je foreach -->
    </ol>
  </body>
</html>