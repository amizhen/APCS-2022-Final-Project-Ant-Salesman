
public class DrawableNode extends Node {

  private color colour;
  private int diameter;

  public DrawableNode(float x, float y, color c, int diameter) {
    super(x, y);
    this.diameter = diameter;
    colour = c;
  }

  public void move(float x, float y) {
    setX(x);
    setY(y);
  }

  public void display() {
    fill(colour);
    ellipse(getX(), getY(), diameter, diameter);
  }

  public float getDiameter() {
    return diameter;
  }
}

public class TravelNode extends DrawableNode {
  public TravelNode(float x, float y) {
    super(x, y, #00FF00, 25);
  }
}

public class StartNode extends DrawableNode {
  public StartNode(float x, float y) {
    super(x, y, #0000FF, 25);
  }
}
