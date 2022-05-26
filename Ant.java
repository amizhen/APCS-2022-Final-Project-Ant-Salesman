import java.util.ArrayList;

public class Ant implements Comparable<Ant> {

    public static int WEIGHT_CONSTANT = 10000;

    private double distanceTraveled;
    private Node current;
    private final ArrayList<Node> visitedNodes;
    private final ArrayList<Node> toBeVisited;


    public Ant(Node start) {
        distanceTraveled = 0;
        visitedNodes = new ArrayList<Node>();
        toBeVisited = new ArrayList<>();
        current = start;
        //default current to the start node, add to relevant lists
    }

    private double calcPheromones() {
        return Salesman.PHEROMONE_DEPOSIT_COEFFICIENT / getDistance();
    }

    private Node getCurrentNode() {
        return current;
    }

    private int calculateWeight(Node node) { // NOTE: If the program starts to run forever, change the constant at the end
        return (int) (Math.pow(Salesman.getPheromone(node, getCurrentNode()), Salesman.PHEROMONE_INFLUENCE_COEFFICIENT) * Math.pow(1 / node.distance(current), Salesman.DISTANCE_INFLUENCE_COEFFICIENT) * WEIGHT_CONSTANT);
    }


    private Node pickNextNode(){ // TODO: Make this function only do one thing, break off other things into tick
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
        // should add fall back if everything fails
    }

    public void run() {
        toBeVisited.addAll(Salesman.nodes);
        toBeVisited.remove(current);
        visitedNodes.add(current);
        while(toBeVisited.size() > 0){
            tick();
        }
    }

    private void tick() {
        Node next = pickNextNode();
        distanceTraveled += current.distance(next);
        toBeVisited.remove(next);
        visitedNodes.add(next);
        current = next;


    }

    public void depositPheromones() {
        Node n1, n2;

        for(int i = 0; i < visitedNodes.size()-1; i++){
            n1 = visitedNodes.get(i);
            n2 = visitedNodes.get(i+1);
            Salesman.setPheromone(n1, n2, Salesman.getPheromone(n1, n2) + calcPheromones());
        }
    }

    public double getDistance() {
        return distanceTraveled;
    }

    public String getPathAsString() {
        String path = visitedNodes.get(0) + " ";
        for (int i = 1; i < visitedNodes.size(); i++) {
            path += "->" + visitedNodes.get(i) + " ";
        }
        return path;
    }

    //Comparable
    @Override
    public int compareTo(Ant other){ //MAY CHANGE
        return (int) (getDistance() - other.getDistance());
    }
}
