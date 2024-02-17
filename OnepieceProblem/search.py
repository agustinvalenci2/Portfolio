"""Search (Chapters 3-4)

The way to use this code is to subclass Problem to create a class of problems,
then create problem instances and solve them with calls to the various search
functions."""

from utils import (
    is_in, argmin, argmax, argmax_random_tie, probability, weighted_sampler,
    memoize, print_table, open_data, Stack, FIFOQueue, PriorityQueue, name,
    distance,orientations
)

from collections import defaultdict
import math
import random
import sys
import bisect

infinity = float('inf')

# ______________________________________________________________________________

class State:
    def __init__(self, pirate_ships, treasures, marine_ships, grid):
        self.pirate_ships = pirate_ships
        self.treasures = treasures
        self.marine_ships = marine_ships
        self.timestamp=0
        self.grid = grid
        self.pirate_treasure = None
        self.pirate_base=None
        self.precomputed={}
        self.treasures_collected=0
        if self.pirate_treasure is None:
            self.pirate_treasure={p:{} for p in pirate_ships}
            
            for marine in self.marine_ships:
                self.marine_ships[marine]=self.marine_ships[marine]+list(reversed(self.marine_ships[marine][1:-1]))
            for i in range(len(self.grid)):
                for j in range(len(self.grid[i])):
                    if self.grid[i][j] == 'B':
                        self.pirate_base = (i, j)
                        break
                if self.pirate_base:
                    break
            for treasure_id,treasure_pos in treasures.items():
                # Check adjacent cells to the treasure
                adjacent_cells = [(treasure_pos[0] + dx, treasure_pos[1] + dy) for dx, dy in orientations]
                is_adjacent_to_island = all(grid[x][y] == 'I' for x, y in adjacent_cells if 0 <= x < len(grid) and 0 <= y < len(grid[0]))
                if is_adjacent_to_island:
                    self.precomputed[treasure_id]= 10e3
                    continue  # If all adjacent cells are islands, return infinity
                # Calculate the distance from the pirate base to the closest sea cell adjacent to the treasure
                min_distance_to_sea = min(distance(self.pirate_base,(x,y)) for x, y in adjacent_cells if 0 <= x < len(grid) and 0 <= y < len(grid[0]) and grid[x][y] == 'S')
                self.precomputed[treasure_id]=min_distance_to_sea
    def __eq__(self, other):
        """Check if two states are equal."""
        return (self.pirate_ships,
                     self.treasures,
                     self.pirate_treasure,
                     #self.timestamp,
                       [self.timestamp%len(x) for x in self.marine_ships.values()]
                     ) ==(other.pirate_ships,
                     other.treasures,
                     other.pirate_treasure,
                     #other.timestamp,
                     [other.timestamp%len(x) for x in other.marine_ships.values()])
    def __lt__(self,other):
        return (len(self.treasures)+self.treasures_collected)<(len(other.treasures)+other.treasures_collected)

    def __hash__(self):
        """Hash function for the state."""
        return hash((tuple(self.pirate_ships.values()),
                     frozenset(self.treasures.values()),
                     tuple(map(lambda x: tuple(x),self.pirate_treasure.values())),
                     #self.timestamp,
                     tuple([self.timestamp%len(x) for x in self.marine_ships.values()])))

    def __repr__(self):
        """String representation of the state."""
        return f"State(pirate_ships={self.pirate_ships}, treasures={self.treasures}, marine_ships={self.marine_ships}, grid={self.grid})"

