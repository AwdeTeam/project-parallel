extends Node2D

var Global

func _ready():

	Global = get_node("/root/Global")
	
	#var playerthing = preload("res://scenes/instance/instance.tscn").instance()
	#get_node("instances_container").add_child(playerthing)
	
	var mapthing = preload("res://scenes/maps/testmap/testmap.tscn").instance()
	get_node("map_container").add_child(mapthing)
	
	
# assume that x and y are grid squares, not pixels
func add_instance(x, y, player_id):
	Global.player_adding_instance = player_id
	
	var pos = Global.get_gridsquare_pixels(x, y)
	
	var vector_pos = Vector2(pos[0], pos[1])

	var playerinstance
	var player
	if (player_id == 1):
		playerinstance = preload("res://scenes/instance/instance1.tscn").instance()
		player = Global.player_1
	elif (player_id == 2):
		playerinstance = preload("res://scenes/instance/instance2.tscn").instance()
		player = Global.player_2
	
	get_node("instances_container").add_child(playerinstance)
	playerinstance.get_node("kinematic_container").set_pos(vector_pos)
	
	# deduct split penalty
	player.subtract_time(Global.SPLIT_PENALTY)