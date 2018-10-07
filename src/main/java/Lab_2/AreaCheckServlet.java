package Lab_2;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class AreaCheckServlet extends HttpServlet {
    private List list = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long startTime = System.nanoTime();

        if(list==null){
            list=new ArrayList();
            request.getSession().setAttribute("history", list);
        }

        Locale local = new Locale("ru","RU");
        DateFormat df = DateFormat.getDateTimeInstance (DateFormat.DEFAULT, DateFormat.DEFAULT, local);
        String time =  df.format(new Date());

        Point newPoint = null;
        try{
            newPoint = new Point(Double.parseDouble(request.getParameter("X")),
                    Double.parseDouble(request.getParameter("Y")), Integer.parseInt(request.getParameter("R")));
            newPoint.isInArea = checkArea(newPoint.x, newPoint.y, newPoint.R);
            newPoint.time = time;
            newPoint.execTime = String.format("%.5f", (double)(System.nanoTime() - startTime) / 1000 / 1000);
            list.add(newPoint);
        } catch (Exception e){
            e.printStackTrace();
            request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("{\"X\":\"" + newPoint.x +
                    "\",\"Y\":\"" + newPoint.y +
                    "\",\"R\":\"" + newPoint.R +
                    "\",\"result\":\""+ newPoint.isInArea +
                    "\",\"time\":\"" + newPoint.time +
                    "\",\"work_time\":\"" + newPoint.execTime +
                    "\"}");
    }

    private static boolean checkArea(double x, double y, int R){
        if(x<=0 && y>=0 && x*x+y*y<=R*R){
            return true;
        }
        if(x<=0 && y<=0 && x>=-(double)(R)/2 && y>=-R){
            return true;
        }
        if(x>=0 && y>=0 && y<= -2*x + R){
            return true;
        }
        return false;
    }

}
