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

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		PrintWriter out = rs.getWriter();
		String username = rq.getParameter("username");
		String password = rq.getParameter("password");
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("select * from admin where username=? and password=?");
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet r = ps.executeQuery();
			if(r.next()) {
				HttpSession session = rq.getSession();
				session.setAttribute("admin_name", r.getString("username"));
				RequestDispatcher rd = rq.getRequestDispatcher("/Admin.jsp");
				rd.include(rq, rs);
			}else {
				rs.setContentType("text/html");
				out.print("<h3 style='color:red ; text-align:center'>Username and Password Mis-Matched</h3>");
				RequestDispatcher rd = rq.getRequestDispatcher("/AdminLogin.jsp");
				rd.include(rq, rs);
			}
		}catch(Exception e) {
			e.printStackTrace();
			rs.setContentType("text/html");
			out.print("<h3 style='color:red ; text-align:center'>Email and Password Mis-Matched</h3>");
			RequestDispatcher rd = rq.getRequestDispatcher("/AdminLogin.jsp");
			rd.include(rq, rs);
		}
	}

}
