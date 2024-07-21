from ctypes import sizeof
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import math

import random

import os
from flask import Flask, request, jsonify,send_from_directory,send_file
app = Flask(__name__)

#IMAGE_FOLDER = 'C:\\Users\\olabu\\Desktop\\csp2'

IMAGE_FOLDER = r'C:\\Users\\olabu\\Desktop\\csp2'
IMAGE_FILENAME = 'floorplan.png'

# @app.route('/image/floorplan.png', methods=['GET'])
# def get_image(filename):
#     return send_from_directory(IMAGE_FOLDER, filename)

@app.route('/receive_data', methods=['POST'])
def receive_data():
    try:
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        total_area = data['total_area']
        selected_rooms = data['selected_rooms']

        print('Data received:', total_area, selected_rooms)

        # Call the main function with the received data
        main(selected_rooms, total_area)
        #return jsonify({"status": "Data processed successfully"}),200
        response = {
            'image_url': f'http://10.0.2.2:5000/image/{IMAGE_FILENAME}'
        }
        print('Sending response:', response)
        return jsonify(response),200

    except Exception as e:
        print('An error occurred:', e)
        return jsonify({"status": "Error", "message": str(e)})

@app.route('/image/<filename>', methods=['GET'])
def serve_image(filename):
    try:
        return send_file(os.path.join(IMAGE_FOLDER, filename))
    except Exception as e:
        print('An error occurred while serving the image:', e)
        return jsonify({"status": "Error", "message": str(e)}), 500

class CSP:
    def __init__(self, variables, domains, constraints):
        self.variables = variables
        self.domains = domains
        self.constraints = constraints
        self.solution = None

    def solve(self):
        assignment = {}
        self.solution = self.backtrack(assignment)
        return self.solution

    def backtrack(self, assignment):
        if len(assignment) == len(self.variables):
            return assignment

        var = self.select_unassigned_variable(assignment)
        for value in self.order_domain_values(var, assignment):
            if self.is_consistent(var, value, assignment):
                assignment[var] = value
                result = self.backtrack(assignment)
                if result is not None:
                    return result
                del assignment[var]
        return None
    
    def select_unassigned_variable(self, assignment):
        priority_order = ["LivingRoom1", "Kitchen1", "Entrance", "GuestRoom"]
        for var in priority_order:
            if var not in assignment and var in self.variables:
                return var
        unassigned_vars = [var for var in self.variables if var not in assignment]
        return min(unassigned_vars, key=lambda var: len(self.domains[var]))


    def order_domain_values(self, var, assignment):
        return self.domains[var]

    def is_consistent(self, var, value, assignment):
        if var in self.constraints:
            for other_var, constraint_funcs in self.constraints[var].items():
                if other_var == var:
                    for constraint_func in constraint_funcs:
                        if not constraint_func(var, value):
                            return False
                if other_var in assignment:
                    for constraint_func in constraint_funcs:
                        if not constraint_func(var, value, other_var, assignment[other_var]):
                            return False
        return True


def calculate_wasted_area(area):
    return area * 0.9

def draw_floorplan(solution, fitting_rooms_dict, total_area):
    grid_size = int(math.sqrt(total_area))
    fig, ax = plt.subplots()
    ax.set_xlim(0, grid_size)
    ax.set_ylim(0, grid_size)
    colors = plt.get_cmap('tab20', len(solution))

    for idx, (room, (x, y, w, h)) in enumerate(solution.items()):
        rect = patches.Rectangle((x, y), w, h, edgecolor='black', facecolor='snow')
        ax.add_patch(rect)
        plt.text(x + w / 2, y + h / 2, room, ha='center', va='center', fontsize=8)

    output_filename=r'C:\Users\olabu\Desktop\imageupload\imageupload\floorplan.png'

    plt.gca().set_aspect('equal', adjustable='box')
    plt.savefig(output_filename)
    #plt.show()
    plt.close()


