
extends Node2D

var Global

var counter_1_text
var counter_2_text

var lbl_counter_1
var lbl_counter_2

func _ready():
	Global = get_node("/root/Global")
	
	lbl_counter_1 = get_node("lbl_counter_1")
	lbl_counter_2 = get_node("lbl_counter_2")
	
	set_process(true)

func _process(delta):
	fetch_player_times()
	lbl_counter_1.set_text(counter_1_text)
	lbl_counter_2.set_text(counter_2_text)

func fetch_player_times():
	var player_1_time = Global.player_1.time
	var player_2_time = Global.player_2.time
	
	counter_1_text = determine_text(player_1_time)
	counter_2_text = determine_text(player_2_time)

func determine_text(number):
	var minutes = int(floor(number / 60))
	var seconds = number - (minutes*60)
	
	print("determing text of " + str(number) + " seconds")
	print("minutes: " + str(minutes) + " seconds: " + str(seconds))
	
	var minutes_text = str(minutes)
	var seconds_text = str(seconds)
	if (seconds < 10): seconds_text = "0" + seconds_text
	return minutes_text + ":" + seconds_text