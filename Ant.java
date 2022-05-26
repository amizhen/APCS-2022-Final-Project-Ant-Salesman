import java.util.ArrayList;
import java.util.Set;


public class Ant {
    private double distanceTraveled;
    private Node current;
    public final ArrayList<Node> visitedNodes;
    public final ArrayList<Node> toBeVisited; // TODO: make private 

    public Ant() {
        distanceTraveled = 0;
        visitedNodes = new ArrayList<Node>();
        toBeVisited = new ArrayList<>();
        //default current to the start node, add to relevant lists
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


    public void pickNextNode(){ // TODO: make private
        int sum = toBeVisited.stream().mapToInt(this::calculateWeight).sum();
        int choice = (int) (Math.random() * sum);
        int rand = 0;

        for (Node node : toBeVisited) {
            rand += calculateWeight(node);
            if (choice < rand) {
                visitedNodes.add(node);
                // System.out.println(visitedNodes);
                toBeVisited.remove(node);
                return;  
            } 
        }
        // should add fall back if everything fails
    }

    public void run() {
        toBeVisited.addAll(Salesman.nodes);

    }

    private void tick() {

    }

    public void depositPheromones() {
        Set<Node> key;
        for(int i = 0; i < visitedNodes.size()-1; i++){
            key = Set.of(visitedNodes.get(i), visitedNodes.get(i+1));
            Salesman.pheromoneMap.replace(key, Salesman.pheromoneMap.get(key) + calcPheromones());
        }
    }

    public double getDistance() {
        return distanceTraveled;
    }
}
