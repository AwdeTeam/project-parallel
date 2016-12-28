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
	
	world = preload("res://scenes/world.tscn").instance()
	get_node("world").add_child(world)
	
	var guithing = preload("res://scenes/ui.tscn").instance()
	get_node("gui").add_child(guithing)
	
	set_process_input(true)
	
	start_game()
	
	pass
	
func start_game():
	print("starting game...")
	self.create_players()
	self.create_initial_instances()

func _input(ev):
	if(ev.is_action_pressed("game_endturn")):
		end_turn()
	elif(ev.is_action_pressed("game_close")):
		get_tree().quit()
  pass

func end_turn():
	if(Global.player_turn == 1):
		Global.player_turn = 2
		Global.player_2.focus()
		
		
	else:
		Global.player_turn = 1
		Global.player_1.focus()
	

func create_players():
	print("creating players...")
	var PlayerClass = load("scripts/Player.gd")
	Global.player_1 = PlayerClass.new(500, 1, self.world)
	Global.player_1.callout()
	Global.player_2 = PlayerClass.new(500, 2, self.world)

func create_initial_instances():
	print("creating initial instances...")
	Global.player_1.create_instance()
	Global.player_2.create_instance()
	Global.player_1.focus()
	pass