package in.sp.backend;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/UploadNotes")
@MultipartConfig
public class UploadNotes extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		HttpSession session = rq.getSession();
		String email = (String)session.getAttribute("session_email");
		String category = (String)session.getAttribute("session_category");
		String department = rq.getParameter("department");
		String title = rq.getParameter("title");
		String about = rq.getParameter("about");
		String type = rq.getParameter("type");
		Part myfile = rq.getPart("file");
		String filename = myfile.getSubmittedFileName();
		try {
			Connection con = DbConnect.getCon();
			PreparedStatement ps = con.prepareStatement("insert into notes (email,department_name,title,about,type,file,category) values(?,?,?,?,?,?,?)");
			ps.setString(1, email);
			ps.setString(2, department);
			ps.setString(3, title);
			ps.setString(4, about);
			ps.setString(5, type);
			ps.setString(6, filename);
			ps.setString(7, category);
			int check = ps.executeUpdate();
			if(check>0) {
				String path = getServletContext().getRealPath("")+"notes";
				File file = new File(path);
				myfile.write(path+File.separator+filename);
				rq.setAttribute("msg1", "Notes Uploaded Successfully!! thank you for your Contribution ☺");
				RequestDispatcher rd = rq.getRequestDispatcher("/Upload.jsp");
				rd.include(rq, rs);
			}
			else {
				rq.setAttribute("msg", "Failed to Upload Notes!! please try again ♥");
				RequestDispatcher rd = rq.getRequestDispatcher("/Upload.jsp");
				rd.include(rq, rs);
			}
		}catch(Exception e) {
			e.printStackTrace();
			rq.setAttribute("msg", "Unexpected Error Occured!!");
			RequestDispatcher rd = rq.getRequestDispatcher("/Upload.jsp");
			rd.include(rq, rs);
		}
	}

}
