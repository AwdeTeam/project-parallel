
extends Node # if we don't extend node, then this script won't get processed!

# directions
const NORTH = 0
const NORTHEAST = 1
const EAST = 2
const SOUTHEAST = 3
const SOUTH = 4
const SOUTHWEST = 5
const WEST = 6
const NORTHWEST = 7

# player turn
var player_turn = 0 # 0 = none (in between), 1 = player 1, 2 = player 2
var player_1
var player_2

var player_1_instances = []
var player_2_instances = []

var player_adding_instance

var currently_active_instance

static func get_gridsquare_pixels(x, y):
	return [x*160, y*160]

static func get_pixels_gridsquare(x, y):
	return [round(x/160), round(y/160)]