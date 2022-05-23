import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Salesman {
    
    public final List<Node> nodes = new ArrayList<>();
    public final Map<Set<Node>, Double> pheromoneMap = new HashMap<>();

    public static double PHEROMONE_INFLUENCE_COEFFICIENT = 1.05;
    public static double DISTANCE_INFLUENCE_COEFFICIENT = 1.05;
    public static double PHEROMONE_EVAPORATION_COEFFICIENT = 0.90;

    public Salesman(Node... nodes) {
        for (Node node : nodes) {
            addNode(node);
        }
    }

    public void addNode(Node n) {
        for (Node node : nodes) {
            pheromoneMap.put(Set.of(n, node), 0.0);
        }
        nodes.add(n);
    }

    /* public Ant findShortestPath() {
        return null;
    } */

    public static void main(String[] args) {
        Salesman s = new Salesman(new Node(1, 1), new Node(2, 2), new Node(3, 3));
        System.out.println(s.pheromoneMap.get(Set.of(s.nodes.get(0), s.nodes.get(1))));
    }

}
