/**
 * A class representing a location in which the Ant needs to arrive at per the travling salesman problem
 */
public class Node {

    private final double x;
    private final double y;

    /**
     * Constructor
     *
     * @param x The x coordinate of the Node
     * @param y the y coordinate of the Node
     */
    public Node(double x, double y) {
        this.x = x;
        this.y = y;
    }


    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double distance(Node adj) {
        return Math.sqrt(Math.pow(getX() - adj.getX(), 2) + Math.pow(getY() - adj.getY(), 2));

    }

    @Override
    public String toString() {
        return String.format("Node(x=%f, y=%f)", x, y);
    }

    public boolean equals(Node n) {
        return n.getX() == getX() && n.getY() == getY();
    }

}