package Lab_2;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class AreaCheckServlet extends HttpServlet {
    private List list = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(list==null){
            list=new ArrayList();
            request.getSession().setAttribute("history", list);
        }
        Point newPoint = null;
        try{
             newPoint = new Point(Double.parseDouble(request.getParameter("X")),
                    Double.parseDouble(request.getParameter("Y")), Integer.parseInt(request.getParameter("R")));
            newPoint.isInArea = checkArea(newPoint.x, newPoint.y, newPoint.R);
            list.add(newPoint);
        } catch (Exception e){
            e.printStackTrace();
            request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("{\"X\":\"" + newPoint.x + "\",\"Y\":\"" + newPoint.y + "\",\"R\":\"" + newPoint.R +
                "\",\"result\":\""+ newPoint.isInArea + "\",\"time\":\"122\",\"work_time\":\"233\"}");
    }

    public static boolean checkArea(double x, double y, int R){
        if(x<=0 && y>=0 && x*x+y*y<=R*R){
            return true;
        }
        if(x<=0 && y<=0 && x>=-R/2 && y>=-R){
            return true;
        }
        if(x>=0 && y>=0 && y<=R && x<=R/2){
            return true;
        }
        return false;
    }

}
