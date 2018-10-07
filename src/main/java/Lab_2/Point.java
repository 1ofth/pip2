package Lab_2;

public class Point {
        public double x;
        public double y;
        public int R;
        public boolean isInArea;
        public String time;
        public String execTime;

        Point (double x, double y, int r) throws Exception{
            if (r <= 0 || r > 5  || x < -2 || x > 2 || y < -3 || y > 5) throw new Exception();
            this.x = x;
            this.y = y;
            this.R = r;
        }
}

