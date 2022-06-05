public class DrawableAnt extends Ant{  
  private int pos = 0;
  
  public DrawableAnt(){
    super(Salesman.start);
  }
  
  
  void animateAntTick(int i){
    Node current = super.getNodeAt(i);
    Node prev = super.getNodeAt(i-1);
    fill(255, 0, 0);
    int x = (int)((current.getX()-prev.getX())/ANTIMATE*pos+prev.getX());
    int y = (int) ((current.getY()-prev.getY())/ANTIMATE*pos+prev.getY());
    
    ellipse(x, y, 10, 10);
    pos++;
    pos %= ANTIMATE;
  }
}
