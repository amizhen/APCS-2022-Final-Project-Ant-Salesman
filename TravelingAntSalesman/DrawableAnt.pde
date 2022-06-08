public static class DrawableAnt extends Ant{  
  private static int pos = 0;
  private static int step = 0;
  
  public static int getPos(){
    return pos;
  }
  public static void resetPos(){
    pos = 0;
  }
  public static void incrementPos(){
    pos++;
  }
  
  public static int getStep(){
    return step;
  }
  public static void resetStep(){
    step = 0;
  }
  public static void incrementStep(){
    step++;
  }
  
  public DrawableAnt(DrawableNode start){
    super(start);
  }
}
