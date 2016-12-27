
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