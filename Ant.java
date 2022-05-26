import java.util.*;

public class Ant {
    private double distanceTraveled;
    public ArrayList<Node> visitedNodes;
    private ArrayList<Node> toBeVisited;
    private Node current;

    public Ant() {
        distanceTraveled = 0;
        visitedNodes = new ArrayList<Node>();
        toBeVisited = new ArrayList<>();
        //default current to the start node, add to relevant lists
    }

    private double calcPheromones() {
        return Salesman.PHEROMON_DEPOSIT_COEFFICIENT / getDistance();
    }


    private void pickNextNode() {
        double total = 0;
        double counter = 0;
        double odds = Math.random();
        for (Node adj : toBeVisited) {
            total += Salesman.pheromoneMap.get(Set.of(adj, current)) + 1;
        }
        Node adj;
        for (int i = 0; i < toBeVisited.size(); i++) {
            adj = toBeVisited.get(i);
            counter += Salesman.pheromoneMap.get(Set.of(adj, current)) + 1;
            if (counter / total > odds) {
                toBeVisited.remove(i);
                visitedNodes.add(adj);
                return;
            }
        }
    }

    public void run() {
        toBeVisited.addAll(Salesman.nodes);

    }

    private void tick() {

    }

    public void depositPheromones() {

    }

    public double getDistance() {
        return distanceTraveled;
    }
}
