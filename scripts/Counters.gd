
extends Node2D

var Global

var counter_1_text
var counter_2_text

var lbl_counter_1
var lbl_counter_2

var lbl_active
var lbl_portals_in
var lbl_portals_out
var lbl_prox

func _ready():
	Global = get_node("/root/Global")
	
	lbl_counter_1 = get_node("lbl_counter_1")
	lbl_counter_2 = get_node("lbl_counter_2")
	
	lbl_active = get_node("lbl_active")
	lbl_portals_in = get_node("lbl_portals_in")
	lbl_portals_out = get_node("lbl_portals_out")
	lbl_prox = get_node("lbl_prox")
	
	set_process(true)

func _process(delta):
	if (Global.game_running == false):
		set_process(false)
		return
	fetch_player_times()
	lbl_counter_1.set_text(counter_1_text)
	lbl_counter_2.set_text(counter_2_text)
	
	if (Global.player_turn != 0):
		var player = Global.get_active_player()
		
		# active item
		var active_text = ""
		if (player.trap_selection == Global.PORTAL_IN): active_text = "Input Portal"
		elif (player.trap_selection == Global.PORTAL_OUT): active_text = "Output Portal"
		elif (player.trap_selection == Global.PROX_BOMB): active_text = "Prox Bomb"
		
		lbl_active.set_text(active_text)
		lbl_portals_in.set_text(str(player.num_portals_in))
		lbl_portals_out.set_text(str(player.num_portals_out))
		lbl_prox.set_text(str(player.num_prox_bombs))

func fetch_player_times():
	var player_1_time = Global.player_1.time
	var player_2_time = Global.player_2.time
	
	counter_1_text = determine_text(player_1_time)
	counter_2_text = determine_text(player_2_time)

func determine_text(number):
	var minutes = int(floor(number / 60))
	var seconds = number - (minutes*60)

	var minutes_text = str(minutes)
	var seconds_text = str(seconds)
	if (seconds < 10): seconds_text = "0" + seconds_text
	return minutes_text + ":" + seconds_text