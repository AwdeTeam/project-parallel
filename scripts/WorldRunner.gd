extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Global

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#var playerthing = preload("res://scenes/instance/instance.tscn").instance()
	#get_node("instances_container").add_child(playerthing)
	Global = get_node("/root/Global")
	
	var mapthing = preload("res://scenes/maps/testmap/testmap.tscn").instance()
	get_node("map_container").add_child(mapthing)


func add_instance(player):
	print("inside world runner, adding instance for player ")
	Global.instance_pass_data = { "player" : player }
	
	var player_instance = preload("res://scenes/instance/instance.tscn").instance()
	get_node("instances_container").add_child(player_instance)
	return Global.instance_passback