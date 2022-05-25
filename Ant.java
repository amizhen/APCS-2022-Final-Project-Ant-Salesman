import java.util.*;

public class Ant {
    private double distanceTraveled;
    public ArrayList<Node> visitedNodes;
    private ArrayList<Node> toBeVisited;

    public Ant() {
        distanceTraveled = 0;
        visitedNodes = new ArrayList<Node>();
        toBeVisited = new ArrayList<>();
    }

    private double calcPheromones() {
        return Salesman.PHEROMONE_EVAPORATION_COEFFICIENT / getDistance();
    }


    private void pickNextNode(){
    }

    public void run() {
        toBeVisited.addAll(Salesman.nodes);

    }

    private void tick(){

    }

    public void depositPheromones() {

    }

    public double getDistance() {
        return distanceTraveled;
    }
}
