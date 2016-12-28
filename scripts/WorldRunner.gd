extends Node2D

var Global

func _ready():

	Global = get_node("/root/Global")
	
	#var playerthing = preload("res://scenes/instance/instance.tscn").instance()
	#get_node("instances_container").add_child(playerthing)
	
	var mapthing = preload("res://scenes/maps/testmap/testmap.tscn").instance()
	get_node("map_container").add_child(mapthing)
	
	
func add_instance(x, y, player_id):
	Global.player_adding_instance = player_id
	if (player_id == 1):
		print("Adding instance " + str(player_id))
		var playerthing = preload("res://scenes/instance/instance1.tscn").instance()
		get_node("instances_container").add_child(playerthing)
		playerthing.set_pos(Vector2(x, y))
	elif (player_id == 2):
		var playerthing = preload("res://scenes/instance/instance2.tscn").instance()
		get_node("instances_container").add_child(playerthing)
		playerthing.set_pos(Vector2(x, y))