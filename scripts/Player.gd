
extends Node # won't get processed without this


var time # in seconds
var actual_time # float used internally, time above is rounded and for external usage

var speed = 500
var player_id = 0

var instances = []
var active_instance_index = 0

var Global

func _init(speed, player, Global):
	self.speed = speed
	self.player_id = player
	self.Global = Global
	self.time = 120 + Global.SPLIT_PENALTY
	self.actual_time = self.time

func refresh_instance_indices():
	var index = 0
	for instance in instances:
		instance.instance_index = index
		index += 1

func focus():
	instances[0].focus()
	active_instance_index = 0

func focus_next():
	active_instance_index += 1
	if (active_instance_index >= instances.size()): active_instance_index = 0
	instances[active_instance_index].focus()

func focus_prev():
	active_instance_index -= 1
	if (active_instance_index < 0): active_instance_index = instances.size() - 1
	instances[active_instance_index].focus()

func focus_last():
	active_instance_index = instances.size() - 1
	instances[active_instance_index].focus()
	pass
	

func subtract_time(delta):
	self.actual_time -= delta
	time = round(self.actual_time)