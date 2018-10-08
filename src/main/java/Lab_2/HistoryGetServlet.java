package Lab_2;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class HistoryGetServlet extends HttpServlet {
    private volatile List list = null;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if(list==null){
                list = (ArrayList) request.getSession().getAttribute("history");
                request.getSession().setAttribute("history", list);
            }
        } catch (Exception e){
            e.printStackTrace();
            request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        }

        if(list == null){
            response.sendError(500, "Some bugs with array!");
        } else {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            for (Object newPoint : list) {
                Point point = (Point) newPoint;
                out.println("{\"X\":\"" + point.x +
                        "\",\"Y\":\"" + point.y +
                        "\",\"R\":\"" + point.R +
                        "\",\"result\":\"" + point.isInArea +
                        "\",\"time\":\"" + point.time +
                        "\",\"work_time\":\"" + point.execTime +
                        "\"}");
            }
        }
    }
}
