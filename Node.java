public class Node {

    private double x;
    private double y;

    public Node(double x, double y) {
        this.x = x;
        this.y = y;
    }

    private double distance(Node adj) {
        return Math.sqrt((x - adj.x) * (x - adj.x) + (y - adj.y) * (y-adj.y));
    }

    public void updatePheromones(Node adj) {
        
    }

    public void decayPheromone() {

    }

    private double calcDecay(Node adj) {
        return 0.0;
    }

    @Override
    public String toString() {
        return String.format("Node(x=%f, y=%f)", x, y);
    }

}