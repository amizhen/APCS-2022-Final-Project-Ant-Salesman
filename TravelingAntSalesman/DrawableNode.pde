
public class DrawableNode extends Node {

  private color colour;
  private int diameter;

  public DrawableNode(float x, float y, color c, int diameter) {
    super(x, y);
    colour = c;
  }

  public void draw() {
    fill(colour);
    ellipse(getX(), getY(), diameter, diameter);
  }
}
