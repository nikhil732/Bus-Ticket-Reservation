<%@ page import ="java.util.*,java.sql.*,java.io.*"%>
<%!String JDBC_DRIVER = "com.mysql.jdbc.Driver";%>
   <%!String DB_URL = "jdbc:mysql://localhost/bus_ticket";%>
   <%!String USER = "root";%>
   <%!String PASS = "password";%>
   <%!Connection con = null;%>
   <%
	 Statement stmt = null;
	 ResultSet rs=null;
	 PreparedStatement pstmt = null;
	   ResultSet rs1=null;
	   PreparedStatement pstmt1 = null;
	   ResultSet rs2=null;
	   String name=request.getParameter("name");
		 String password=request.getParameter("password");
		 int type=Integer.parseInt(request.getParameter("type"));
	//out.println(un + " " + pass + " " );
		try
		{
		  // Class.forName(JDBC_DRIVER);
		   con=DriverManager.getConnection(DB_URL,USER,PASS);
		   String sqlm="select max(id) from users";
		   pstmt1 = con.prepareStatement(sqlm);
		   PreparedStatement ps=con.prepareStatement("select id from users where un=? and pass=? and type=?");
		   ps.setString(1,name);
		   ps.setString(2,password);
		   ps.setInt(3,type);
		   rs=ps.executeQuery();
		    rs1=pstmt1.executeQuery();
		    int count=0;
		    if(rs1.next())
		    {
		    	count=rs1.getInt("max(id)");
		    }
		    count=count+1;
			if(rs.next())
			{
			int customer_id=rs.getInt("id");
			
			
				session.putValue("id",customer_id);
			}
				String insertTableSQL = "INSERT INTO users VALUES(?,?,?,?)";
				   pstmt = con.prepareStatement(insertTableSQL);
				pstmt.setInt(1, count);
					pstmt.setString(2,name );
					pstmt.setString(3, password);
					pstmt.setInt(4, type);
					pstmt.executeUpdate();
					out.println("<center><h1>Registered Successfully</center</h1>");
					//session.putValue("customer_id",count);
					response.sendRedirect("login.jsp");
			
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