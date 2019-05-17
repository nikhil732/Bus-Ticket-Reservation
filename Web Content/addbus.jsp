<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
body{
	background:linear-gradient(to right,red,blue);
	height: 100%;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>KBS</title>
</head>
<body>
<%@ page import ="java.util.*,java.sql.*,java.io.*"%>
<%!String JDBC_DRIVER = "com.mysql.jdbc.Driver";%>
   <%!String DB_URL = "jdbc:mysql://localhost/bus_ticket";%>
   <%!String USER = "root";%>
   <%!String PASS = "password";%>
   <%!Connection con = null;%>
   <%
   Statement stmt=null;
   PreparedStatement pstmt = null;
   ResultSet rs=null;
		try
		{
		   Class.forName(JDBC_DRIVER);
		   con=DriverManager.getConnection(DB_URL,USER,PASS);
		   stmt=con.createStatement();
		  // System.out.println("\nAdding Data into the tables!!\n");
		   String insertTableSQL = "INSERT INTO buses (id,busfrom,busto,fare,seats) VALUES(?,?,?,?,?)";
		   pstmt = con.prepareStatement(insertTableSQL);
		
			pstmt.setInt(1, Integer.parseInt(request.getParameter("busid")));
			pstmt.setString(2, request.getParameter("from"));
			pstmt.setString(3, request.getParameter("to"));
			pstmt.setInt(5, Integer.parseInt(request.getParameter("seats")));
			pstmt.setInt(4, Integer.parseInt(request.getParameter("fare")));
			pstmt.executeUpdate();
			out.println("<center><h1>Bus Added Successfully</center</h1>");
			 
		}catch(Exception e)
		{
			//e.printStackTrace();
			out.println(e);
		}
		finally
		{
			try{
			stmt.close();
			pstmt.close();
			con.close();
			}catch(Exception e)
			{
				//e.printStackTrace();
				out.println(e);
			}
		}
   %><center>
   <br><h1><a href="admin.jsp">Continue</a></h1></center>