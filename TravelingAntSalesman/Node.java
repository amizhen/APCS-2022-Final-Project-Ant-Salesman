/**
 * A class representing a location in which the Ant needs to arrive at per the travling salesman problem
 */
public class Node {

  private final float x;
  private final float y;

  /**
   * Constructor to create a Node at location (x,y)
   *
   * @param x The x coordinate of the Node
   * @param y the y coordinate of the Node
   */
  public Node(float x, float y) {
    this.x = x;
    this.y = y;
  }

  /**
   * Acessor for x coordinate
   * 
   * @return x coordinate
   */
  public float getX() {
    return x;
  }

  /**
   * Acessor for y coordinate
   * 
   * @return y coordinate
   */
  public float getY() {
    return y;
  }

  /**
   * A method that determines the distance between the current node and an adjacent node
   * 
   * @param adj Adjacent node
   * @return The distance between this node and the adjacent node
   */
  public float distance(Node adj) {
    return (float) Math.sqrt(Math.pow(getX() - adj.getX(), 2) + Math.pow(getY() - adj.getY(), 2));
  }

  @Override
    public String toString() {
    return String.format("Node(x=%f, y=%f)", x, y);
  }

  /**
   * Determines if two nodes are equal by their coordinates.
   * 
   * @param n Node to compare to
   * @return If the node are equal
   */
  public boolean equals(Node n) {
    return n.getX() == getX() && n.getY() == getY();
  }
}
