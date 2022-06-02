import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public static DrawableNode previousSelect = null;
public static Ant pathAnt = null;
public static boolean drawing = false;

public static final int SOLUTION = 0;
public static final int PHEROMONE = 1;

public int MODE = SOLUTION;

void setup() {
  size(1000, 1000);
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
    pathAnt = null;
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
    pathAnt = null;
    selected.move(mouseX, mouseY);
  }
}

void keyPressed() {
    switch (keyCode) {
    case 10: //Enter
      Salesman.resetPheromoneMap();
      pathAnt = Salesman.findShortestPath();
      drawing = true;
      break;
    case 8: //Delete
      Salesman.nodes.clear();
      pathAnt = null;
      break;
    case 32: //Space
      MODE = (MODE + 1) % 2; 
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


void animate(){
  
}

void genAnimate(){
  
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
  if (pathAnt != null) {
    fill(0);
    text("Distance - " + pathAnt.getDistance(), 40, 40);
  }
}
