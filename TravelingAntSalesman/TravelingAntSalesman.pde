import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public static DrawableNode previousSelect = null;
public static Ant pathAnt = null;
public static boolean drawing = false;
public static final int ANTIMATE = 120;
public static int n = 0;

public static final int SOLUTION = 0;
public static final int PHEROMONE = 1;


public int MODE = SOLUTION;

void setup() {
  size(1000, 800);
  Salesman.start = new StartNode(width / 2, height / 2);
  Salesman.nodes = new ArrayList<DrawableNode>();
  Salesman.pheromoneMap = new HashMap<Set<DrawableNode>, Float>();
  noStroke();
  textSize(40);

  // test code
  // Salesman.addNodes(new TravelNode(45, 80));
}

void mouseClicked() {
  DrawableNode n = new TravelNode(mouseX, mouseY);
  if (!Salesman.nodes.contains(n)) {
    Salesman.addNode(n);
    Salesman.resetAlgorithm();
  }
}

void mouseReleased() {
  previousSelect = null;
}

void mouseDragged() {
  DrawableNode selected = previousSelect;

  if (selected == null) {
    for (DrawableNode node : Salesman.nodes) {
      if (dist(mouseX, mouseY, node.getX(), node.getY()) < node.getDiameter() / 2) {
        previousSelect = node;
        selected = node;
        break;
      }
    }

    if (selected == null && dist(mouseX, mouseY, Salesman.start.getX(), Salesman.start.getY()) < Salesman.start.getDiameter() / 2) {
      previousSelect = Salesman.start;
      selected = Salesman.start;
    }
  }

  if (selected != null) {
    Salesman.resetAlgorithm();
    selected.move(mouseX, mouseY);
  }
}

void keyPressed() {
  switch (keyCode) {
  case 10: // ENTER
    if (Salesman.generationCounter >= Salesman.GENERATIONS) {
      Salesman.resetAlgorithm();
    }
    pathAnt = Salesman.findShortestPath();
    break;
  case 8: // DELETE
    Salesman.nodes.clear();
    Salesman.pheromoneMap.clear();
    Salesman.resetAlgorithm();
    break;
  case 32: // SPACE
    MODE = (MODE + 1) % 2; 
    break;
  case 39: // RIGHT ARROW KEY
    if (Salesman.generationCounter >= Salesman.GENERATIONS) {
      Salesman.resetAlgorithm();
    }
    drawing = true;
    pathAnt = Salesman.executeGeneration();
    break;
  case 16: // SHIFT KEY
    break;
  }
}



void displayAntPath(Ant ant) {
  strokeWeight(4);
  List<DrawableNode> path = ant.getVisitedList();
  for (int i = 0; i < path.size() - 1; i++) {
    DrawableNode start = path.get(i);
    DrawableNode end = path.get(i + 1);
    line(start.getX(), start.getY(), end.getX(), end.getY());
  }
}

void displayPheromoneMap() {
  strokeWeight(16);
  float max = 0;
  for (Set<DrawableNode> key : Salesman.pheromoneMap.keySet()) {
    max = Math.max(Salesman.pheromoneMap.get(key), max);
  }

  for (Set<DrawableNode> key : Salesman.pheromoneMap.keySet()) {
    // opacity of the edge is determined by comparing it to the largest edge pheromone level
    // use squares as it will lead to lower pheromone levels being displayed less
    // stroke(255, 0, 255, (float) (Math.pow(Salesman.pheromoneMap.get(key), 0.12 * Salesman.nodes.size()) / Math.pow(max, 0.12 * Salesman.nodes.size()) * 150));

    stroke(255, 0, 255, Salesman.pheromoneMap.get(key) / max * 150);
    DrawableNode[] nodes = key.toArray(new DrawableNode[2]);
    line(nodes[0].getX(), nodes[0].getY(), nodes[1].getX(), nodes[1].getY());
  }
  strokeWeight(4);
}

void displayGenerationData() {
  fill(0);
  text(String.format("Generation %d / %d", Salesman.generationCounter, Salesman.GENERATIONS), 20, height - 20);
}


void draw() {
  background(255);

  if (pathAnt != null) {
    if (MODE == SOLUTION) {
      stroke(0);
      displayAntPath(pathAnt);
    } else if (MODE == PHEROMONE) {
      displayPheromoneMap();
    }
    noStroke();
  }

  Salesman.start.display();
  for (DrawableNode n : Salesman.nodes) {
    n.display();
  }
  //Loop for ant display
  //if(drawing){
  //  for(Ant a : Salesman.ants){
  //    a.animateAntTick(n);
  //  }
  //  n++;
  //  if(n==Salesman.nodes.size()){
  //    n = 0;
  //    drawing = false;
  //  }
  //} :TODO NEED TO UPDATE ALL ANTS TO DRAWABLE ANTS FIRST
  

  if (pathAnt != null) {
    fill(0);
    text("Distance - " + pathAnt.getDistance(), 40, 40);
    displayGenerationData();
  }
}
