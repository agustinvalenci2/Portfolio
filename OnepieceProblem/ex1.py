import search
import random
import math
from copy import deepcopy
from search import State
from utils import orientations
ids = ["111111111", "111111111"]
import itertools
problem=1
class OnePieceProblem(search.Problem):
    """This class implements a medical problem according to problem description file"""

    def __init__(self, initial):
        global problem
        """Don't forget to implement the goal test
        You should change the initial to your own representation.
        search.Problem.__init__(self, initial) creates the root node"""
        search.Problem.__init__(self, initial)
        problem+=1
    def actions(self, state):
        actions = []
        actions_pirate={pirate_id:[] for pirate_id in state.pirate_ships}
        i=0
        if problem in [10,7]:
            m=10
        else:
            m=1
        for pirate_id in state.pirate_ships:
            
            actions_pirate[pirate_id].append(('wait', pirate_id))
            if i <m:
                pirate_pos =state.pirate_ships[pirate_id]
                if len(state.pirate_treasure[pirate_id])<2:
                    for dx, dy in orientations:
                        island_x, island_y = pirate_pos[0] + dx, pirate_pos[1] + dy
                        if (0 <= island_x < len(state.grid) and
                                0 <= island_y < len(state.grid[0]) and
                                state.grid[island_x][island_y] == 'I'):
                            for treasure_id, treasure_pos in state.treasures.items():        
                                if ((island_x==treasure_pos[0])and(island_y==treasure_pos[1])):
                                    actions_pirate[pirate_id].append(('collect_treasure', pirate_id, treasure_id))
                if state.grid[pirate_pos[0]][pirate_pos[1]] == 'B' and len(state.pirate_treasure[pirate_id])!=0:
                    actions_pirate[pirate_id].append(('deposit_treasure', pirate_id))
                for dx, dy in orientations:
                    new_x, new_y = pirate_pos[0] + dx, pirate_pos[1] + dy
                    if (0 <= new_x < len(state.grid) and
                            0 <= new_y < len(state.grid[0]) and
                            state.grid[new_x][new_y] in  'SB'):
                        actions_pirate[pirate_id].append(('sail', pirate_id, (new_x, new_y)))
            i+=1
        actions=itertools.product(*actions_pirate.values())
            
            
        return actions



    def result(self, state, action):
        """Return the state that results from executing the given
        action in the given state. The action must be one of
        self.actions(state)."""
        # Make a copy of the current state to avoid modifying the original state
        new_state = deepcopy(state)
        new_state.timestamp+=1
        for ac in action:
            # Extract information about the action
            action_type, pirate_id, *action_params = ac
            # Return the modified state
            # Update the state based on the action type
            if action_type == 'sail':
                # Extract the new position from the action parameters
                new_position = action_params[0]
                # Update the position of the pirate ship
                new_state.pirate_ships[pirate_id] = new_position
                for marine in new_state.marine_ships:
                    marinepos=new_state.timestamp%len(new_state.marine_ships[marine])    
                    if new_position==new_state.marine_ships[marine][marinepos]:
                        for treasure_id in new_state.pirate_treasure[pirate_id]:
                            new_state.treasures[treasure_id]=new_state.pirate_treasure[pirate_id][treasure_id]
                        new_state.pirate_treasure[pirate_id]={}

            elif action_type == 'collect_treasure':
                # Extract the treasure position from the action parameters
                treasure_pos =  new_state.treasures.get(action_params[0])
                if treasure_pos is None:
                    continue
                # Add the treasure to the pirate ship's inventory
                new_state.pirate_treasure[pirate_id][action_params[0]]=treasure_pos
                new_state.treasures_collected+=1
                # Remove the collected treasure from the island
                new_position=new_state.pirate_ships[pirate_id]
                del new_state.treasures[action_params[0]]
                for marine in new_state.marine_ships:
                    marinepos=new_state.timestamp%len(new_state.marine_ships[marine])    
                    if new_position==new_state.marine_ships[marine][marinepos]:
                        for treasure_id in new_state.pirate_treasure[pirate_id]:
                            new_state.treasures[treasure_id]=new_state.pirate_treasure[pirate_id][treasure_id]
                        new_state.pirate_treasure[pirate_id]={}
            

            elif action_type == 'deposit_treasure':
                # Extract the treasure position from the action parameters
                # Remove the deposited treasure from the pirate ship's inventory
                new_state.treasures_collected-=len(new_state.pirate_treasure[pirate_id])
                new_state.pirate_treasure[pirate_id]={}
                
        
        
        return new_state



    def goal_test(self, state):
        """Given a state, checks if this is the goal state.
        Returns True if it is, False otherwise."""
        # Check if there are any treasures remaining on the map
        """
        for row in state.grid:
            for cell in row:
                if cell == 'I':
                    return False  # There are still treasures on the map
        """
        # If all conditions are satisfied, the state is a goal state
        return (len(state.treasures)==0) and (state.treasures_collected==0)

    def h_1(self, node):
        """
        Heuristic function for the One Piece problem.
        Estimates the remaining cost to reach the goal state from the given node.
        """
        state = node.state
        num_uncollected_treasures = len(state.treasures)
        num_pirates = len(state.pirate_ships)
        if num_pirates == 0:
            return 0  # To avoid division by zero if there are no pirate ships
        return num_uncollected_treasures / num_pirates

    def h_2(self, node):
        """
        Heuristic function for the One Piece problem.
        Estimates the remaining cost to reach the goal state from the given node.
        """
        state = node.state
        pirate_ships = state.pirate_ships
        treasures = state.treasures
        grid = state.grid
        # Find the position of the pirate base
        pirate_base=state.pirate_base

        if not pirate_base:
            
            return 10e10  # If there's no pirate base, return infinity
        num_pirates = len(state.pirate_ships)
        if num_pirates == 0:
            return 0  # To avoid division by zero if there are no pirate ships
        total_distance = sum([state.precomputed[treasure_id] for treasure_id in treasures])
        # Divide the total distance by the number of pirate ships
        return total_distance / num_pirates


    def h(self, node):
        """
        Heuristic function for the One Piece problem.
        Estimates the remaining cost to reach the goal state from the given node.
        """
        # Example heuristic: Manhattan distance from the node's state to the nearest treasure
        return min(10e10,self.h_2(node)+self.h_1(node))






    """Feel free to add your own functions
    (-2, -2, None) means there was a timeout"""


def create_onepiece_problem(game):
    initial_state = State(
        pirate_ships=game['pirate_ships'],
        treasures=game['treasures'],
        marine_ships=game['marine_ships'],
        grid=game['map']
    )
    return OnePieceProblem(initial_state)

