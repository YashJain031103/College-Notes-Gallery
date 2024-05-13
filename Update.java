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

@WebServlet("/Update")
public class Update extends HttpServlet {

	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException,IOException{	
		HttpSession session = rq.getSession();
		String username = rq.getParameter("name");
		String category = (String) session.getAttribute("session_category") ; 
		String email = (String) session.getAttribute("session_email") ; 
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("update users set name=? where email=?");
			ps.setString(1, username);
			ps.setString(2, email);
			int check = ps.executeUpdate();
			if(check>0) {
				session.setAttribute("session_name", username);
				rq.setAttribute("message","Record Updated Successfully!!");
				if(category.equals("teacher")) {
					RequestDispatcher rd = rq.getRequestDispatcher("/TeacherProfile.jsp");
					rd.include(rq, rs);
				}else {
				RequestDispatcher rd = rq.getRequestDispatcher("/Profile.jsp");
				rd.include(rq, rs);
				}
				
			}else {
				rq.setAttribute("message","Some Error Occured while Updating your Profile!");
				RequestDispatcher rd = rq.getRequestDispatcher("/Edit.jsp");
				rd.include(rq, rs);
			}	
		}catch(Exception e) {
			e.printStackTrace();
			rq.setAttribute("message","Some Error Occured while Updating your Profile!");
			RequestDispatcher rd = rq.getRequestDispatcher("/Edit.jsp");
			rd.include(rq, rs);
		}
	}
}
