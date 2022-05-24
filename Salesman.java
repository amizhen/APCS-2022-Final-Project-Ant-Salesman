import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Salesman {
    
    public static final List<Node> nodes = new ArrayList<>();
    public static final Map<Set<Node>, Double> pheromoneMap = new HashMap<>();

    public static double PHEROMONE_INFLUENCE_COEFFICIENT = 1.05;
    public static double DISTANCE_INFLUENCE_COEFFICIENT = 1.05;
    public static double PHEROMONE_EVAPORATION_COEFFICIENT = 0.90;

    public static void addNode(Node n) {
        for (Node node : nodes) {
            pheromoneMap.put(Set.of(n, node), 0.0);
        }
        nodes.add(n);
    }

    public static void addNodes(Node... n) {
        for (Node node : nodes) {
            addNode(node);
        }
    }

    public static void decayPheromone() {
        for (Set<Node> key : pheromoneMap.keySet()) {
            pheromoneMap.replace(key, pheromoneMap.get(key) * PHEROMONE_EVAPORATION_COEFFICIENT);
        }
    }

    public static Ant findShortestPath() {
        return null;
    }

    public static void main(String[] args) {
        
    }

}
