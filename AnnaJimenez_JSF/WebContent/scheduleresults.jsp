<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ include file="username1.jsp"%>


<html>
<head>
<title>Baruch College</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link REL="icon" href="http://www.baruch.cuny.edu/favicon.ico">
<link rel="stylesheet" type="text/css" href="http://www.baruch.cuny.edu/css/baruch_interior.css" />
<link rel="stylesheet" type="text/css" href="http://www.baruch.cuny.edu/css/application.css" />
<link href="schedule.css" rel="stylesheet" type="text/css" />
<!--HEAD Include Ends -->

<title>ScheduleResults</title>
</head>

<body>
<!-- wrapper -->
<div id="wrapper">
<!-- banner -->
<div id="banner"><a href="http://www.baruch.cuny.edu"><img src="http://www.baruch.cuny.edu/images/logo_baruch.gif" alt="Baruch College" name="logo" width="201" height="68" border="0" id="logo" /></a></div>
<!-- /banner -->
<div id="main">


<!--BODY Include ENDS -->

<%  // Get values from HTML Form

	String semester = request.getParameter("semester");
	String discipline = request.getParameter("discipline");
	String department = request.getParameter("department");
	String undergraduate = request.getParameter("div_undr");
	String graduate = request.getParameter("div_grad");
	String number = request.getParameter("number");
	String week = request.getParameter("week");
	String time_a_b = request.getParameter("time_a_b");
	String time = request.getParameter("time");
	String prof = request.getParameter("prof");
	
	
	/*if ( semester.equals("")||(graduate== null && undergraduate == null) || (number.length() == 0) || week.equals("")||time_a_b.equals("")|| time.equals("")|| prof.equals("")){ 
		response.sendRedirect ("http://localhost:8082/Karamanolev_Toma/schedulesearcherror.html");
		
	return;
	}*/
	
