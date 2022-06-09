# **The Traveling Ant Salesmen**

Created by Aiden Mizhen and Jeffrey Jiang

[**Complete
Proposal**](https://docs.google.com/document/d/1Vkc-bQuLZKICPwXoo_w7NjEORyUwMkhjVnNt5RsR-es/edit?usp=sharing)

## **Project Description**

Our plan for the project is to implement a heuristic algorithm to the famous **traveling salesman problem** which models
ant colony behavior. Because the brute force solution of the problem has a time complexity of `O(n!)`, many algorithms
have been sought out to reduce it. This algorithm, called the **Ant Colony Optimization (ACO)** attempts to emulate how
ants emergently find the shortest path between points through their use of pheromones. This project will also expand
through adding constraints to the traveling salesman problem and modifying the algorithm with other variations. This all
will be visualized through Processing.

## **Compile/Run Instructions**

### *Non-Visual Algorithm With Standard Input*

* Compile Salesman.java.
* Run without arguments.
* Use standard input to populate the nodes. Write one coordinate per line and format as x,y. The first coordinate is the
  start node.
* Result will be printed to terminal.

### *Non-Visual Algorithm With File Input*

* Compile Salesman.java.
* Run with the filename of the input file as the argument.
* The file should be in the same directory as Salesman.java, and should be formatted with one coordinate as x,y per
  line.

### *Processing Visualization*

*Prerequisites*: Processing version <= 4 

* Open the *TravelingAntSalesman.pde* file in Processing in TravelingAntSalesman directory
* Run TravelingAntSalesman.pde

**Features**:

* Click to place nodes.
* Click and drag existing nodes to move them. This includes the start node in blue.
* Use the Delete key to clear all existing green nodes.
* Use the Enter key to run the algorithm and draws lines to show the "optimal" path. 

## **Development Logs**

| Name    | Date        | Summary                                                                                                                             |
|---------|-------------|-------------------------------------------------------------------------------------------------------------------------------------|
| Aiden   | 05/23/22    | Started work on Ant class but realised it would make more sense to have the constants in the main written first.                    |
| Jeffrey | 05/23/22    | Started work on Salesman and Node class with instance variables + methods.                                                          |
| Jeffrey | 05/24/22    | Mostly completed Node class and moved some methods to Salesman. Also continued work on Salesman class.                              |
| Aiden   | 05/24/22    | Resolved merge conflicts, added several utility functions to the ant class.                                                         |
| Aiden   | 05/25/22    | Resolved merge conflicts, added several utility functions to the ant class.                                                         |
| Jeffrey | 05/25/22    | Finished Ant::pickNextNode method                                                                                                   |
| Jeffrey | 05/26/22    | Finished Salesman::findShortestPath method + begun testing the complete algorithm                                                   |
| Aiden   | 05/26/22    | Wrote Run, tick, reformatted pickNextNode                                                                                           |
| Aiden   | 05/27/22    | Added input function for Salesman, uses Standard input to create nodes to be traversed                                              |
| Jeffrey | 05/27/22    | Created Processing project and tested the completed ACO algorithm more                                                              |
| Jeffrey | 05/28/22    | Begun working on the Processing aspect of the project                                                                               |
| Aiden   | 05/29/22    | Wrote compile instructions and created the fileInput method for creating nodes from a given file.                                   |
| Jeffrey | 05/29/22    | Accomplished adding and moving Nodes in processing. Processing can now display the shortest path using ACO                          |
| Jeffrey | 05/30/22    | Fixed bug with program + modified constants to produce consistent solutions                                                         |
| Jeffrey | 05/31/22    | Completed pheromone map display                                                                                                     |
| Aiden   | 05/32/22    | Began work on Drawable Ant                                                                                                          |
| Jeffrey | 06/01/22    | Began working on the step by step display of the ACO algorithm                                                                      |
| Jeffrey | 06/02/22    | Completed per generation display of the ACO algorithm, fixed some bugs, and moved code around for better readability                |
| Aiden   | 06/01/22    | Wrote Display for Drawable Ant.                                                                                                     |
| Aiden   | 06/04-05/22 | Restructured display and animate functions back into Drawable ant, now need to turn all ants in processing into drawable ants       |
| Aiden   | 06/06/22    | Got ant animation working on a basic level, still needs resetting working and has some bugs. Also need to encapsulate Drawable ant. |
| Aiden   | 06/07/22    | Continued ant animation, it should be working reliably, I plan to change their positions and color.                                 |
| Aiden   | 06/08/22    | Did some debugging, de-cluttering, and formatting                                                                                   |