def go_solving(total_area, selected_rooms):
    room_size_ranges = {
        "Bedroom": (5, 20),
        "MasterBedroom": (7, 20),
        "LivingRoom": (13, 30),
        "Kitchen": (5, 20),
        "GuestRoom": (10, 30),
        "Store": (3, 6),
        "Balcony": (5, 10),
        "Bathroom": (2, 5),
        "Entrance": (3, 5),
    }

    items = {
        1: "Bedroom1", 2: "Bedroom2", 3: "Bedroom3", 4: "MasterBedroom1", 5: "MasterBedroom2",
        6: "LivingRoom1", 7: "LivingRoom2", 8: "GuestRoom", 9: "Balcony1", 10: "Balcony2",
        11: "Kitchen1", 12: "Kitchen2", 13: "Store1", 14: "Store2", 15: "Entrance",
        16: "Bathroom1", 17: "Bathroom2", 18: "Bathroom3"
    }

    usable_area = total_area
    fitting_rooms_dict = {}

    for room in selected_rooms:
        #room = items[num]
        room_type = ''.join(filter(str.isalpha, room))
        min_size, max_size = room_size_ranges[room_type]
        room_size = (random.uniform(min_size, max_size) / 100.0 )* total_area
        if room_size <= usable_area:
            width=math.floor(room_size**0.5)
            length=math.floor(room_size//width)
            fitting_rooms_dict[room] = [math.floor(room_size), width, length]
            usable_area -= math.floor(room_size)
        else:
            #print(f"Not enough space for {room}.")
            return None, fitting_rooms_dict,items,usable_area



    grid_size = int(math.sqrt(total_area))
    domains = {}
    for room in fitting_rooms_dict.keys():
        w, h = fitting_rooms_dict[room][1], fitting_rooms_dict[room][2]
        domains[room] = [(x, y) for x in range(grid_size - w + 1) for y in range(grid_size - h + 1)]

    def no_overlap(room1, loc1, room2, loc2):
        x1, y1, w1, h1 = loc1[0], loc1[1], fitting_rooms_dict[room1][1], fitting_rooms_dict[room1][2]
        x2, y2, w2, h2 = loc2[0], loc2[1], fitting_rooms_dict[room2][1], fitting_rooms_dict[room2][2]
        return (x1 + w1 <= x2 or x2 + w2 <= x1 or y1 + h1 <= y2 or y2 + h2 <= y1)

    def center_livingroom(room, loc, grid_size):
        x, y, w, h = loc[0], loc[1], fitting_rooms_dict[room][1], fitting_rooms_dict[room][2]
        center_x = (grid_size - w) // 2
        center_y = (grid_size - h) // 2
        return x == center_x and y == center_y



    def livingroom_kitchen(room1, loc1, room2, loc2):
        x1, y1, w1, h1 = loc1[0], loc1[1], fitting_rooms_dict[room1][1], fitting_rooms_dict[room1][2]
        x2, y2, w2, h2 = loc2[0], loc2[1], fitting_rooms_dict[room2][1], fitting_rooms_dict[room2][2]
        grid_size = int(math.sqrt(total_area))

        center_x = grid_size // 2 - w1 // 2
        center_y = grid_size // 2 - h1 // 2

        if room1.startswith("LivingRoom1"):
            if not (x1 == center_x and y1 == center_y):
                return False
            return x2 + w2 == x1 and y2 == y1
        elif room1.startswith("Kitchen1"):
            return x1 + w1 == x2 and y1 == y2

        return True
    
    def entrance_adjacent_to_floorplan_lower_edge(room, loc):
        x1, y1, w1, h1 = loc[0], loc[1], fitting_rooms_dict[room][1], fitting_rooms_dict[room][2]
        grid_size = int(math.sqrt(total_area))

        # Check if the entrance is adjacent to the lower edge of the floorplan
        adjacent_to_lower_edge = (y1 == 0)

        # Check if the entrance is near the middle of the lower edge (within 1/4 of the grid size)
        near_middle_lower_edge = (abs(x1 + w1 / 2 - grid_size / 2) <= grid_size / 4)

        return adjacent_to_lower_edge and near_middle_lower_edge

    def entrance_guestroom(room1, loc1, room2, loc2):
        x1, y1, w1, h1 = loc1[0], loc1[1], fitting_rooms_dict[room1][1], fitting_rooms_dict[room1][2]
        x2, y2, w2, h2 = loc2[0], loc2[1], fitting_rooms_dict[room2][1], fitting_rooms_dict[room2][2]

        if room1 == "Entrance":
            # Check if GuestRoom is directly to the right of Entrance
            return x2 == x1 + w1 and y2 == y1

        elif room1 == "GuestRoom":
            # Check if GuestRoom is directly to the right of Entrance
            return x1 == x2 + w2 and y1 == y2

        return True
  
    def not_adjacent(room1, loc1, room2, loc2):
        x1, y1, w1, h1 = loc1[0], loc1[1], fitting_rooms_dict[room1][1], fitting_rooms_dict[room1][2]
        x2, y2, w2, h2 = loc2[0], loc2[1], fitting_rooms_dict[room2][1], fitting_rooms_dict[room2][2]
        
        # Check adjacency on all sides
        adjacent = (x1 == x2 + w2 or x1 + w1 == x2) and (y1 < y2 + h2 and y1 + h1 > y2) or \
                   (y1 == y2 + h2 or y1 + h1 == y2) and (x1 < x2 + w2 and x1 + w1 > x2)
        return not adjacent

    def bathroom1_upper_edge(room, loc):
        return loc[1] == int(math.sqrt(total_area)) - fitting_rooms_dict[room][2]

    def bathroom2_lower_edge(room, loc):
        return loc[1] == 0
    
    def balcony_adjacent_to_floorplan_edge(room, loc):
        x1, y1, w1, h1 = loc[0], loc[1], fitting_rooms_dict[room][1], fitting_rooms_dict[room][2]

        grid_size = int(math.sqrt(total_area))

        # Check if the balcony is adjacent to any edge of the floorplan
        adjacent_to_edge = (x1 == 0 or y1 == 0 or x1 + w1 == grid_size or y1 + h1 == grid_size)
        
        return adjacent_to_edge



    constraints = {}
    for room1 in fitting_rooms_dict.keys():
        constraints[room1] = {}
        for room2 in fitting_rooms_dict.keys():
            if room1 != room2:
                constraints[room1][room2] = [no_overlap]

    # Add specific constraint for Living Room to be at the center
    if "LivingRoom1" in fitting_rooms_dict.keys():
        def livingroom_center_constraint(room, loc):
            return center_livingroom(room, loc, grid_size)
        constraints["LivingRoom1"]["LivingRoom1"] = [livingroom_center_constraint]

    # Add specific constraints for Living Room and Kitchen
    #constraints["LivingRoom1"]["Kitchen1"].append(center_livingroom_kitchen)
    if "Kitchen1" in fitting_rooms_dict.keys():
        constraints["Kitchen1"]["LivingRoom1"].append(livingroom_kitchen)


    if "Entrance" in fitting_rooms_dict.keys():
        constraints["Entrance"]["Entrance"] = [entrance_adjacent_to_floorplan_lower_edge]

    # Add specific constraints for Entrance and Guest Room
    if "Entrance" in fitting_rooms_dict.keys():
        constraints["Entrance"]["GuestRoom"] = [entrance_guestroom]
    if "GuestRoom" in fitting_rooms_dict.keys():
        constraints["GuestRoom"]["Entrance"] = [entrance_guestroom]

    # Add specific constraints to ensure Bathroom1 is at the upper edge and Bathroom2 is at the lower edge
    if "Bathroom1" in fitting_rooms_dict.keys():
        constraints["Bathroom1"]["Bathroom1"] = [bathroom1_upper_edge]
    if "Bathroom2" in fitting_rooms_dict.keys():
        constraints["Bathroom2"]["Bathroom2"] = [bathroom2_lower_edge]

    if "Balcony1" in fitting_rooms_dict.keys():
        constraints["Balcony1"]["Balcony1"] = [balcony_adjacent_to_floorplan_edge]
 
    if "Bathroom3" in fitting_rooms_dict.keys() and "Bathroom1" in fitting_rooms_dict.keys():
        constraints["Bathroom3"]["Bathroom1"].append(not_adjacent)
        constraints["Bathroom1"]["Bathroom3"].append(not_adjacent)

    if "Bathroom3" in fitting_rooms_dict.keys() and "Bathroom2" in fitting_rooms_dict.keys():
        constraints["Bathroom3"]["Bathroom2"].append(not_adjacent)
        constraints["Bathroom2"]["Bathroom3"].append(not_adjacent)


    csp_problem = CSP(fitting_rooms_dict.keys(), domains, constraints)
    solution = csp_problem.solve()
    if solution:
        final_solution = {room: (loc[0], loc[1], fitting_rooms_dict[room][1], fitting_rooms_dict[room][2]) for room, loc in solution.items()}
        return final_solution, fitting_rooms_dict,items,usable_area
    return None, fitting_rooms_dict,items,usable_area

def optimize_solution(solution,usable_area,total_area,selected_rooms):
  while 1:
    solution, fitting_rooms_dict,items,usable_area = go_solving(total_area, selected_rooms)
    if usable_area<=(total_area*0.10) and solution :
      break
  return solution,usable_area

def get_occupied_grid(solution, grid_size):
    grid = np.zeros((grid_size, grid_size), dtype=int)
    for room, (x, y, w, h) in solution.items():
        grid[y:y+h, x:x+w] = 1
    return grid

def find_white_spaces(grid):
    white_spaces = []
    grid_size = len(grid)
    for y in range(grid_size):
        for x in range(grid_size):
            if grid[y, x] == 0:
                white_spaces.append((x, y))
    return white_spaces

def get_adjacent_white_spaces(room, room_coords, grid):
    x, y, w, h = room_coords
    adjacent_white_spaces = []
    
    # Check all sides of the room
    for dx in range(-1, w+1):
        for dy in range(-1, h+1):
            if 0 <= x + dx < grid.shape[1] and 0 <= y + dy < grid.shape[0]:
                if grid[y + dy, x + dx] == 0:
                    if dx == -1 or dx == w or dy == -1 or dy == h:
                        adjacent_white_spaces.append((x + dx, y + dy))
    
    return adjacent_white_spaces

def expand_room(room, room_coords, adjacent_spaces, grid):
    x, y, w, h = room_coords
    expanded = False
    
    for (space_x, space_y) in adjacent_spaces:
        # Check if we can expand horizontally
        if space_x == x - 1:
            x -= 1
            w += 1
            expanded = True
        elif space_x == x + w:
            w += 1
            expanded = True
        
        # Check if we can expand vertically
        if space_y == y - 1:
            y -= 1
            h += 1
            expanded = True
        elif space_y == y + h:
            h += 1
            expanded = True
        
        if expanded:
            grid[space_y, space_x] = 1
    
    return (x, y, w, h), expanded

def expand_rooms(solution, grid):
    expanded_solution = {}
    for room, coords in solution.items():
        adjacent_spaces = get_adjacent_white_spaces(room, coords, grid)
        new_coords, expanded = expand_room(room, coords, adjacent_spaces, grid)
        if expanded:
            expanded_solution[room] = new_coords
        else:
            expanded_solution[room] = coords
    return expanded_solution

def main(selected_rooms, total_area):
    # try:
    #     total_area = float(input("\nEnter the floorplan area (in square units): "))
    # except ValueError:
    #     print("Invalid input. Please enter a valid numeric value.")
    #     return

    # print("\nChoose your preferred rooms (enter the room numbers, separated by spaces):")
    # try:
    #     room_numbers = [int(num) for num in input("Example: 1 3 5 (for Bedroom1, Bedroom3, and LivingRoom1): ").split()]
    # except ValueError:
    #     print("Invalid input. Please enter valid room numbers.")
    #     return

    print(f"Received selected_rooms: {selected_rooms}")
    print(f"Received total_area: {total_area}")

    BR_C=0
    LR_C=0
    Balcony_C=0
    K_C=0
    S_C=0
    Bath_C=0
    for item in selected_rooms:
      if item =="Bedroom1" or item=="Bedroom2" or item=="Bedroom3" or item=="MasterBedroom1" or item=="MasterBedroom2":
        BR_C+=1
      if item =="LivingRoom1" or item=="LivingRoom2" or item=="GuestRoom":
        LR_C+=1
      if item=="Balcony1" or item=="Balcony2":
        Balcony_C+=1
      if item=="Kitchen1" or item=="Kitchen2":
        K_C+=1
      if item=="Store1" or item=="Store2":
        S_C+=1
      if item=="Bathroom1" or item=="Bathroom2" or item=="Bathroom3":
        Bath_C+=1

    if BR_C==5:
      print("invalid input , try again")
      return
    if BR_C+LR_C>=6 and Balcony_C==2 and S_C+K_C>3 and Bath_C>1:
      print("invalid input , try again")
      return
    if Balcony_C==2 and S_C+K_C>3 and Bath_C>1:
      print("invalid input , try again")
      return
    if len(selected_rooms)>13:
      print("invalid input , try again")
      return
    


    while True:
        solution, fitting_rooms_dict, items, usable_area = go_solving(total_area, selected_rooms)
        if solution:
            opt_solution, opt_usable_area = optimize_solution(solution, usable_area, total_area, selected_rooms)
            print("List of available rooms:")
            for num, room in items.items():
                print(f"{num}. {room}")

            print("\nRooms that fit within the usable area and their sizes:")
            for room in fitting_rooms_dict:
                print(f"{room}: {fitting_rooms_dict[room][0]} square units")

            print(f"\nRemaining usable area: {opt_usable_area:.2f} square units")

            print("One possible arrangement of rooms:")
            for room, (x, y, w, h) in opt_solution.items():
                print(f"{room}: position ({x}, {y}), size ({w}, {h})")
            
            # Detect white spaces and expand rooms
            grid_size = int(math.sqrt(total_area))
            occupied_grid = get_occupied_grid(opt_solution, grid_size)
            expanded_solution = expand_rooms(opt_solution, occupied_grid)
            
            print("Expanded room arrangement:")
            for room, (x, y, w, h) in expanded_solution.items():
                print(f"{room}: position ({x}, {y}), size ({w}, {h})")
            
            draw_floorplan(expanded_solution, fitting_rooms_dict, total_area)
            break

if __name__ == "__main__":
    app.run(debug=True)