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
<title>Confirm Booking</title>
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
   PreparedStatement pstmt2 = null;
   
		try
		{
		   Class.forName(JDBC_DRIVER);
		   con=DriverManager.getConnection(DB_URL,USER,PASS);
		   stmt=con.createStatement();
		  
		   String updateTableSQL = "UPDATE buses SET seats = ? WHERE id = ?;";
		   
		   pstmt = con.prepareStatement(updateTableSQL);
		  
		   int su = (Integer)session.getAttribute("SeatsU");
		   int sd = (Integer)session.getAttribute("SeatsD");
		   int id = (Integer)session.getAttribute("Bus_ID");
		   
		   
		 
		   pstmt.setInt(1, sd-su);
		   pstmt.setInt(2, id);
		   pstmt.executeUpdate();
		   
		   String insertintohistory = "INSERT into history (usr,bid,date,bf,bt,seats,fare) VALUES (?,?,?,?,?,?,?)";
		   pstmt2 = con.prepareStatement(insertintohistory);
		   
			
			pstmt2.setString(1, session.getAttribute("Name").toString());
			pstmt2.setInt(2, (Integer)session.getAttribute("Bus_ID"));
			pstmt2.setString(3, session.getAttribute("Date").toString());
			pstmt2.setString(4, session.getAttribute("bus_fr").toString());
			pstmt2.setString(5, session.getAttribute("bus_to").toString());
			pstmt2.setInt(6, (Integer)session.getAttribute("SeatsU"));
			pstmt2.setInt(7, (Integer)session.getAttribute("Total"));
			pstmt2.executeUpdate();
		   out.println("<center><h2>" + "Bus Booked Successfully...." + "</h2></center>");
		   out.println("<center><h3>" + "Booking Details:" + "</h3>" + "From : " + session.getAttribute("bus_fr").toString() + "<br>" + "To : " + session.getAttribute("bus_to").toString() + "<br>" + "Date : " + session.getAttribute("Date").toString() + "<br>Fare : " + session.getAttribute("Total") + "</center><br><br>");
		   %>
		   
		   <center><form action="welcome.jsp">
					<input type="submit" value="Go Back"/>
					</form></center>
		<%   
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
   %>
   </body>
   </html>