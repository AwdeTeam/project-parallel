extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	var worldthing = preload("res://scenes/world.tscn").instance()
	get_node("world").add_child(worldthing)
	
	var guithing = preload("res://scenes/ui.tscn").instance()
	get_node("gui").add_child(guithing)
	
	
	pass
