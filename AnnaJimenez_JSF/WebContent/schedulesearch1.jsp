<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ include file="username1.jsp"%>
     <%@ page import="java.sql.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<% 
	String crscode = request.getParameter("value");
	System.out.println(crscode);
	
	String semester = request.getParameter("semester");
	System.out.println(semester);

	
	Connection conn = null;
	try {
		// 1. Load the driver
		Class.forName(driver);

		
		// 3. Establish the connection
		conn = DriverManager.getConnection(url, myusername, mypassword);

		
		PreparedStatement pstmt = conn
				.prepareStatement("SELECT DISTINCT  CRS_SEC_SR.SEMESTER, CRS_SEC_SR.DISC, CRS_SEC_SR.CRS_NUM,COURSE_SR.TITLE, CRS_SEC_SR.CRS_CD, CRS_SEC_SR.CRS_SEC, DEPT_SR.DEPT_NAME,COURSE_SR.LEVEL_DIV,CRS_SEC_SR.MEETING_DAYS, CRS_SEC_SR.START_TIME, CRS_SEC_SR.STOP_TIME, CRS_SEC_SR.AM_PM, CRS_SEC_SR.START_DATE, CRS_SEC_SR.END_DATE  , CRS_SEC_SR.BUILDING, CRS_SEC_SR.RM, CRS_SEC_SR.INSTRUCTOR_LNAME, CRS_SEC_SR.SEATS_AVAIL,CRS_SEC_SR.MEETING_DAYS, COURSE_SR.CREDITHOUR, CRS_COMMENTS_SR.CRS_COMMENTS1, COURSE_SR.PREREQ FROM ( ( ( CRS_SEC_SR INNER JOIN CRS_COMMENTS_SR ON CRS_SEC_SR.CRS_CD=CRS_COMMENTS_SR.CRS_CD) INNER JOIN COURSE_SR ON COURSE_SR.DISCIPLINE = CRS_SEC_SR.DISC AND COURSE_SR.COURSENUMBER = CRS_SEC_SR.CRS_NUM) INNER join DISCIPLINE_SR ON CRS_SEC_SR.DISC=DISCIPLINE_SR.DISC_ABBREVIATION) INNER join DEPT_SR on DISCIPLINE_SR.DEPT_ID=DEPT_SR.DEPT_ID WHERE CRS_SEC_SR.CRS_CD = ? AND CRS_SEC_SR.SEMESTER = ?");

		pstmt.setString(1, String.valueOf(crscode));
		pstmt.setString(2, String.valueOf(semester));
		
		ResultSet rs3 = pstmt.executeQuery();
		
		System.out.println("query execute");
		
		while (rs3.next()){
			System.out.println("in rs.nxt");
		}
		
		//String queryDetails = "SELECT DISTINCT  CRS_SEC_SR.SEMESTER, CRS_SEC_SR.DISC, CRS_SEC_SR.CRS_NUM,COURSE_SR.TITLE, CRS_SEC_SR.CRS_CD, CRS_SEC_SR.CRS_SEC, DEPT_SR.DEPT_NAME,COURSE_SR.LEVEL_DIV,CRS_SEC_SR.MEETING_DAYS, CRS_SEC_SR.START_TIME, CRS_SEC_SR.STOP_TIME, CRS_SEC_SR.AM_PM, CRS_SEC_SR.START_DATE, CRS_SEC_SR.END_DATE  , CRS_SEC_SR.BUILDING, CRS_SEC_SR.RM, CRS_SEC_SR.INSTRUCTOR_LNAME, CRS_SEC_SR.SEATS_AVAIL,CRS_SEC_SR.MEETING_DAYS, COURSE_SR.CREDITHOUR, CRS_COMMENTS_SR.CRS_COMMENTS1, COURSE_SR.PREREQ FROM ( ( ( CRS_SEC_SR INNER JOIN CRS_COMMENTS_SR ON CRS_SEC_SR.CRS_CD=CRS_COMMENTS_SR.CRS_CD) INNER JOIN COURSE_SR ON COURSE_SR.DISCIPLINE = CRS_SEC_SR.DISC AND COURSE_SR.COURSENUMBER = CRS_SEC_SR.CRS_NUM) INNER join DISCIPLINE_SR ON CRS_SEC_SR.DISC=DISCIPLINE_SR.DISC_ABBREVIATION) INNER join DEPT_SR on DISCIPLINE_SR.DEPT_ID=DEPT_SR.DEPT_ID";
		
		//queryDetails = queryDetails + " WHERE CRS_SEC_SR.CRS_CD = '" + crscode + "'";
		
		//queryDetails = queryDetails + " AND CRS_SEC_SR.SEMESTER = '" + semester + "'";
	
		//Statement stmt = conn.createStatement();

	//	ResultSet rs = stmt.executeQuery(queryDetails);

		
		
		// 6. Process result
		//column names from database
	//	while (rs.next()) {
	//		System.out.println("in rs.nxt");
			
			
	//	}

		

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


</body>
</html>