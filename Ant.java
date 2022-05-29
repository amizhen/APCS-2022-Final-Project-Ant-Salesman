import java.util.ArrayList;

/**
 * The Ant class that traverse through the map of Nodes
 */
public class Ant implements Comparable<Ant> {

    /**
     * Determines the weight of an edge being a chosen path
     */
    public static int WEIGHT_CONSTANT = 10000;

    private double distanceTraveled;
    private Node current;
    private final ArrayList<Node> visitedNodes;
    private final ArrayList<Node> toBeVisited;

    /**
     * Constructor for the Ant object.
     *
     * @param start The Node the Ant starts on
     */
    public Ant(Node start) {
        distanceTraveled = 0;
        visitedNodes = new ArrayList<Node>();
        toBeVisited = new ArrayList<>();
        current = start;
        //default current to the start node, add to relevant lists
    }

    /**
     * Calculates the pheromones to be dropped. Should be only called when the ant does not have any
     * nodes to travel to.
     *
     * @return The amount of pheromones dropped at an edges along the path
     */
    private double calcPheromones() {
        return Salesman.PHEROMONE_DEPOSIT_COEFFICIENT / getDistance();
    }

    private Node getCurrentNode() {
        return current;
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
        return (int) (Math.pow(Salesman.getPheromone(node, getCurrentNode()), Salesman.PHEROMONE_INFLUENCE_COEFFICIENT) * Math.pow(1 / node.distance(getCurrentNode()), Salesman.DISTANCE_INFLUENCE_COEFFICIENT) * WEIGHT_CONSTANT);
    }


    /**
     * Selects the next node to be chosen based on the pheromone map and its distance
     *
     * @return The Node that was chosen to be traversed towards
     */
    private Node pickNextNode() {
        int sum = toBeVisited.stream().mapToInt(this::calculateWeight).sum();
        int choice = (int) (Math.random() * sum);
        int rand = 0;
        for (Node node : toBeVisited) {
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
        Node next = pickNextNode();
        distanceTraveled += current.distance(next);
        toBeVisited.remove(next);
        visitedNodes.add(next);
        current = next;
    }

    /**
     * Method that has the ant deposit pheromones on the edges the Ant travels
     */
    public void depositPheromones() {
        Node n1, n2;

        for (int i = 0; i < visitedNodes.size() - 1; i++) {
            n1 = visitedNodes.get(i);
            n2 = visitedNodes.get(i + 1);
            Salesman.setPheromone(n1, n2, (Salesman.getPheromone(n1, n2) + calcPheromones()));
        }
    }

    /**
     * A method that returns the distance the ant has traveled.
     *
     * @return The distance the ant has traveled
     */
    public double getDistance() {
        return distanceTraveled;
    }

    /**
     * A method that returns a visual representation of the path the ant has taken
     *
     * @return A string displaying the path the ant as taken
     */
    public String getPathAsString() {

        String path = "PATH TAKEN [Start -> End]\n";
        for (Node node : visitedNodes) {
            path += node + "\n";
        }
        return path;
    }

    //Comparable
    @Override
    public int compareTo(Ant other) { //MAY CHANGE
        return (int) (getDistance() - other.getDistance());
    }
}
