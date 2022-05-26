import java.util.*;
import java.util.stream.DoubleStream;
import java.util.stream.IntStream;

public class Ant {
    private double distanceTraveled;
    public final ArrayList<Node> visitedNodes;
    public final ArrayList<Node> toBeVisited; // make private 

    public Ant() {
        distanceTraveled = 0;
        visitedNodes = new ArrayList<Node>();
        toBeVisited = new ArrayList<>();
    }

    private double calcPheromones() {
        return Salesman.PHEROMON_DEPOSIT_COEFFICIENT / getDistance();
    }

    private Node getCurrentNode() {
        return visitedNodes.get(visitedNodes.size() - 1);
    }

    private int calculateWeight(Node node) {
        Node current = getCurrentNode();
        return (int) (Math.pow(Salesman.getPheromone(node, current), Salesman.PHEROMONE_INFLUENCE_COEFFICIENT) * Math.pow(1 / node.distance(current), Salesman.DISTANCE_INFLUENCE_COEFFICIENT) * 100);
    }

    public void pickNextNode(){ // make private
        Node current = getCurrentNode();
        int sum = toBeVisited.stream().mapToInt(i -> calculateWeight(i)).sum();

        int choice = (int) (Math.random() * sum);
        int rand = 0;
        for (Node node : toBeVisited) {
            rand += (int) (Math.pow(Salesman.getPheromone(node, current), Salesman.PHEROMONE_INFLUENCE_COEFFICIENT) * Math.pow(1 / node.distance(current), Salesman.DISTANCE_INFLUENCE_COEFFICIENT) * 100);
            if (choice < rand) {
                visitedNodes.add(node);
                toBeVisited.remove(node);
                return;  
            } 
        }
        // should add fall back if everything fails
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
