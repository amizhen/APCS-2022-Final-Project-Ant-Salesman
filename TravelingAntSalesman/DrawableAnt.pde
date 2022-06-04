public class DrawableAnt extends Ant{  
  private int pos = 1;
  private Node prev, current;
  
  public DrawableAnt(){
    super(Salesman.start);
  }
  
  public void startAnimate(){
    current = super.getCurrentNode();
    prev = super.getPrevNode();
  }
  
  
  public void tick() {
    
  }
  
  
  public void displayTick(){
    fill(0);
    ellipse((current.getX()+prev.getX())/24*pos, (current.getY()+prev.getY())/24*pos, 10, 10);
    pos++;
  }
}
