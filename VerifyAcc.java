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

@WebServlet("/VerifyAcc")
public class VerifyAcc extends HttpServlet {

	@Override
	protected void service(HttpServletRequest rq, HttpServletResponse rs) throws ServletException,IOException{	
		String email = rq.getParameter("email");
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("update users set verify=? where email=?");
			ps.setInt(1, 1);
			ps.setString(2, email);
			int check = ps.executeUpdate();
			if(check>0) {
				rq.setAttribute("success","Verified successfully");
				RequestDispatcher rd = rq.getRequestDispatcher("/Admin.jsp");
				rd.forward(rq, rs);
			}else {
				rq.setAttribute("fail","Failed to verify!!");
				RequestDispatcher rd = rq.getRequestDispatcher("/Admin.jsp");
				rd.forward(rq, rs);
			}
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
			rq.setAttribute("fail","Failed to verify!!");
			RequestDispatcher rd = rq.getRequestDispatcher("/Admin.jsp");
			rd.forward(rq, rs);
		}
	}

}
