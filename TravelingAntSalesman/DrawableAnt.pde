public class DrawableAnt extends Ant{  
  public DrawableAnt(){
    super(Salesman.start);
  }
  
  public void display(){
    Node current = super.getCurrentNode();
    Node prev = super.getPrevNode();
    fill(0);
    ellipse((current.getX()+prev.getX())/2, (current.getY()+prev.getY())/2, 10, 10);
  }
}
