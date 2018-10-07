package Lab_2;

public class Point {
        public double x;
        public double y;
        public int R;
        public boolean isInArea;
        public String time;
        public String execTime;

        Point (double x, double y, int r) throws Exception{
            if (r <= 0 || r > 5  || x < -10 || x > 10 || y < -10 || y > 10) throw new Exception();
            this.x = x;
            this.y = y;
            this.R = r;
        }
    }
