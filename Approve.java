package in.sp.backend;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Approve")
public class Approve extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		HttpSession session = rq.getSession();
		String faculty = (String) session.getAttribute("session_email");
		String author = rq.getParameter("author");
		String timestamp = rq.getParameter("timestamp");
		try {
			Connection con = DbConnect.getCon();
				PreparedStatement ps = con.prepareStatement("update notes set approve=1 where email=? and upload_time=?");
				ps.setString(1,author);
				ps.setString(2,timestamp);
				ps.executeUpdate();
				PreparedStatement ps1 = con.prepareStatement("insert into approves (faculty,author,upload_time) values(?,?,?)");
				ps1.setString(1,faculty);
				ps1.setString(2,author);
				ps1.setString(3,timestamp);
				int check = ps1.executeUpdate();
				if(check>0) {
					rq.setAttribute("success","Approved Sucessfully!!");
					RequestDispatcher rd = rq.getRequestDispatcher("/TeacherProfile.jsp");
					rd.forward(rq, rs);
				}else {
					rq.setAttribute("fail","Failed to Approve!!");
					RequestDispatcher rd = rq.getRequestDispatcher("/TeacherProfile.jsp");
					rd.forward(rq, rs);
				}
		}catch(Exception e) {
			e.printStackTrace();
			rq.setAttribute("fail","Failed to Approve!!");
			RequestDispatcher rd = rq.getRequestDispatcher("/TeacherProfile.jsp");
			rd.forward(rq, rs);
		}
	}
}
