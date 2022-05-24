import java.util.*;

public class Ant {
    private double distanceTraveled;
    public ArrayList<Node> nodesVisited;
    private ArrayList<Node> toBeVisited;

    public Ant() {
        distanceTraveled = 0;
        nodesVisited = new ArrayList<Node>();
    }

    private double calcPheromones() {
        return Salesman.PHEROMONE_EVAPORATION_COEFFICIENT / getDistance;
    }

    private double calc_dist(double x1, double y1, double x2, double y2){
        return Math.sqrt(Math.pow(x1-x2, 2)+Math.pow(y1-y2, 2));
    }

    private void pickNextNode() {
    }

    public void run() {
        toBeVisited = new ArrayList<>();
        toBeVisited.addAll(Salsemen.nodes);

    }

    public void depositPheromones() {

    }

    public double getDistance() {
        return distanceTraveled;
    }
}
