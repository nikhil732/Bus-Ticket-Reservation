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
	 Statement stmt = null;
	 ResultSet rs=null;
	 String bus_from=request.getParameter("bus_from");
	 String bus_to=request.getParameter("bus_to");
	 int sfu=Integer.parseInt(request.getParameter("seats"));
	 String date=request.getParameter("date");
	 //out.println(bus_from + " " + bus_to);
		try
		{
		   Class.forName(JDBC_DRIVER);
		   con=DriverManager.getConnection(DB_URL,USER,PASS);
		   stmt=con.createStatement();
		   
		   String sql="SELECT * FROM `buses` where `busfrom` = '"+ bus_from +"' and `busto` = '"+ bus_to + "'";
		    rs=stmt.executeQuery(sql);
		   
			if(rs.next())
			{
			String bf=rs.getString("busfrom");
			String bt=rs.getString("busto");
			int sfd=rs.getInt("seats");
			int fare=rs.getInt("fare");
			int id1=rs.getInt("id");
			
			
				if(sfd>=sfu){
					int total = sfu*fare;
					
					out.println("<center><h1>Your Total fare will be : " + total + "</h1></center>" );
					out.println("<center><h2>" + "Review Details:" + "</h2>"+"<h3>" + "From : " + bf + "<br>" + "To : " + bt + "<br>" + "Date : " + date + "<br>Fare : " + total + "</center>"+"</h3");
					session.putValue("Bus_ID",id1);
					session.putValue("SeatsU",sfu);
					session.putValue("bus_fr",bus_from);
					session.putValue("bus_to",bus_to);
					session.putValue("SeatsD",sfd);
					session.putValue("Date",date);
					session.putValue("Total",total);
					%>
					<br><br>
				<center><form action="update.jsp">
				<input type="submit" value="Confirm"/>
				</form>	<br><br>
				<form action="welcome.jsp">
					<input type="submit" value="Go Back"/>
					</form></center>
			<% 	}
				else{
					out.println("<center><h1>" + "Sorry.. You can not Book, as Only" + sfd + " are Available" + "</h1></center>");
					%>
					<center>><form action="welcome.jsp">
					<input type="submit" value="Go Back"/>
					</form></center>
			<%	
				}
			//out.println(bf + " " + bt + " " + seats + " " + fare);
			}
			else{
				out.println("<center><h1>Bus Not Available for this route</h1></center>");
				%>
				<center>><form action="welcome.jsp">
				<input type="submit" value="Go Back">
				</form></center>
		<%	
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
			rs.close();
			stmt.close();
			con.close();
			}catch(Exception e){}
		}
   %>
   	    
</body>
</html>