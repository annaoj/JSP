package jimenez;

/*
Student Name:    Anna Jimenez
Assignment #    3 and 4  
 Class: Fall 2015 - 4160
Features Included: 
		- Session tracking through cookies
		- Ability to make multiple changes to schedule in one session


*/

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.http.Cookie;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;

/**
 * Servlet implementation class LoginServ
 */
@WebServlet("/LoginServ")
public class LoginServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServ() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Connect to the database: 
		  Connection conn = null;
		   try
		   {

			   String driver = "oracle.jdbc.OracleDriver";
			   // 1. Load the driver
			   Class.forName(driver);

			   // 2. Define the connection URL
			   String url = "jdbc:oracle:thin:@localhost:1521:XE"; //orcl is the SID
			   String myusername = "cis4160"; // Your DB login ID
			   String mypassword = "cis4160"; //Your Db pass

			   
			   // 3. Establish the connection
	  		   	conn = DriverManager.getConnection(url, myusername,mypassword);
	  		  
	  		    String pass = request.getParameter("password");
	  			String user = request.getParameter("userId");
	  			String dept = request.getParameter("deptId");
	  			
	  	
	  			
	  			Statement statement = (Statement) conn.createStatement();
	  			
	  			ResultSet res = statement.executeQuery("SELECT * FROM admin_user_sr WHERE password='" + pass + "'AND user_name='" + user + "' AND DEPT ='" + dept +"'");
	  			
	  			
	  			if(res.next()){
	  				Cookie loginCookie = new Cookie("userId", user);
	  				// Setting the cookie to expire in 30 minutes. 
	  				loginCookie.setMaxAge(30*60);
	  				response.addCookie(loginCookie);
	  				response.sendRedirect("update.jsp");
	  				System.out.println("Inside res.next()");
	  			}
	  			else {
	  				response.sendRedirect("loginFail.jsp");
	  			}
		   }


		   catch(SQLException e)
		   {
		      // Do exception catch such as if connection is not made or
		      // query is not set up properly
		      System.out.println("SQLException: " + e.getMessage());
		      while((e = e.getNextException()) != null)
		         System.out.println(e.getMessage());
		   }
		   catch(ClassNotFoundException e)
		   {
		      System.out.println("ClassNotFoundException: " + e.getMessage());
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
		
	}

}
