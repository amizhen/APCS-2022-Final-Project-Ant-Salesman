public static class Salesman {
  public static DrawableNode start;
  public static List<DrawableNode> nodes;
  public static Map<Set<DrawableNode>, Float> pheromoneMap;

  // These coefficients are encapsulated to establish invariants
  
  /** Determines the effect of pheromones in the chance of the Node to be selected by the Ant */
  private static float PHEROMONE_INFLUENCE_COEFFICIENT = 1.4;
  /** Determines the effect of the distance in the chance of the Node to be selected by the Ant */
  private static float DISTANCE_INFLUENCE_COEFFICIENT = 1.6;
  /** Percentage of pheromones that remain after evaporation */
  private static float PHEROMONE_EVAPORATION_COEFFICIENT = 0.95;
  /** Determines the amount of pheromones to be dropped by an Ant */
  private static int PHEROMONE_DEPOSIT_COEFFICIENT = 1000;

  public static final int ANTS_PER_GENERATION = 20;
  public static int GENERATIONS = 50;
  public static final int TOP_ANT_SELECT_NUMBER = 5; // invariant - less than ANTS_PER_GENERATION

  public static int antCounter = 0;
  public static int generationCounter = 0;
  public static DrawableAnt[] ants = new DrawableAnt[ANTS_PER_GENERATION];

  public static float getPheromoneInfluenceCoefficient() {
    return PHEROMONE_INFLUENCE_COEFFICIENT;
  }
  
  public static float getDistanceInfluenceCoefficient() {
    return DISTANCE_INFLUENCE_COEFFICIENT;
  }
  
  public static float getPheromoneEvaporationCoefficient() {
    return PHEROMONE_EVAPORATION_COEFFICIENT;
  }
  
  public static int getPheromoneDepositCoefficient() {
     return PHEROMONE_DEPOSIT_COEFFICIENT; 
  }

  public static void setPheromoneInfluenceCoefficient(float newVal) {
    if (newVal > 0) {
      PHEROMONE_INFLUENCE_COEFFICIENT = newVal;
    }
  }
  
  public static void setDistanceInfluenceCoefficient(float newVal){
    if (newVal > 0) {
      DISTANCE_INFLUENCE_COEFFICIENT = newVal;
    }
  }
  
  public static void setPheromoneEvaporationCoefficient(float newVal) {
    if (newVal > 0 && newVal <= 1) {
      PHEROMONE_EVAPORATION_COEFFICIENT = newVal;
    }
  }
  
  public static void setPheromoneDepositCoefficient(int newVal) {
    if (newVal > 0) {
      PHEROMONE_DEPOSIT_COEFFICIENT = newVal;
    }
  }
  
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
      
      GENERATIONS = nodes.size() * 5;
    }
  }

  public static void resetPheromoneMap() {
    for (Set<DrawableNode> key : pheromoneMap.keySet()) {
      pheromoneMap.put(key, 1.0); // back to default
    }
    // println(pheromoneMap);
  }

  public static void removeNode(Node n) {
    nodes.remove(n);
    for (Node k : nodes) {
      pheromoneMap.remove(setOf(n, k));
    }
  }

  public static void clearPheromoneMap() {
    pheromoneMap.clear();
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
      pheromoneMap.replace(key, pheromoneMap.get(key) * getPheromoneEvaporationCoefficient());
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

  public static void resetAlgorithm() {
    resetPheromoneMap();
    pathAnt = null;
    antCounter = 0;
    generationCounter = 0;
    Salesman.ants = new DrawableAnt[Salesman.ANTS_PER_GENERATION];
  }

  /**
   * A method that finds attempts to find the shortest path using the Ant Colony Optimization Algorithm
   * 
   * @return The ant with the shortest path found in the final iteration
   */
  public static Ant findShortestPath() {
    for (; generationCounter < GENERATIONS; generationCounter++) {
      for (; antCounter < ANTS_PER_GENERATION; antCounter++) {
        ants[antCounter] = new DrawableAnt(start);
        ants[antCounter].run(); // have ants traverse through the map of nodes
      }
      antCounter = 0;
      Arrays.sort(ants); // sort Ants on distance traveled

      decayPheromones();
      for (int i = 0; i < TOP_ANT_SELECT_NUMBER; i++) { // have the top selected ants deposit pheromones aka smallest distance travelled
        ants[i].depositPheromones();
      }
    }
    return ants[0];
  }

  public static Ant executeGeneration() {
    for (; antCounter < ANTS_PER_GENERATION; antCounter++) {
      ants[antCounter] = new DrawableAnt(start);
      ants[antCounter].run();
    }
    antCounter = 0;
    generationCounter++;

    Arrays.sort(ants);
    decayPheromones();
    for (int i = 0; i < TOP_ANT_SELECT_NUMBER; i++) { // have the top selected ants deposit pheromones aka smallest distance travelled
      ants[i].depositPheromones();
    }
    return ants[0];
  }
}
