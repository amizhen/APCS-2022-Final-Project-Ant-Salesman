import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public static DrawableNode previousSelect = null;
public static Ant pathAnt = null;
public static final int ANTIMATE = 120;


public static final int SOLUTION = 0;
public static final int PHEROMONE = 1;
public static final int ERASE = 2;

public int MODE = SOLUTION;

public static final int P_INFLUENCE_COEFF = 0;
public static final int D_INFLUENCE_COEFF = 1;
public static final int P_EVAPORATION_COEFF = 2;
public static final int P_DEPOSIT_COEFF = 3;
public static int CONSTANT_SELECTED = P_INFLUENCE_COEFF;

void setup() {
  size(1000, 800);
  Salesman.start = new StartNode(width / 2, height / 2);
  Salesman.nodes = new ArrayList<DrawableNode>();
  Salesman.pheromoneMap = new HashMap<Set<DrawableNode>, Float>();
  noStroke();
  textSize(40);
}

void mouseClicked() {
  if (MODE == ERASE) {
    for (DrawableNode n : Salesman.nodes) {
      if (dist(n.getX(), n.getY(), mouseX, mouseY) < n.getDiameter()) {
        Salesman.removeNode(n);
        Salesman.resetAlgorithm();
        break;
      }
    }
  } else {
    DrawableNode newNode = new TravelNode(mouseX, mouseY);
    boolean valid = true;
    for (DrawableNode n : Salesman.nodes) {
      if (n.distance(newNode) < newNode.getDiameter()) {
        valid = false;
        break;
      }
    }
    if (valid) {
      Salesman.addNode(newNode);
      Salesman.resetAlgorithm();
      DrawableAnt.resetDraw();
    }
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
    DrawableAnt.resetDraw();
    break;
  case 8: // DELETE
    Salesman.nodes.clear();
    Salesman.pheromoneMap.clear();
    Salesman.GENERATIONS = Salesman.nodes.size() * 5;
    Salesman.resetAlgorithm();
    DrawableAnt.resetDraw();
    break;
  case 32: // SPACE
    MODE = (MODE + 1) % 3; 
    break;
  case 39: // RIGHT ARROW KEY
    if (MODE!=ERASE) {
      if (Salesman.generationCounter >= Salesman.GENERATIONS) {
        Salesman.resetAlgorithm();
      } else {
        pathAnt = Salesman.executeGeneration();
      }
      DrawableAnt.resetDraw();
      if (Salesman.nodes.size() > 0) {
        DrawableAnt.startDraw();
      }
    }
    break;
  case 87: // W key
    CONSTANT_SELECTED = --CONSTANT_SELECTED < 0 ? 3 : CONSTANT_SELECTED;
    break;
  case 83: // S key
    CONSTANT_SELECTED = (CONSTANT_SELECTED + 1) % 4;
    break;
  case 68: // D key
    modifyConstant(1);
    break;
  case 65: // A key
    modifyConstant(-1);
    break;
  }
}

void modifyConstant(int modifier) {
  switch (CONSTANT_SELECTED) {
    case P_INFLUENCE_COEFF:
      Salesman.setPheromoneInfluenceCoefficient(Salesman.getPheromoneInfluenceCoefficient() + 0.05 * modifier);
      break;
    case D_INFLUENCE_COEFF:
      Salesman.setDistanceInfluenceCoefficient(Salesman.getDistanceInfluenceCoefficient() + 0.05 * modifier);
      break;
    case P_EVAPORATION_COEFF:
      Salesman.setPheromoneEvaporationCoefficient(Salesman.getPheromoneEvaporationCoefficient() + 0.01 * modifier);
      break;
    case P_DEPOSIT_COEFF:
      Salesman.setPheromoneDepositCoefficient(Salesman.getPheromoneDepositCoefficient() + 100 * modifier);
      break;
  }
}

void displayAnts() {
  noStroke();
  if (DrawableAnt.getPos() == ANTIMATE) {
    DrawableAnt.incrementStep();
  }
  if (DrawableAnt.getStep()>=Salesman.nodes.size()) {
    DrawableAnt.resetDraw();
  }
  for (int i = Salesman.ants.length-1; i >=0; i--) {
    if (i == 0) {
      fill(0, 0, 255);
    } else {
      fill(255, 0, 0);
    }
    DrawableAnt a = Salesman.ants[i];
    Node current = a.getNodeAt(DrawableAnt.getStep()+1);
    Node prev = a.getNodeAt(DrawableAnt.getStep());
    int x = (int) ((current.getX()-prev.getX())/ANTIMATE*DrawableAnt.getPos()+prev.getX());
    int y = (int) ((current.getY()-prev.getY())/ANTIMATE*DrawableAnt.getPos()+prev.getY());

    ellipse(x, y, 10, 10);
  }
  DrawableAnt.incrementPos();
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

void displayConstants() {
  fill(0);
  textSize(20);
  text(String.format("PHEROMONE_INFLUENCE = %f", Salesman.getPheromoneInfluenceCoefficient()), width - 400, 20);
  text(String.format("DISTANCE_INFLUENCE = %f", Salesman.getDistanceInfluenceCoefficient()), width - 400, 40);
  text(String.format("PHEROMONE_EVAPORATION = %f", Salesman.getPheromoneEvaporationCoefficient()), width - 400, 60);
  text(String.format("PHEROMONE_DEPOSIT = %d", Salesman.getPheromoneDepositCoefficient()), width - 400, 80);
  fill(#00FF00);
  rect(width - 407, CONSTANT_SELECTED * 20, 5, 23);
  textSize(40);
}

void displayPheromoneMap() {
  strokeWeight(16);
  float max = 0;
  for (Set<DrawableNode> key : Salesman.pheromoneMap.keySet()) {
    max = Math.max(Salesman.pheromoneMap.get(key), max);
  }

  for (Set<DrawableNode> key : Salesman.pheromoneMap.keySet()) {
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
      if (DrawableAnt.isDrawing()) {
        displayAnts();
      }
    } else if (MODE == PHEROMONE) {
      if (DrawableAnt.isDrawing()) {
        displayAnts();
      }
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
    displayGenerationData();
  }
  
  displayConstants();
  
  String modeDisp = "Mode: " + (MODE == SOLUTION ? "Solution" : MODE == ERASE ? "Delete" : "Pheromones");

  fill(0);
  text(modeDisp, 40, 80);
}
