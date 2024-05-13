package in.sp.backend;

import java.io.IOException;
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

@WebServlet("/Upvote")
public class Upvote extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		HttpSession session = rq.getSession();
		String voter = (String) session.getAttribute("session_email");
		String author = rq.getParameter("author");
		String department = rq.getParameter("department");
		String timestamp = rq.getParameter("timestamp");
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("select * from upvotes where voter_mail=? and author_mail=? and upload_time=?");
			ps.setString(1,voter);
			ps.setString(2,author);
			ps.setString(3,timestamp);
			ResultSet r = ps.executeQuery();
			if(!r.next()) {
				PreparedStatement ps0 = con.prepareStatement("update notes set upvote=upvote+1 where email=? and upload_time=?");
				ps0.setString(1,author);
				ps0.setString(2,timestamp);
				ps0.executeUpdate();
				PreparedStatement ps1 = con.prepareStatement("insert into upvotes (voter_mail,author_mail,upload_time) values(?,?,?)");
				ps1.setString(1,voter);
				ps1.setString(2,author);
				ps1.setString(3,timestamp);
				int check = ps1.executeUpdate();
				if(check>0) {
					rq.setAttribute("success","Upvoted Successfully");
					RequestDispatcher rd = rq.getRequestDispatcher("/"+department+".jsp");
					rd.forward(rq, rs);
				}else {
					rq.setAttribute("fail","Failed to Upvote!!");
					RequestDispatcher rd = rq.getRequestDispatcher("/"+department+".jsp");
					rd.forward(rq, rs);
				}
			}else {
				rq.setAttribute("voted","Already Voted This Notes!!");
				RequestDispatcher rd = rq.getRequestDispatcher("/"+department+".jsp");
				rd.forward(rq, rs);
			}
		}catch(Exception e) {
			e.printStackTrace();
			rq.setAttribute("fail","Failed to Upvote!!");
			RequestDispatcher rd = rq.getRequestDispatcher("/"+department+".jsp");
			rd.forward(rq, rs);
		}
	}
}