/*	if ((graduate== null && undergraduate == null) || (number.length() == 0) || week.equals("")||time_a_b.equals("")|| time.equals("")|| prof.equals("")){ 
		while ( semester != null){
		
			response.sendRedirect ("http://localhost:8082/AnnaJimenez_JSF/schedulesearcherror.html");
		
	return;}
	}*/
	
	
	
	
	
	String semesterLower = semester.toLowerCase();
	System.out.println(semester);
	System.out.println(semesterLower);
	
	System.out.println(discipline);
	
	System.out.println(number);
	System.out.println(week);
	System.out.println(week);
	System.out.println(week);
	System.out.println(time_a_b);
	System.out.println(time);
	
	String profUpper = prof.toUpperCase();
	System.out.println(profUpper);
	
	
	out.println("<p>Search results are based on the following keywords:</p>");
	out.println("<table id=\"criteria\" summary=\"This table contains the search criteria. Results are listed in next table.\">");
	out.println("<tr> <td><strong>Semester</strong>: " + semester + "</td><td><strong>Days</strong>:" + week + "</td></tr>");
	out.println("<tr><td><strong>Department</strong>: " + department + "</td><td><strong>Time</strong>: " + time_a_b + " " + time + "</td></tr>");
	out.println("<tr><td><strong>Discipline</strong>: " + discipline + "</td> <td><strong>Course number</strong>: " + number + "</td></tr>");
	out.println("<tr><td><strong>Division</strong>: " + undergraduate + " " + graduate + "</td><td><strong>Instructor</strong>: " + prof + "</td></tr> </table>");
	//out.println("</div>");
	
	
	
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
			if (semester.equals("Summer ALL") ||  semester.equals("Summer00") || semester.equals("Summer01") || semester.equals("Summer02")){
				ResultSet rs = stmt.executeQuery("SELECT UPDATE_TIME FROM UPDATE_TIME_SR WHERE SEMESTER = 'summer' ");
				while(rs.next())
			      {
				      out.println("<font color=\"red\"> <p><b>The schedule was LAST&nbsp; updated at " + rs.getString("UPDATE_TIME") + "</b></p>");
				      
			      }
			} else if (semester.equals("January Intersession") || (semester.equals("Fall"))){
				ResultSet rs = stmt.executeQuery("SELECT UPDATE_TIME FROM UPDATE_TIME_SR WHERE SEMESTER = 'fall' ");
				while(rs.next())
			      {
				      out.println("<font color=\"red\"> <p><b>The schedule was LAST&nbsp; updated at " + rs.getString("UPDATE_TIME") + "</b></p>");
				      
			      }
			} else {
				ResultSet rs = stmt.executeQuery("SELECT UPDATE_TIME FROM UPDATE_TIME_SR WHERE SEMESTER = 'spring' ");
				while(rs.next())
			      {
				      out.println("<font color=\"red\"> <p><b>The schedule was LAST&nbsp; updated at " + rs.getString("UPDATE_TIME") + "</b></p>");
				      
			      }
			}
		  
			
	      	
	      	//set up table header
	      	out.println("<p>Due to the dynamic nature of the registration process, not all courses listed as open will have space for new registrants.</p></font></div>");
	      	out.println("<div id=\"main\">");
	      	out.println("<table id=\"results\" summary=\"This table contains the search results for schedule of classes.\"><caption>Schedule of Classes Search Results</caption>");
	      	out.println("<thead><tr><th scope=\"col\">Course</th><th scope=\"col\">Code</th><th scope=\"col\">Section</th><th scope=\"col\">Day &amp; Time </th><th scope=\"col\">Dates</th><th scope=\"col\">Bldg &amp; Rm </th><th scope=\"col\">Instructor</th><th scope=\"col\">Seats Avail </th><th scope=\"col\">Comments</th></tr></thead>");
	      	//open table body
	      	out.println("<tbody>");		
	      			
	      	
	  	    // Result querry setup
	      	String query2 = "SELECT DISTINCT CRS_SEC_SR.DISC, CRS_SEC_SR.CRS_NUM, CRS_SEC_SR.CRS_CD, CRS_SEC_SR.CRS_SEC, CRS_SEC_SR.MEETING_DAYS, CRS_SEC_SR.START_TIME, CRS_SEC_SR.STOP_TIME, CRS_SEC_SR.AM_PM, CRS_SEC_SR.START_DATE, CRS_SEC_SR.END_DATE  , CRS_SEC_SR.BUILDING, CRS_SEC_SR.RM, CRS_SEC_SR.INSTRUCTOR_LNAME, CRS_SEC_SR.SEATS_AVAIL, CRS_COMMENTS_SR.CRS_COMMENTS1 FROM ( ( CRS_SEC_SR INNER JOIN CRS_COMMENTS_SR ON CRS_SEC_SR.CRS_CD=CRS_COMMENTS_SR.CRS_CD) INNER join DISCIPLINE_SR ON CRS_SEC_SR.DISC=DISCIPLINE_SR.DISC_ABBREVIATION)INNER join DEPT_SR on DISCIPLINE_SR.DEPT_ID=DEPT_SR.DEPT_ID";
	      			
	  	    // Add appropriate WHERE CLAUSE TO SQL STATEMENT
	  	   
	  	    	//WHERE Clause for semester
	  	    if (semesterLower != null && !semesterLower.isEmpty()){
	  	    	query2 = query2 + " WHERE CRS_SEC_SR.SEMESTER = '" + semesterLower + "'";
	  	    	System.out.println(query2);
	  	    }
	  	    
	  			//WHERE Clause for Discipline
	  	 	 if (!discipline.equals("Select	All")){
	  	    	query2 = query2 + " AND DISCIPLINE_SR.DISC_ABBREVIATION = '" + discipline + "'";
	  	    	System.out.println(query2);
	  	    }
	  			
	  	 		//WHERE Clause for undergraduate
	  	 	 if (undergraduate != null && graduate == null){
	  	    	query2 = query2 + " AND CRS_SEC_SR.D_E_G = 'D' OR CRS_SEC_SR.D_E_G = 'E'";
	  	    	System.out.println(query2);
	  	    }
	  	 		
	  	 			
	  			//WHERE Clause for graduate
	  	 	 if (undergraduate == null && graduate != null){
	  	    	query2 = query2 + " AND CRS_SEC_SR.D_E_G = 'G'";
	  	    	System.out.println(query2);
	  	    }
	  			
	  			//WHERE Clause for course number
	  	 	 if (number != null && !number.isEmpty()){
	  	    	query2 = query2 + " AND CRS_SEC_SR.CRS_NUM = '" + number + "'";
	  	    	System.out.println(query2);
	  	    }
	  	
	  			//WHERE Clause for professor name 
	  	 	 if (profUpper != null && !profUpper.isEmpty()){
	  	    	query2 = query2 + " AND CRS_SEC_SR.INSTRUCTOR_LNAME = '" + profUpper + "'";
	  	    	System.out.println(query2);
	  	    }
	  	
	  			//WHERE Clause for week days 
	  	 	if (week != null && !week.isEmpty()){
	  	 		System.out.println(week);
	  	    	query2 = query2 + " AND CRS_SEC_SR.MEETING_DAYS = '" + week + "'";
	  	    	System.out.println(query2);
	  	    }
	  			
	  		//if (AM_PM='AM'){
	  		//	query2 = query2 + " AND "
	  		//}
	  	    		
	  	    		
	      //if (prof.length() > 0){
	      //		query = query + "AND PROF = " + prof;
	      //	}
	      	
	      	ResultSet rs2 = stmt.executeQuery(query2);
	  
	      	while(rs2.next())
	      	{
	      		
	      		%>
	      		<tr><td><a href="coursedetails.jsp?value=<%=rs2.getString("CRS_CD")%>&semester=<%=semesterLower%>"> <%= rs2.getString("DISC") %> <%= rs2.getString("CRS_NUM") %> </a></td>
	      		<%
	      		System.out.println(rs2.getString("CRS_CD"));
	      		out.println("<td>" + rs2.getString("CRS_CD") + "</td>");
	      		out.println("<td>" + rs2.getString("CRS_SEC") + "</td>");
	      		out.println("<td>" + rs2.getString("MEETING_DAYS") + " " + rs2.getString("START_TIME") + " - " + rs2.getString("STOP_TIME") + rs2.getString("AM_PM") + "</td>");
	      		out.println("<td>" + rs2.getString("START_DATE") + " - " + rs2.getString("END_DATE") + "</td>");
	      		out.println("<td>" + rs2.getString("BUILDING") + " "+rs2.getString("RM")+ "</td>");
	      		out.println("<td>" + rs2.getString("INSTRUCTOR_LNAME") + "</td>");
	      		out.println("<td>" + rs2.getString("SEATS_AVAIL") + "</td>");
	      		//out.println("<td>" + rs2.getString("CRS_COMMENTS1") + "</td></tr>");
	      		
	      	}

	      //close table-body and table 
	      out.println("</tbody></table></div>");

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



  
  

  
  
  
  
    
     
    
  








<!--FOOT Include Begins -->
</div>
<!-- /main -->
</div>
<!-- /wrapper -->
</body>
</html>
<!--FOOT Include Ends -->