package in.sp.backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		PrintWriter out = rs.getWriter();
		String email = rq.getParameter("email");
		String password = rq.getParameter("password");
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("select * from users where email=? and password=?");
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet r = ps.executeQuery();
			if(r.next()) {
				if(r.getString("category").equals("teacher") && r.getInt("verify")==0) {
					rs.setContentType("text/html");
					out.print("<h3 style='color:red ; text-align:center'>Admin Verification of the Account is Pending!!</h3>");
					RequestDispatcher rd = rq.getRequestDispatcher("/Login.jsp");
					rd.include(rq, rs);
				}else {
				HttpSession session = rq.getSession();
				session.setAttribute("session_name", r.getString("name"));
				session.setAttribute("session_email", r.getString("email"));
				session.setAttribute("session_dept", r.getString("department_name"));
				session.setAttribute("session_category", r.getString("category"));
				if(r.getString("category").equals("teacher") && r.getInt("verify")==1) {
					RequestDispatcher rd = rq.getRequestDispatcher("/TeacherProfile.jsp");
					rd.include(rq, rs);
				}else {
				RequestDispatcher rd = rq.getRequestDispatcher("/Profile.jsp");
				rd.include(rq, rs);
				}
				}
			}else {
				rs.setContentType("text/html");
				out.print("<h3 style='color:red ; text-align:center'>Email and Password Mis-Matched</h3>");
				RequestDispatcher rd = rq.getRequestDispatcher("/Login.jsp");
				rd.include(rq, rs);
			}
		}catch(Exception e) {
			e.printStackTrace();
			rs.setContentType("text/html");
			out.print("<h3 style='color:red ; text-align:center'>Email and Password Mis-Matched</h3>");
			RequestDispatcher rd = rq.getRequestDispatcher("/Login.jsp");
			rd.include(rq, rs);
		}
	}


}
