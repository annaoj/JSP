<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ include file="username1.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
// Check for cookie to track session 
String userName = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
	System.out.println("COOKIES NOT NULL");
	
	for(Cookie cookie : cookies){
    	if(cookie.getName().equals("userId")){
    	
    	// get value of cookie 
    	userName = cookie.getValue();
    	
    // check for developer to keep track through console
    System.out.println("INSIDE COOKIE TEST");
    System.out.println(userName);
    }
}
}
// Check if value of cookie is null
// If null then there is no active session 
// If there is no active session user has not logged in and should not have access to data
if(userName == null) response.sendRedirect("index.html");
%>
<center>
<h1>You have successfully updated the semester schedule</h1>
</center>

<%
				// get user input from update page
				String semester = request.getParameter("semester");
				String startDate = request.getParameter("startDate");
				String endDate = request.getParameter("endDate");

				Connection conn = null;
				try {
					// 1. Load the driver
					Class.forName(driver);

					
					// 3. Establish the connection
					conn = DriverManager.getConnection(url, myusername, mypassword);

					// 4. Create a statement object
					PreparedStatement pstmt = conn
							.prepareStatement("UPDATE SEMESTER_SR SET START_DATE=?, END_DATE=? WHERE SEMESTER_ID=?");

					pstmt.setDate(1, Date.valueOf(startDate));
					pstmt.setDate(2, Date.valueOf(endDate));
					pstmt.setInt(3, Integer.valueOf(semester));

					// 5. Execute a query
					pstmt.executeUpdate();

					Statement stmt = conn.createStatement();

					ResultSet rs = stmt.executeQuery("SELECT * FROM SEMESTER_SR");

					//Print start of table and column headers
					out.println("<TABLE CELLSPACING=\"0\" CELLPADDING=\"3\" BORDER=\"1\">");
					out.println("<TR><TH>SemesterID</TH><TH>Start date</TH><TH>End date</TH><TH>Semester name</TH></TR>");

					// 6. Process result
					//column names from database
					while (rs.next()) {
						out.println("<TR>");
						out.println("<TD>" + rs.getString("SEMESTER_ID")
								+ "</TD>");
						out.println("<TD>" + rs.getString("START_DATE")
								+ "</TD>");
						out.println("<TD>" + rs.getString("END_DATE") + "</TD>");
						out.println("<TD>" + rs.getString("SEMESTER_NAME") + "</TD>");

						out.println("</TR>");
					}

					out.println("</TABLE>");

				} catch (SQLException e) {
					
					out.println("SQLException: " + e.getMessage() + "<BR>");
					while ((e = e.getNextException()) != null)
						out.println(e.getMessage() + "<BR>");
				} catch (ClassNotFoundException e) {
					out.println("ClassNotFoundException: " + e.getMessage()
							+ "<BR>");
				} finally {
					// 7. Close connection; Clean up resources
					if (conn != null) {
						try {
							conn.commit();
							conn.close();
						} catch (Exception ignored) {
						}
					}
				}
			%>

<!--  Button to log the user out  -->
<form action="LogOutServ" method="post">
<input type="submit" value="Logout" >
</form>

<!--  button to return user to update page -->
<!--  This allows user to make multiple updates in one session -->
<form action="update.jsp" method="post">
<input type="submit" value="Back to Update" >
</form>

</body>
</html>