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

    public static final Node start = new Node(0, 0);
    public static final List<Node> nodes = new ArrayList<>();
    private static final Map<Set<Node>, Double> pheromoneMap = new HashMap<>();

    /** Determines the effect of pheromones in the chance of the Node to be selected by the Ant */
    public static double PHEROMONE_INFLUENCE_COEFFICIENT = 1.2;
    /** Determines the effect of the distance in the chance of the Node to be selected by the Ant */
    public static double DISTANCE_INFLUENCE_COEFFICIENT = 1.2;
    /** Percentage of pheromones that remain after evaporation */
    public static double PHEROMONE_EVAPORATION_COEFFICIENT = 0.95;
    /** Determines the amount of pheromones to be dropped by an Ant */
    public static double PHEROMONE_DEPOSIT_COEFFICIENT = 100;


    // Perhaps this can be dynamically determined. 
    public static final int ANTS_PER_GENERATION = 1;
    public static final int GENERATIONS = 16;
    public static final int TOP_ANT_SELECT_NUMBER = 1; // invariant - less than ANTS_PER_GENERATION

    /**
     * A method to add an individual Node to the system. Updates nodes and the pheromone map.
     * 
     * @param n The node to add
     */
    public static void addNode(Node n) {
        if (!nodes.contains(n)) {
            for (Node node : nodes) {
                pheromoneMap.put(Set.of(n, node), 1.0); 
            }
            pheromoneMap.put(Set.of(n, start), 1.0);
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
            if (pheromoneMap.get(key) * PHEROMONE_DEPOSIT_COEFFICIENT > 1 / Ant.WEIGHT_CONSTANT)  {
                pheromoneMap.replace(key, pheromoneMap.get(key) * PHEROMONE_EVAPORATION_COEFFICIENT);
            }
        }
    }

    /**
     * A method to returns the pheromone level found between two nodes.
     * 
     * @param n1 One of the two nodes forming the edge
     * @param n2 One of the two nodes forming the edge
     * @return The pheromone level at edge n1 to n2
     */
    public static double getPheromone(Node n1, Node n2) {
        return pheromoneMap.get(Set.of(n1, n2));
    }

    /**
     * A method that sets the pheromone level found between two nodes to a new pheromone level
     * 
     * @param n1 One of the two nodes forming the edge
     * @param n2 One of the two nodes forming the edge
     * @param newVal The set pheromone level at edge n1 to n2
     */
    public static void setPheromone(Node n1, Node n2, double newVal){
        Set<Node> key = Set.of(n1, n2);
        pheromoneMap.replace(key, newVal);
    }

    /**
     * A method that finds attempts to find the shortest path using the Ant Colony Optimization Algorithm
     * 
     * @return The ant with the shortest path found in the final iteration
     */
    public static Ant findShortestPath() {
        Ant[] ants = new Ant[ANTS_PER_GENERATION];

        for (int j = 0; j < GENERATIONS; j++) {
            for (int i = 0; i < ANTS_PER_GENERATION; i++) {
                ants[i] = new Ant(start);
                ants[i].run(); // have ants traverse through the map of nodes
            }
            Arrays.sort(ants); // sort Ants on distance travelled
            
            decayPheromones();
            for (int i = 0; i < TOP_ANT_SELECT_NUMBER; i++) { // have the top selected ants deposit pheromones aka smallest distance travelled
                ants[i].depositPheromones();
            }

            System.out.println("Distance for iteration " + (j + 1) + " - " + ants[0].getDistance());
        }

        return ants[0];
    }

    public static void main(String[] args) {
        // test setup code
        addNodes(
            new Node(1, 1), 
            new Node(2, 2), 
            new Node(0, 0), 
            new Node(9, 9), 
            new Node(32, 25),
            new Node(10, 5),
            new Node(-20, 40),
            new Node(12, -12)
        );
        Ant a = findShortestPath();
        System.out.println(a.getPathAsString());
        System.out.println(a.getDistance());
    }

}
