import java.util.*;

public class Ant {
    private double distanceTraveled;
    public ArrayList<Node> nodesVisited;
    private ArrayList<Node> toBeVisited;

    public Ant() {
        distanceTraveled = 0;
        nodesVisited = new ArrayList<Node>();
    }

    private double calcPheromones(Node node1, Node node2) {
        double[] cords1 = node1.getCords();
        double[] cords2 = node2.getCords();
        return calcDistance(cords1[0], cords2[])
    }

    private void pickNextNode() {
    }

    public void run() {
        toBeVisited = new ArrayList<>();
        toBeVisited.addAll(Salsemen.nodes);

    }

    public void depositPheromones() {

    }

    private double calcDistance(double x1, double y1, double x2, double x2){
        return Math.sqrt(Math.pow(x1-x2, 2)+Math.pow(y1-y2, 2));
    }

    public double getDistance() {
        return distanceTraveled;
    }
}
