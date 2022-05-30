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

  // test code
  // Salesman.addNodes(new TravelNode(45, 80));
}

void mouseClicked() {
  DrawableNode n = new TravelNode(mouseX, mouseY);
  if (!Salesman.nodes.contains(n)) {
    Salesman.addNode(n);
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
    selected.move(mouseX, mouseY);
  }
}

void keyPressed() {
  if (keyCode == 10) {
    pathAnt = Salesman.findShortestPath();
    print(pathAnt.getPathAsString());
  }
}

void draw() {
  background(255);
  Salesman.start.display();
  for (DrawableNode n : Salesman.nodes) {
    n.display();
  }
}
