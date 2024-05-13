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

@WebServlet("/DeleteRec")
public class DeleteRec extends HttpServlet {
     
	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException,IOException{
		HttpSession session = rq.getSession();
		String timestamp = rq.getParameter("timestamp");
		String email = (String) session.getAttribute("session_email");
		try{
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("delete from notes where upload_time=? and email=?");
			ps.setString(1, timestamp);
			ps.setString(2, email);
			int check= ps.executeUpdate();
			if(check>0) {
				rq.setAttribute("msg1","Notes deleted Successfully!!");
				RequestDispatcher rd = rq.getRequestDispatcher("/ShowNotes.jsp");
				rd.include(rq, rs);
			}else {
				rq.setAttribute("msg","Failed to delete the record!!");
				RequestDispatcher rd = rq.getRequestDispatcher("/ShowNotes.jsp");
				rd.include(rq, rs);
			}
		}catch(Exception e) {
			e.printStackTrace();
			rq.setAttribute("msg","Unexpected Error Occured!!");
			RequestDispatcher rd = rq.getRequestDispatcher("/ShowNotes.jsp");
			rd.include(rq, rs);
		}
	}
}
