import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public static DrawableNode previousSelect = null;
public static Ant pathAnt = null;

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
  if (keyCode == 10) { // solve
    pathAnt = Salesman.findShortestPath();
  } else if (keyCode == 8) {
    Salesman.nodes.clear();
    pathAnt = null;
  }
}

void displayAntPath(Ant ant) {
  List<DrawableNode> path = ant.getVisitedList();
  for (int i = 0; i < path.size() - 1; i++) {
    DrawableNode start = path.get(i);
    DrawableNode end = path.get(i + 1);
    line(start.getX(), start.getY(), end.getX(), end.getY());
  }
}

void draw() {
  background(255);
  
  if (pathAnt != null) {
    stroke(0);
    displayAntPath(pathAnt);
    noStroke();
  }
  
  Salesman.start.display();
  for (DrawableNode n : Salesman.nodes) {
    n.display();
  }
  
  if (pathAnt != null) {
    fill(0);
    text("Distance - " + pathAnt.getDistance(), 40, 40);
  }
}
