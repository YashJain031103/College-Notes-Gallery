package in.sp.backend;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLogout")
public class AdminLogout extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		HttpSession session = rq.getSession();
		session.invalidate();
		rq.setAttribute("msg1", "Logged Out Successfully!!");
		RequestDispatcher rd = rq.getRequestDispatcher("/AdminLogin.jsp");
		rd.forward(rq, rs);
		}
}