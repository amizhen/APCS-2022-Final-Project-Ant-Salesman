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

[//]: # (### *Non-Visual Algorithm With Standard Input*)

[//]: # ()
[//]: # (* Compile Salesman.java.)

[//]: # (* Run without arguments.)

[//]: # (* Use standard input to populate the nodes. Write one coordinate per line and format as x,y. The first coordinate is the)

[//]: # (  start node.)

[//]: # (* Result will be printed to terminal.)

[//]: # ()
[//]: # (### *Non-Visual Algorithm With File Input*)

[//]: # ()
[//]: # (* Compile Salesman.java.)

[//]: # (* Run with the filename of the input file as the argument.)

[//]: # (* The file should be in the same directory as Salesman.java, and should be formatted with one coordinate as x,y per)

[//]: # (  line.)

### *Processing Visualization*

*Prerequisites*: Processing version <= 4 

* Open the *TravelingAntSalesman.pde* file in Processing in TravelingAntSalesman directory
* Run TravelingAntSalesman.pde

*Note*: There is apparantly a bug with processing in Windows 10 where the processing window is not "focused". This means that the `keyPressed` events will not trigger unless the window is focused. To focus the window, just click on the window. 

**Features**:

* Click to place nodes in the Solution and Pheromones mode.
* Click and drag existing nodes in the Slution and Pheromones mode to move them. This includes the start node in blue.
* Use the Delete key to clear all existing green nodes.
* Click on a node in Delete mode to remove the node.
* Use the Enter key to run the algorithm and draws lines to show the "optimal" path. 
* Use the right arrow key to run through each generation and animate the ants' chosen path.
  * The blue dot is the ant with the smallest path.
  * The red dot are the other ants.
* Change the coefficients of the algorithm
  * Use the W and S key to cycle through the selected coefficient that will be changed.
  * Use the A and D key to increase and decrease the coefficient selected.
* The H key can open the help menu.

## **Development Logs**

| Name    | Date         | Summary                                                                                                                             |
| ------- | ------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| Aiden   | 05/23/22     | Started work on Ant class but realised it would make more sense to have the constants in the main written first.                    |
| Jeffrey | 05/23/22     | Started work on Salesman and Node class with instance variables + methods.                                                          |
| Jeffrey | 05/24/22     | Mostly completed Node class and moved some methods to Salesman. Also continued work on Salesman class.                              |
| Aiden   | 05/24/22     | Resolved merge conflicts, added several utility functions to the ant class.                                                         |
| Aiden   | 05/25/22     | Resolved merge conflicts, added several utility functions to the ant class.                                                         |
| Jeffrey | 05/25/22     | Finished Ant::pickNextNode method                                                                                                   |
| Jeffrey | 05/26/22     | Finished Salesman::findShortestPath method + begun testing the complete algorithm                                                   |
| Aiden   | 05/26/22     | Wrote Run, tick, reformatted pickNextNode                                                                                           |
| Aiden   | 05/27/22     | Added input function for Salesman, uses Standard input to create nodes to be traversed                                              |
| Jeffrey | 05/27/22     | Created Processing project and tested the completed ACO algorithm more                                                              |
| Jeffrey | 05/28/22     | Begun working on the Processing aspect of the project                                                                               |
| Aiden   | 05/29/22     | Wrote compile instructions and created the fileInput method for creating nodes from a given file.                                   |
| Jeffrey | 05/29/22     | Accomplished adding and moving Nodes in processing. Processing can now display the shortest path using ACO                          |
| Jeffrey | 05/30/22     | Fixed bug with program + modified constants to produce consistent solutions                                                         |
| Jeffrey | 05/31/22     | Completed pheromone map display                                                                                                     |
| Aiden   | 05/32/22     | Began work on Drawable Ant                                                                                                          |
| Jeffrey | 06/01/22     | Began working on the step by step display of the ACO algorithm                                                                      |
| Aiden   | 06/01/22     | Wrote Display for Drawable Ant.                                                                                                     |
| Jeffrey | 06/02/22     | Completed per generation display of the ACO algorithm, fixed some bugs, and moved code around for better readability                |
| Jeffrey | 06/03/22     | Added quality of life features + started on GenerateTick method                                                                     |
| Aiden   | 06/04, 06/05 | Restructured display and animate functions back into Drawable ant, now need to turn all ants in processing into drawable ants       |
| Jeffrey | 06/06/22     | Made generation number dependent on number of nodes + continued to test constants                                                   |
| Aiden   | 06/06/22     | Got ant animation working on a basic level, still needs resetting working and has some bugs. Also need to encapsulate Drawable ant. |
| Aiden   | 06/07/22     | Continued ant animation, it should be working reliably, I plan to change their positions and color.                                 |
| Aiden   | 06/08/22     | Did some debugging, de-cluttering, and formatting                                                                                   |
| Jeffrey | 06/08/22     | Began working on the feature to change coefficients at runtime                                                                      |
| Aiden   | 06/10/22     | Added delete functionality to be able to remove individual nodes.                                                                   |
| Jeffrey | 06/10/22     | Continue working on the feature to be able to adjust the coefficients of the algorithm in Processing                                |
| Jeffrey | 06/11/22     | Finalized the project by adding a help menu and cleaning up code                                                                    |