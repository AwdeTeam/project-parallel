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
	
	set_process_input(true)
	
	
	pass

func _input(ev):
	if(ev.is_action_pressed("game_endturn")):
		end_turn()
	elif(ev.is_action_pressed("game_close")):
		get_tree().quit()
  pass

func end_turn():
	if(Global.player_turn == 1):
		Global.player_turn = 2
	else:
		Global.player_turn = 1

func add_player():
	var PlayerClass = load("scripts/Player.gd")
	self.Global.player_1 = PlayerClass.new(500, 1)
	self.Global.player_2 = PlayerClass.new(500, 2)