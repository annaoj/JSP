<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="username1.jsp" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<BODY BGCOLOR="white">
<%
//Check for cookie to track session 
String userName = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
	System.out.println("COOKIES NOT NULL");
for(Cookie cookie : cookies){
    if(cookie.getName().equals("userId")){
    	
    	// Check for cookie to track session 
    	userName = cookie.getValue();
    
    // check for developer to keep track through console
    System.out.println("INSIDE COOKIE TEST");
    System.out.println(userName);
    }
}
}
//Check if value of cookie is null
//If null then there is no active session 
//If there is no active session user has not logged in and should not have access to data
if(userName == null) response.sendRedirect("index.html");
%>
<H1>Welcome to Update Baruch Course Schedule</H1>
<H2>Please use YYYY-MM-DD Date format!!</H2>
<br>

 <form action="display.jsp" method="POST">
				<label>Semester:</label> 
				<select name="semester" required>
					<option selected disabled>Semester Select</option>
					<!--  Below code provides the user with -->
					<!--  options from database for semester -->
					<%
					Connection conn = null;
					   try
					   {					      	

						   	// 1. Load the driver
							Class.forName(driver);

						   	// 2. Define the connection URL

							// 3. Establish the connection
							conn = DriverManager.getConnection(url, myusername,mypassword);
						
					      	// 4. Create a statement object
					     	Statement stmt = conn.createStatement();

					      	// 5. Execute a query
							ResultSet rs = stmt.executeQuery("SELECT SEMESTER_ID, START_DATE, END_DATE, SEMESTER_NAME, SEMESTER FROM SEMESTER_SR");
					      	
		      

					      // 6. Process result

					      while(rs.next())
					      {
						      out.println("<option value =\""+rs.getString("SEMESTER_ID")+"\">"+rs.getString("SEMESTER_NAME")+"</option>");
						      
					      }

					   }
					   catch(SQLException e)
					   {
					      // Do exception catch such as if connection is not made or 
					      // query is not set up properly
					      out.println("SQLException: " + e.getMessage() + "<BR>");
					      while((e = e.getNextException()) != null)
					         out.println(e.getMessage() + "<BR>");
					   }
					   catch(ClassNotFoundException e)
					   {
					      out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
					   }
					   finally
					   {
					// 7. Close connection; Clean up resources
					      if(conn != null)
					      {
					         try
					         {
					            conn.close();
					         }
					         catch (Exception ignored) {}
					      }
					   }
					   %>
						</select> <br/> <br/> 
						
						<label>Start Date:</label> 
						<input type="date" name="startDate" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required /> <br /> <br /> 
						<label>End Date:</label> 
						<input type="date" name="endDate" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required /> <br /> <br />
						<input id="updateschedule" type="submit" value="Update Schedule" />
					</form>

<!--  Button to log the user out  -->
<form action="LogOutServ" method="post">
<input type="submit" value="Logout" >
</form>
  
  
  
  
  
 

</body>
</html>