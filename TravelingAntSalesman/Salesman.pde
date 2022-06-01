public static class Salesman {
  public static DrawableNode start;
  public static List<DrawableNode> nodes;
  private static Map<Set<DrawableNode>, Float> pheromoneMap;

  /** Determines the effect of pheromones in the chance of the Node to be selected by the Ant */
  public static float PHEROMONE_INFLUENCE_COEFFICIENT = 1.6;
  /** Determines the effect of the distance in the chance of the Node to be selected by the Ant */
  public static float DISTANCE_INFLUENCE_COEFFICIENT = 1.05;
  /** Percentage of pheromones that remain after evaporation */
  public static float PHEROMONE_EVAPORATION_COEFFICIENT = 0.90;
  /** Determines the amount of pheromones to be dropped by an Ant */
  public static float PHEROMONE_DEPOSIT_COEFFICIENT = 1000;


  // Perhaps this can be dynamically determined. Look into this later
  public static final int ANTS_PER_GENERATION = 10;
  public static final int GENERATIONS = 100;
  public static final int TOP_ANT_SELECT_NUMBER = 1; // invariant - less than ANTS_PER_GENERATION

  /**
   * A method to add an individual Node to the system. Updates nodes and the pheromone map.
   * 
   * @param n The node to add
   */
  public static void addNode(DrawableNode n) {
    if (!nodes.contains(n)) {
      for (DrawableNode node : nodes) {
        pheromoneMap.put(setOf(n, node), 1.0);
      }
      pheromoneMap.put(setOf(n, start), 1.0);
      nodes.add(n);
    }
  }
  
  public static void resetPheromoneMap() {
    for (DrawableNode n : nodes) {
      for (DrawableNode m : nodes) {
        if (n != m) {
          pheromoneMap.put(setOf(n, m), 1.0);
        }
      }
    }
  }

  /**
   * A method to add multiple Nodes to the system. Updates nodes and the pheromone map.
   * 
   * @param nodes The nodes to add
   */
  public static void addNodes(DrawableNode... nodes) {
    for (DrawableNode node : nodes) {
      addNode(node);
    }
  }

  /**
   * A method to decay all the edges in the pheromone map. The decay is based on the PHEROMONE_EVAPORATION_COEFFICIENT
   */
  public static void decayPheromones() {
    for (Set<DrawableNode> key : pheromoneMap.keySet()) {
      pheromoneMap.replace(key, pheromoneMap.get(key) * PHEROMONE_EVAPORATION_COEFFICIENT);
    }
  }

  public static <T> Set<T> setOf(T t1, T t2) {
    Set<T> map = new HashSet<T>(2);
    map.add(t1);
    map.add(t2);
    return map;
  }

  /**
   * A method to returns the pheromone level found between two nodes.
   * 
   * @param n1 One of the two nodes forming the edge
   * @param n2 One of the two nodes forming the edge
   * @return The pheromone level at edge n1 to n2
   */
  public static float getPheromone(Node n1, Node n2) {
    return pheromoneMap.get(setOf(n1, n2));
  }

  /**
   * A method that sets the pheromone level found between two nodes to a new pheromone level
   * 
   * @param n1 One of the two nodes forming the edge
   * @param n2 One of the two nodes forming the edge
   * @param newVal The set pheromone level at edge n1 to n2
   */
  public static void setPheromone(DrawableNode n1, DrawableNode n2, float newVal) {
    Set<DrawableNode> key = setOf(n1, n2);
    pheromoneMap.replace(key, newVal);
  }

  /**
   * A method that finds attempts to find the shortest path using the Ant Colony Optimization Algorithm
   * 
   * @return The ant with the shortest path found in the final iteration
   */
  public static Ant findShortestPath() {
    Ant[] ants = new Ant[ANTS_PER_GENERATION];

    for (int j = 0; j < GENERATIONS; j++) {
      for (int i = 0; i < ANTS_PER_GENERATION; i++) {
        ants[i] = new Ant(start);
        ants[i].run(); // have ants traverse through the map of nodes
      }
      Arrays.sort(ants); // sort Ants on distance travelled

      decayPheromones();
      for (int i = 0; i < TOP_ANT_SELECT_NUMBER; i++) { // have the top selected ants deposit pheromones aka smallest distance travelled
        ants[i].depositPheromones();
      }
    }

    return ants[0];
  }
}
