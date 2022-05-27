import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Scanner;


/**
 * The class that performs the Ant Colony Optimization algorithms from a given set of nodes and coefficients.
 */
public class Salesman {
    
    public static final List<Node> nodes = new ArrayList<>();
    private static final Map<Set<Node>, Double> pheromoneMap = new HashMap<>();

    public static double PHEROMONE_INFLUENCE_COEFFICIENT = 1.2;
    public static double DISTANCE_INFLUENCE_COEFFICIENT = 1.2;
    public static double PHEROMONE_EVAPORATION_COEFFICIENT = 0.95;
    public static double PHEROMONE_DEPOSIT_COEFFICIENT = 100;

    public static final int ANTS_PER_ITERATION = 5;
    public static final int ITERATION = 16;
    public static final int TOP_ANT_SELECT_NUMBER = 2;

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
            if (pheromoneMap.get(key) * PHEROMONE_DEPOSIT_COEFFICIENT > 1 / Ant.WEIGHT_CONSTANT)  {
                pheromoneMap.replace(key, pheromoneMap.get(key) * PHEROMONE_EVAPORATION_COEFFICIENT);
            }
        }
    }

    public static double getPheromone(Node n1, Node n2) {
        return pheromoneMap.get(Set.of(n1, n2));
    }

    public static void setPheromone(Node n1, Node n2, double newVal){
        Set<Node> key = Set.of(n1, n2);
        pheromoneMap.replace(key, newVal);
    }

    /**
     * Main executing methods to perform the algorithm
     */


    public static void input(){
        Scanner scan = new Scanner(System.in);
        double x, y;
        String line;
        while(scan.hasNextLine()){
            line = scan.nextLine();
            //Expects coordinates as x,y
            x = Double.parseDouble(line.split(",")[0]);
            y = Double.parseDouble(line.split(",")[1]);
            nodes.add(new Node(x, y));
        }
    }


    public static Ant findShortestPath() { //TODO: Make nested for loop seperate function
        Node start = nodes.get(0);
        Ant[] ants = new Ant[ANTS_PER_ITERATION];
        
        int minIndex = 0;

        for (int j = 0; j < ITERATION; j++) {
            minIndex = 0;
            for (int i = 0; i < ANTS_PER_ITERATION; i++) {
                ants[i] = new Ant(start);
                ants[i].run();
                if (ants[i].getDistance() < ants[minIndex].getDistance()) {
                    minIndex = i;
                }
            }
            
            Arrays.sort(ants);
            
            decayPheromones();
            for (int i = 0; i < TOP_ANT_SELECT_NUMBER; i++) {
                ants[i].depositPheromones();
            }

            System.out.println("Distance for iteration " + (j + 1) + " - " + ants[minIndex].getDistance());
        }

        return ants[minIndex];
    }

    public static void main(String[] args) {
        // test setup code
//        addNodes(
//            new Node(1, 1),
//            new Node(2, 2),
//            new Node(0, 0),
//            new Node(9, 9),
//            new Node(32, 25),
//            new Node(10, 5),
//            new Node(-20, 40),
//            new Node(12, -12)
//        );
//        Ant a = findShortestPath();
//        System.out.println(a.getPathAsString());
//        System.out.println(a.getDistance());
        input();
        System.out.println(nodes);
    }

}
