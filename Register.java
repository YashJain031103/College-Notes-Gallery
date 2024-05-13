package in.sp.backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Register")
public class Register extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		String name = rq.getParameter("username");
		String email = rq.getParameter("email");
		String password = rq.getParameter("password");
		String department = rq.getParameter("department");
		String category = rq.getParameter("category");
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps1 = con.prepareStatement("select email from users where email=?;");
			ps1.setString(1,email);
			ResultSet r = ps1.executeQuery();
			if(r.next()) {
				rq.setAttribute("msg", "Already Registered Email");
				RequestDispatcher rd = rq.getRequestDispatcher("/Registration.jsp");
				rd.include(rq, rs);
			}else {
			PreparedStatement ps = con.prepareStatement("insert into users (name,email,password,department_name,category) values(?,?,?,?,?);");
			ps.setString(1,name);
			ps.setString(2,email);
			ps.setString(3,password);
			ps.setString(4,department);
			ps.setString(5,category);
			
			int check = ps.executeUpdate();
			if(check>0) {
				rq.setAttribute("msg1", "User Registered Successfully");
				RequestDispatcher rd = rq.getRequestDispatcher("/Login.jsp");
				rd.include(rq, rs);
			}
			else {
				rq.setAttribute("msg", "User Not Registered due to some Error");
				RequestDispatcher rd = rq.getRequestDispatcher("/Registration.jsp");
				rd.include(rq, rs);
			}
			}
		} catch (Exception e) {
			e.printStackTrace();
			rq.setAttribute("msg", "User Not Registered due to some Error");
			RequestDispatcher rd = rq.getRequestDispatcher("/Registration.jsp");
			rd.include(rq, rs);
		}
	     
	}

}
