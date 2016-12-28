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
	Global.game = self
	create_players()
	
	world = preload("res://scenes/world.tscn").instance()
	get_node("world").add_child(world)
	
	var guithing = preload("res://scenes/ui/ui.tscn").instance()
	get_node("gui").add_child(guithing)
	
	set_process_input(true)
	
	world.add_instance(0, 0, 1)
	world.add_instance(10, 5, 2)
	#world.add_instance(0, 0, 2)
	#world.add_instance(0, 1, 2)
	#world.add_instance(1, 1, 2)
	
	Global.player_1.focus()
	
	#world.add_trap(2, 2, 1, "portal_in")
	#Global.trap_instances[0]._set()

	#Global.player_1_instances[0].focus()
	#Global.player_1_instances[0].ignore_collision_body(Global.player_2_instances[0])

func _input(ev):
	if(ev.is_action_pressed("game_endturn")):
		end_turn()
	elif(ev.is_action_pressed("game_close") and Global.game_running):
		Global.game_running = false
		get_tree().quit()
	elif(ev.is_action_pressed("game_split")):
		var active_index
		if (Global.player_turn == 1):
			active_index = Global.player_1.active_instance_index
		elif (Global.player_turn == 2):
			active_index = Global.player_2.active_instance_index
		split(Global.player_turn, active_index)
	elif(ev.is_action_pressed("game_forward_instance")):
		Global.get_active_player().focus_next()
	elif(ev.is_action_pressed("game_backward_instance")):
		Global.get_active_player().focus_prev()
	elif (ev.is_action_pressed("game_choose_1")):
		Global.get_active_player().trap_selection = 1
	elif (ev.is_action_pressed("game_choose_2")):
		Global.get_active_player().trap_selection = 2
	elif (ev.is_action_pressed("game_choose_3")):
		Global.get_active_player().trap_selection = 3
  pass

func end_turn():
	#Global = get_node("/root/Global")
	if(Global.player_turn == 1):
		Global.player_turn = 2
		Global.player_2.focus()
	else:
		Global.player_turn = 1
		Global.player_1.focus()

func split(player_id, instance_id):
	var player
	if (player_id == 1): player = Global.player_1
	elif (player_id == 2): player = Global.player_2
	
	# get position of active
	#var pos = Global.currently_active_instance.get_pos()
	var pos = player.instances[instance_id].get_pos()
	var gridsquare = Global.get_pixels_gridsquare(pos.x, pos.y)
	
	#world.add_instance(gridsquare[0], gridsquare[1], Global.player_turn)
	world.add_instance(gridsquare[0], gridsquare[1], player_id)
	player.instances[instance_id].health = ceil(player.instances[instance_id].health/2)
	player.focus_last()
	
	player.instances[player.instances.size() - 1].health = player.instances[instance_id].health
	#if (Global.player_turn == 1):
		#Global.player_1.focus_next()
	#elif (Global.player_turn == 2):
		#Global.player_2.focus_next()

func create_players():
	var PlayerClass = load("scripts/Player.gd")
	self.Global.player_1 = PlayerClass.new(500, 1, Global)
	self.Global.player_2 = PlayerClass.new(500, 2, Global)