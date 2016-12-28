
extends Node # won't get processed without this

var speed = 500
var player_id = 0

var instances = []
var active_instance_index = 0

var Global

func _init(speed, player, Global):
	self.speed = speed
	self.player_id = player
	self.Global = Global

func focus():
	instances[0].focus()
	active_instance_index = 0

func focus_next():
	active_instance_index += 1
	instances[active_instance_index].focus()