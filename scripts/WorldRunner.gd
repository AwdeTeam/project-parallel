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
	
	var pos = Global.get_grid_square(x, y)
	
	var vector_pos = Vector2(pos[0], pos[1])
	print(str(player_id) + " setting instance pos to x=" + str(pos[0]) + " y=" + str(pos[1]))
	
	if (player_id == 1):
		var playerthing = preload("res://scenes/instance/instance1.tscn").instance()
		get_node("instances_container").add_child(playerthing)
		playerthing.get_node("kinematic_container").set_pos(vector_pos)
		var actual = playerthing.get_node("kinematic_container").get_pos()
		print("actual: x=" + str(actual.x) + " y=" + str(actual.y))
	elif (player_id == 2):
		var playerthing = preload("res://scenes/instance/instance2.tscn").instance()
		get_node("instances_container").add_child(playerthing)
		playerthing.get_node("kinematic_container").set_pos(vector_pos)