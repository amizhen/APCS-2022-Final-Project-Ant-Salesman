import java.util.Map;

public class Node {

    private double x;
    private double y;

    private Map<Node, Double> pheromoneMap;

    public Node() {

    }

    public void updatePheromones(Node adj) {}

    public void decayPheromone() {}

    private double calcDecay(Node adj) {
        return 0.0;
    }

}