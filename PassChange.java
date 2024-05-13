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

@WebServlet("/PassChange")
public class PassChange extends HttpServlet{

	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		HttpSession session = rq.getSession();
		String category = (String) session.getAttribute("session_category") ;
		String email = (String) session.getAttribute("session_email") ; 
		String CurrPass = rq.getParameter("CurrPass");
		String NewPass = rq.getParameter("NewPass");
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("select * from users where email=?");
			ps.setString(1, email);
			ResultSet r = ps.executeQuery();
			if(r.next() && r.getString("password").equals(CurrPass)) {
				if(!(r.getString("password").equals(NewPass))) {
					PreparedStatement ps1 = con.prepareStatement("update users set password=? where email=?");
					ps1.setString(1, NewPass);
					ps1.setString(2, email);
					int check = ps1.executeUpdate();
					if(check>0) {
						rq.setAttribute("msg1", "Your Password is Changed Successfully!!");
						if(category.equals("teacher")) {
							RequestDispatcher rd = rq.getRequestDispatcher("/TeacherProfile.jsp");
							rd.include(rq, rs);
						}else {
						RequestDispatcher rd = rq.getRequestDispatcher("/Profile.jsp");
						rd.include(rq, rs);
						}
					}
					else {
						rq.setAttribute("msg", "Failed to Change Password, please try again!!");
						RequestDispatcher rd = rq.getRequestDispatcher("/PassChange.jsp");
						rd.include(rq, rs);
					}
				}
				else {
					rq.setAttribute("msg", "Kindly Set Another Password, this one is used Earlier by you!!");
					RequestDispatcher rd = rq.getRequestDispatcher("/PassChange.jsp");
					rd.include(rq, rs);
				}
			}
			else {
				rq.setAttribute("msg", "Kindly Enter Correct Current Password!!");
				RequestDispatcher rd = rq.getRequestDispatcher("/PassChange.jsp");
				rd.include(rq, rs);
			}
		}catch(Exception e) {
			e.printStackTrace();
			rq.setAttribute("msg", "Some Unexpected Error Occured!!");
			RequestDispatcher rd = rq.getRequestDispatcher("/PassChange.jsp");
			rd.include(rq, rs);
		}
	}
}
