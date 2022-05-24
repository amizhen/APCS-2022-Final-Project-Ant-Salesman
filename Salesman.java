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

    public static final int ANTS = 10;

    /**
     * A method to add an individual Node to the system. Updates nodes and the pheromone map.
     * 
     * @param n The node to add
     */
    public static void addNode(Node n) {
        for (Node node : nodes) {
            pheromoneMap.put(Set.of(n, node), 0.0);
        }
        nodes.add(n);
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

    /**
     * Main executing methods to perform the algorithm
     */
    public static Ant findShortestPath() {
        return null;
    }

    public static void main(String[] args) {
        
    }

}