class Problem(object):

    """The abstract class for a formal problem.  You should subclass
    this and implement the methods actions and result, and possibly
    __init__, goal_test, and path_cost. Then you will create instances
    of your subclass and solve them with the various search functions."""

    def __init__(self, initial, goal=None):
        """The constructor specifies the initial state, and possibly a goal
        state, if there is a unique goal.  Your subclass's constructor can add
        other arguments."""
        self.initial = initial
        self.goal = goal

    def actions(self, state):
        """Return the actions that can be executed in the given
        state. The result would typically be a list, but if there are
        many actions, consider yielding them one at a time in an
        iterator, rather than building them all at once."""
        raise NotImplementedError

    def result(self, state, action):
        """Return the state that results from executing the given
        action in the given state. The action must be one of
        self.actions(state)."""
        raise NotImplementedError

    def goal_test(self, state):
        """Return True if the state is a goal. The default method compares the
        state to self.goal or checks for state in self.goal if it is a
        list, as specified in the constructor. Override this method if
        checking against a single self.goal is not enough."""
        if isinstance(self.goal, list):
            return is_in(state, self.goal)
        else:
            return state == self.goal

    def path_cost(self, c, state1, action, state2):
        """Return the cost of a solution path that arrives at state2 from
        state1 via action, assuming cost c to get up to state1. If the problem
        is such that the path doesn't matter, this function will only look at
        state2.  If the path does matter, it will consider c and maybe state1
        and action. The default method costs 1 for every step in the path."""
        return c + 1

    def value(self, state):
        """For optimization problems, each state has a value.  Hill-climbing
        and related algorithms try to maximize this value."""
        raise NotImplementedError
# ______________________________________________________________________________


class Node:

    """A node in a search tree. Contains a pointer to the parent (the node
    that this is a successor of) and to the actual state for this node. Note
    that if a state is arrived at by two paths, then there are two nodes with
    the same state.  Also includes the action that got us to this state, and
    the total path_cost (also known as g) to reach the node.  Other functions
    may add an f and h value; see best_first_graph_search and astar_search for
    an explanation of how the f and h values are handled. You will not need to
    subclass this class."""

    def __init__(self, state, parent=None, action=None, path_cost=0):
        """Create a search tree Node, derived from a parent by an action."""
        self.state = state
        self.parent = parent
        self.action = action
        self.path_cost = path_cost
        self.depth = 0
        if parent:
            self.depth = parent.depth + 1

    def __repr__(self):
        return "<Node {}>".format(self.state)

    def __lt__(self, node):
        return self.state < node.state

    def expand(self, problem):
        """List the nodes reachable in one step from this node."""
        
        return [self.child_node(problem, action)
                for action in problem.actions(self.state)]

    def child_node(self, problem, action):
        """[Figure 3.10]"""
        next = problem.result(self.state, action)
        return Node(next, self, action,
                    problem.path_cost(self.path_cost, self.state,
                                      action, next))

    def solution(self):
        """Return the sequence of actions to go from the root to this node."""
        return [node.action for node in self.path()[1:]]

    def path(self):
        """Return a list of nodes forming the path from the root to this node."""
        node, path_back = self, []
        while node:
            path_back.append(node)
            node = node.parent
        return list(reversed(path_back))

    # We want for a queue of nodes in breadth_first_search or
    # astar_search to have no duplicated states, so we treat nodes
    # with the same state as equal. [Problem: this may not be what you
    # want in other contexts.]

    def __eq__(self, other):
        return isinstance(other, Node) and self.state == other.state

    def __hash__(self):
        return hash(self.state)

# ______________________________________________________________________________


from utils import PriorityQueue
from collections import deque
import heapq
def astar_search(problem, h=None):
    """A* search is best-first graph search with f(n) = g(n)+h(n).
    You need to specify the h function when you call astar_search, or
    else in your Problem subclass."""
    
    if h is None:
        h = problem.h  # Use the default heuristic function from the problem

    # Initialize the frontier using a priority queue
    frontier = []
    # Add the initial node to the frontier
    frontier.append((0,Node(problem.initial)))

    # Initialize an empty dictionary to keep track of the best path cost to each state
    best_path_cost = {problem.initial: 0}
    depth=40
    # Iterate until the frontier is empty
    while frontier:
        # Pop the node with the lowest f(n) value from the frontier
        c,node = heapq.heappop(frontier)

        # If the node contains a goal state, return the solution
        if problem.goal_test(node.state):
            return node
        # Expand the current node and add its children to the frontier
        for child in node.expand(problem):
            # Calculate the child's path cost
            new_path_cost = node.path_cost + 1

            # If the child state has not been visited or has a better path cost, update it
            if child.state not in best_path_cost or new_path_cost < best_path_cost[child.state]:
                best_path_cost[child.state] = new_path_cost
                child.path_cost = new_path_cost
                try:
                    heapq.heappush(frontier,(int(new_path_cost + h(child)),child))
                except OverflowError:
                    return None

    # If the frontier is empty and no goal state is found, return None (no solution)
    return None






