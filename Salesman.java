import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * The class that performs the Ant Colony Optimization algorithms from a given set of nodes and coefficients.
 */
public class Salesman {
    
    public static final List<Node> nodes = new ArrayList<>();
    public static final Map<Set<Node>, Double> pheromoneMap = new HashMap<>();

    public static double PHEROMONE_INFLUENCE_COEFFICIENT = 1.05;
    public static double DISTANCE_INFLUENCE_COEFFICIENT = 1.05;
    public static double PHEROMONE_EVAPORATION_COEFFICIENT = 0.90;
    public static double PHEROMON_DEPOSIT_COEFFICIENT = 1;

    public static final int ANTS = 10;

    /**
     * A method to add an individual Node to the system. Updates nodes and the pheromone map.
     * 
     * @param n The node to add
     */
    public static void addNode(Node n) {
        if (!nodes.contains(n)) {
            for (Node node : nodes) {
                pheromoneMap.put(Set.of(n, node), 1.0); // set to 0 or 1; decide later
            }
            nodes.add(n);
        }
    }

    /**
     * A method to add multiple Nodes to the system. Updates nodes and the pheromone map.
     * 
     * @param nodes The nodes to add
     */
    public static void addNodes(Node... nodes) {
        for (Node node : nodes) {
            addNode(node);
        }
    }

    /**
     * A method to decay all the edges in the pheromone map. The decay is based on the PHEROMONE_EVAPORATION_COEFFICIENT
     */
    public static void decayPheromone() {
        for (Set<Node> key : pheromoneMap.keySet()) {
            pheromoneMap.replace(key, pheromoneMap.get(key) * PHEROMONE_EVAPORATION_COEFFICIENT);
        }
    }

    public static double getPheromone(Node n1, Node n2) {
        return pheromoneMap.get(Set.of(n1, n2));
    }

    /**
     * Main executing methods to perform the algorithm
     */
    public static Ant findShortestPath() {
        return null;
    }

    public static void main(String[] args) {
        Node start = new Node(1, 1);
        addNodes(new Node(2, 2), new Node(5, 7), new Node(9, 9), new Node(32, 25), start);
        Ant a = new Ant();
        a.visitedNodes.add(start);
        for (Node n : nodes) {
            if (!n.equals(start)) {
                a.toBeVisited.add(n);
            }
        }

        a.pickNextNode();
    }

}
