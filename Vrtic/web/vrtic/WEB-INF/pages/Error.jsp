<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Error</title>
  </head>
  
  <body style="background-color: purple;">
  	<h1 style="color:white;">There has been an error! What did you do?!</h1>
  	<p style="color:white;">${userErrorMessage}</p>
  </body>
</html>