extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Global = load("scripts/Global.gd")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	var worldthing = preload("res://scenes/world.tscn").instance()
	get_node("world").add_child(worldthing)
	
	var guithing = preload("res://scenes/ui.tscn").instance()
	get_node("gui").add_child(guithing)
	
	
	pass

func add_player():
	var PlayerClass = load("scripts/Player.gd")
	self.Global.player_1 = PlayerClass.new(500, 1)
	self.Global.player_2 = PlayerClass.new(500, 2)