<%@ page import ="java.util.*,java.sql.*,java.io.*"%>
<%!String JDBC_DRIVER = "com.mysql.jdbc.Driver";%>
   <%!String DB_URL = "jdbc:mysql://localhost/bus_ticket";%>
   <%!String USER = "root";%>
   <%!String PASS = "password";%>
   <%!Connection con = null;%>
   <%
	 Statement stmt = null;
	 ResultSet rs=null;
	 String un=request.getParameter("usr");
	 String pass=request.getParameter("pwd");
	 int ty=Integer.parseInt(request.getParameter("type"));
	//out.println(un + " " + pass + " " + ty);
		try
		{
		  // Class.forName(JDBC_DRIVER);
		   con=DriverManager.getConnection(DB_URL,USER,PASS);
		   stmt=con.createStatement();
		   //out.println(1);
		   String sql="SELECT * FROM `users` where `un` = '"+ un +"' and `pass` = '" + pass + "' and `type` = " + ty;
		    rs=stmt.executeQuery(sql);
		    
			if(rs.next())
			{
			String name=rs.getString("un");
			String password=rs.getString("pass");
			int type=rs.getInt("type");//0-user,1-admin
				session.putValue("Name",name);
				session.putValue("Type",type);
				if(type==0)
					response.sendRedirect("welcome.jsp");
				else
					response.sendRedirect("admin.jsp");
			
			}
			else
				out.println("Invalid Entry");
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