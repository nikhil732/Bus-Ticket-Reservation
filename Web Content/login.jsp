<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html ">
<html>
<head><title>Login</title></head>
<style>

body{
	background:linear-gradient(to right,red,orange,yellow,green,blue,indigo,violet);
	height: 100%;
}
</style>
<body>
	<br><br>
	<center><h1>WELCOME TO NIKHIL BUS RESERVATION SERVICE</h1></center>
	<center><image src="bus.jpg" alt="BUS Logo" width="800" height="400"></image></center>
	<center><h2>Login</h2>
	<% 
	if(session.getAttribute("Type")==null);
	else if(session.getAttribute("Type").equals(0))
		response.sendRedirect("welcome.jsp");
	else if(session.getAttribute("Type").equals(1))
		response.sendRedirect("admin.jsp");
	%>
	<form action="process.jsp" method="post">
	Username  <input type="text" name="usr"/><br><br>
	Password  <input type="password" name="pwd"/><br><br>
	Admin  <input type="radio" style="width:20px; height:20px;" value="1" name="type"/>
	User  <input type="radio" style="width:20px; height:20px;" value="0" name="type"/><br><br>
	<input type="submit" value="Login"/></form><br>
	New User???
	<form action="signup.jsp" method="post">
	<input type="submit" value="Sign Up"/></form></center>
</body>
</html>