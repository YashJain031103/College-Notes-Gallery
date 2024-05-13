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

@WebServlet("/DeleteAccount")
public class DeleteAccount extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		HttpSession session = rq.getSession();
		String category =(String) session.getAttribute("session_category");
		String email = (String) session.getAttribute("session_email");
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("delete from users where email=?");
			ps.setString(1, email);
			ps.executeUpdate();
			rq.setAttribute("msg", "Account Deleted Successfully!!");
			RequestDispatcher rd = rq.getRequestDispatcher("/Registration.jsp");
			rd.forward(rq, rs);
		}catch(Exception e) {
			e.printStackTrace();
			rq.setAttribute("msg", "Some Error Deleting Your Account, Try Again!!");
			if(category.equals("teacher")) {
				RequestDispatcher rd = rq.getRequestDispatcher("/TeacherProfile.jsp");
				rd.forward(rq, rs);
			}else {
			RequestDispatcher rd = rq.getRequestDispatcher("/Profile.jsp");
			rd.forward(rq, rs);
			}
		}
	}

}
