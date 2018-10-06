package Lab_2;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
	 @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException {
		String xString=request.getParameter("X");
		String yString=request.getParameter("Y");
		String RString=request.getParameter("R");
		if(xString == null || yString == null || RString == null){
			request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
		} else {
			request.getServletContext().getNamedDispatcher("AreaCheckServlet").forward(request, response);
		}
    }
// data:text/html,<form action=http://localhost:8080/minecampf/ method=post><input name=a></form>
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		doPost(req, resp);
//	}
}
