import java.util.Map;

public class Node {

    private double x;
    private double y;

    public Node(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public void updatePheromones(Node adj) {

    }

    public void decayPheromone() {

    }

    private double calcDecay(Node adj) {
        return 0.0;
    }

}