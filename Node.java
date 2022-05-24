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

    @Override
    public String toString() {
        return String.format("Node(x=%f, y=%f)", x, y);
    }

}