import java.util.ArrayList; //<>// //<>//
import java.util.Collections;

/**
 * The Ant class that traverse through the map of Nodes
 */
public static class Ant implements Comparable<Ant> {

  /** Determines the weight of an edge being a chosen path */
  public static final int WEIGHT_CONSTANT = 100000;

  private float distanceTraveled;
  private DrawableNode current;
  private final ArrayList<DrawableNode> visitedNodes;
  private final ArrayList<DrawableNode> toBeVisited;

  /**
   * Constructor for the Ant object.
   * 
   * @param start The Node the Ant starts on
   */
  public Ant(DrawableNode start) {
    distanceTraveled = 0;
    visitedNodes = new ArrayList<DrawableNode>();
    toBeVisited = new ArrayList<DrawableNode>();
    current = start;
    //default current to the start node, add to relevant lists
  }

  /**
   * Calculates the pheromones to be dropped. Should be only called when the ant does not have any 
   * nodes to travel to.
   * 
   * @return The amount of pheromones dropped at an edges along the path
   */
  private float calcPheromones() {
    return Salesman.PHEROMONE_DEPOSIT_COEFFICIENT / getDistance();
  }

  public Node getCurrentNode() {
    return current;
  }

  public Node getPrevNode() {
    return visitedNodes.get(visitedNodes.size()-2);
  }

  public Node getNodeAt(int i) {
    return visitedNodes.get(i);
  }

  /*
    Note: The reason why the random uses integer values is because floating point values can cause 
   floating point arithmetic errors leading to infinite loops.
   */

  /**
   * Calculates the weight of a edge to be chosen to be traversed.
   * 
   * @param node The node that forms the edge with the current node
   * @return The weight of the edge to be chosen
   */
  private int calculateWeight(Node node) { 
    int weight = (int) (Math.pow(Salesman.getPheromone(node, getCurrentNode()), Salesman.PHEROMONE_INFLUENCE_COEFFICIENT) * Math.pow(1 / node.distance(getCurrentNode()), Salesman.DISTANCE_INFLUENCE_COEFFICIENT) * WEIGHT_CONSTANT);
    return Math.max(1, weight);
  }



  /**
   * Selects the next node to be chosen based on the pheromone map and its distance
   * 
   * @return The Node that was chosen to be traversed towards
   */
  private DrawableNode pickNextNode() {
    int sum = 0;
    for (DrawableNode n : toBeVisited) sum += calculateWeight(n);

    int choice = (int) (Math.random() * sum);
    int rand = 0;
    for (DrawableNode node : toBeVisited) {
      rand += calculateWeight(node);
      if (choice < rand) {
        return node;
      }
    }
    return current;
  }

  /**
   * Executes the Ant to traverse through the whole map. 
   */
  public void run() {
    toBeVisited.addAll(Salesman.nodes);
    visitedNodes.add(current);
    while (toBeVisited.size() > 0) {
      tick();
    }
  }

  /**
   * Represents the Ant moving to the next node.
   */
  private void tick() {
    DrawableNode next = pickNextNode();
    distanceTraveled += current.distance(next);
    toBeVisited.remove(next);
    visitedNodes.add(next);
    current = next;
  }

  /**
   * Method that has the ant deposit pheromones on the edges the Ant travels
   */
  public void depositPheromones() {
    DrawableNode n1, n2;

    for (int i = 0; i < visitedNodes.size()-1; i++) {
      n1 = visitedNodes.get(i);
      n2 = visitedNodes.get(i+1);
      Salesman.setPheromone(n1, n2, Salesman.getPheromone(n1, n2) + calcPheromones());
    }
  }

  public boolean isActive() {
    return !toBeVisited.isEmpty();
  }

  /**
   * A method that returns the distance the ant has traveled.
   * 
   * @return The distance the ant has traveled
   */
  public float getDistance() {
    return distanceTraveled;
  }

  /**
   * A method that returns a visual representation of the path the ant has taken
   * 
   * @return A string displaying the path the ant as taken
   */
  public String getPathAsString() {

    String path = "PATH TAKEN [Start -> End]\n";
    for (int i = 0; i < visitedNodes.size(); i++) {
      path += visitedNodes.get(i) + "\n";
    }
    return path;
  }

  //Comparable
  @Override
    public int compareTo(Ant other) { //MAY CHANGE
    return (int) (getDistance() - other.getDistance());
  }

  // processing code

  public List<DrawableNode> getVisitedList() {
    return Collections.unmodifiableList(visitedNodes);
  }
}
