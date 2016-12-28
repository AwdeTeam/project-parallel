extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var playerthing = preload("res://scenes/instance/instance.tscn").instance()
	get_node("instances_container").add_child(playerthing)
	
	var mapthing = preload("res://scenes/maps/testmap/testmap.tscn").instance()
	get_node("map_container").add_child(mapthing)