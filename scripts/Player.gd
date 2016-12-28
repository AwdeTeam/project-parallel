
extends Node # won't get processed without this

var speed = 500
var player_id = 0

var Global

func _init(speed, player, Global):
	self.speed = speed
	self.player_id = player
	self.Global = Global

func focus():
	if (player_id == 1):
		Global.player_1_instances[0].focus()
	elif (player_id == 2):
		Global.player_2_instances[0].focus()