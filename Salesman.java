import java.util.ArrayList;
import java.util.Arrays;
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

    public static double PHEROMONE_INFLUENCE_COEFFICIENT = 0.8;
    public static double DISTANCE_INFLUENCE_COEFFICIENT = 1.2;
    public static double PHEROMONE_EVAPORATION_COEFFICIENT = 1;
    public static double PHEROMONE_DEPOSIT_COEFFICIENT = 100;

    public static final int ANTS_PER_ITERATION = 100;

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
    public static void decayPheromones() {
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
        Node start = nodes.get(0);
        Ant[] ants = new Ant[ANTS_PER_ITERATION];
        
        int minIndex = 0;

        for (int j = 0; j < 100; j++) {
            minIndex = 0;
            for (int i = 0; i < ANTS_PER_ITERATION; i++) {
                ants[i] = new Ant(start);
                ants[i].run();
                if (ants[i].getDistance() < ants[minIndex].getDistance()) {
                    minIndex = i;
                }
            }
            // Arrays.sort(ants);
            
            decayPheromones();
            ants[minIndex].depositPheromones();
            System.out.println("Distance for iteration " + (j + 1) + " - " + ants[minIndex].getDistance());
        }

        return ants[minIndex];
    }

    public static void main(String[] args) {
        // test setup code
        addNodes(new Node(1, 1), new Node(2, 2), new Node(0, 0), new Node(9, 9), new Node(32, 25));
        Ant a = findShortestPath();
        System.out.println(a.getPathAsString());
        System.out.println(a.getDistance());
    }

}
