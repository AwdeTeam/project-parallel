extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Global

var world

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	Global = get_node("/root/Global")
	create_players()
	
	world = preload("res://scenes/world.tscn").instance()
	get_node("world").add_child(world)
	
	var guithing = preload("res://scenes/ui.tscn").instance()
	get_node("gui").add_child(guithing)
	
	set_process_input(true)
	
	world.add_instance(0, 0, 1)
	world.add_instance(200, 200, 2)
	Global.player_1_instances[0].focus()

func _input(ev):
	if(ev.is_action_pressed("game_endturn")):
		end_turn()
	elif(ev.is_action_pressed("game_close")):
		get_tree().quit()
  pass

func end_turn():
	#Global = get_node("/root/Global")
	if(Global.player_turn == 1):
		Global.player_turn = 2
		Global.player_2.focus()
	else:
		Global.player_turn = 1
		Global.player_1.focus()
	

func create_players():
	var PlayerClass = load("scripts/Player.gd")
	self.Global.player_1 = PlayerClass.new(500, 1)
	self.Global.player_2 = PlayerClass.new(500, 2)