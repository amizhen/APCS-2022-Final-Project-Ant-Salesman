import java.util.ArrayList;
import java.util.Set;


public class Ant {
    private double distanceTraveled;
    private Node current;
    private final ArrayList<Node> visitedNodes;
    private final ArrayList<Node> toBeVisited; // TODO: make private


    public Ant(Node start) {
        distanceTraveled = 0;
        visitedNodes = new ArrayList<Node>();
        toBeVisited = new ArrayList<>();
        current = start;
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


    private void pickNextNode(){ // TODO: Make this function only do one thing, break off other things into tick
        int sum = toBeVisited.stream().mapToInt(this::calculateWeight).sum();
        int choice = (int) (Math.random() * sum);
        int rand = 0;
        Node node;
        for (int i = 0; i<toBeVisited.size(); i++) {
            node = toBeVisited.get(i);
            rand += calculateWeight(node);
            if (choice < rand) {
                distanceTraveled += current.distance(node);
                visitedNodes.add(node);
                // System.out.println(visitedNodes);
                current = node;
                toBeVisited.remove(i);
                return;
            } 
        }
        // should add fall back if everything fails
    }

    public void run() {
        toBeVisited.addAll(Salesman.nodes);
        visitedNodes.add(current);
        while(toBeVisited.size() > 0){
            tick();
        }
    }

    private void tick() {
        pickNextNode();
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
