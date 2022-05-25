public class Node {

    private double x;
    private double y;

    public Node(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public double getX(){
        return x;
    }

    public double getY(){
        return y;
    }

    public double distance(Node adj) {
        return Math.sqrt(Math.pow(getX() - adj.getX(), 2) + Math.pow(getY() - adj.getY(), 2));
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