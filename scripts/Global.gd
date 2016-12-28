
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

const SPLIT_PENALTY = 1 # amount of time deducted when you split

const PROX_BOMB_DMG = 2
const ATTACK_DMG = 1

const PORTAL_IN = 1
const PORTAL_OUT = 2
const PROX_BOMB = 3

const TURN_TIME_GAIN = 15
const TURN_TIME_INSTANCE_PENALTY = 1

const START_COUNT_PROX_BOMB = 4
const START_COUNT_PORTAL = 4

const PORTAL_USES = 4

# player turn
var player_turn = 0 # 0 = none (in between), 1 = player 1, 2 = player 2
var player_1
var player_2

var player_1_instances = []
var player_2_instances = []

var player_adding_instance # this is player id, not instance

var currently_active_instance # this is the actual instance reference

var game_running = true

var trap_instances = []
var trap_type_being_added
var player_adding_trap # this is instance

var acting = false

var game # this is the game runner!!!
var Global
func _init():
	Global = get_node("/root/Global")

static func get_gridsquare_pixels(x, y):
	return [x*160, y*160]

static func get_pixels_gridsquare(x, y):
	return [round(x/160), round(y/160)]

static func get_active_player():
	if (Global.player_turn == 1):
		return Global.player_1
	elif (Global.player_turn == 2):
		return Global.player_2

static func get_inactive_player():
	if (Global.player_turn == 1):
		return Global.player_2
	elif (Global.player_turn == 2):
		return Global.player_1

static func remove_trap(index):
	Global.trap_instances[index].remove()
	Global.trap_instances.remove(index)
	Global.refresh_trap_indicies()

static func refresh_trap_indicies():
	print("inside refreshing trap indicies....")
	var counter = 0
	for trap in Global.trap_instances:
		trap.instance_index = counter
		counter += 1
	print("finished refreshing")