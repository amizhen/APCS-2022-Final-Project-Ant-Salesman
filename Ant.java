import java.util.*

public class Ant {
    private double distanceTraveled;
    public ArrayList<Node> nodesVisited;
    private ArrayList<Node> toBeVisited;

    public Ant() {
        distanceTraveled = 0;
        nodesVisited = new ArrayList<Node>();
    }

    private double calcPheromones() {
        return 0.0;
    }

    private void pickNextNode() {
    }

    public void run() {
        toBeVisited = new ArrayList<>();
        toBeVisited.addAll(Salsemen.nodes);

    }

    public void depositPheromones() {

    }

    public getDistance() {
        return distanceTraveled;
    }
}
