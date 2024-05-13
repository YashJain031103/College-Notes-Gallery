package in.sp.backend;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DownloadFile")
public class DownloadFile extends HttpServlet{

	public static int BUFFER_SIZE=1024*1000;
	@Override
	protected void doGet(HttpServletRequest rq, HttpServletResponse rs) throws ServletException, IOException{
		String filename = rq.getParameter("fn");
		String path = getServletContext().getRealPath("")+"notes"+File.separator+filename;
		File file = new File(path);
		OutputStream os = null;
		FileInputStream fis = null;
		
		rs.setHeader("Content-Disposition",String.format("attachment;filename=\"%s\"", file.getName()));
		rs.setContentType("application/octet-stream");
		
		if(file.exists()) {
			os=rs.getOutputStream();
			
			fis= new FileInputStream(file);
			
			byte[] bf = new byte[BUFFER_SIZE];
			
			int byteRead=-1;
			while((byteRead=fis.read(bf))!=-1) {
				os.write(bf,0,byteRead);
			}
		}else {
			
		}
	}
}
