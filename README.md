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

***TODO***

## **Development Logs**


| Name    | Date     | Summary                                                                                                          |
|---------|----------|------------------------------------------------------------------------------------------------------------------|
| Aiden   | 05/23/22 | Started work on Ant class but realised it would make more sense to have the constants in the main written first. |
| Jeffrey | 05/23/22 | Started work on Salesman and Node class with instance variables + methods.                                       |
| Jeffrey | 05/24/22 | Mostly completed Node class and moved some methods to Salesman. Also continued work on Salesman class.           |
| Aiden   | 05/24/22 | Resolved merge conflicts, added several utility functions to the ant class.                                      |
| Aiden   | 05/25/22 | Resolved merge conflicts, added several utility functions to the ant class.                                      |
| Jeffrey | 05/25/22 | Finished Ant::pickNextNode method                                                                                |
| Jeffrey | 05/26/22 | Finished Salesman::findShortestPath method + begun testing the complete algorithm                                |
| Aiden   | 05/26/22 | Wrote Run, tick, reformatted pickNextNode                                                                        |