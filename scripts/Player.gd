
extends Node # won't get processed without this


var time = 120 # in seconds
var actual_time = 120.0 # float used internally, time above is rounded and for external usage

var speed = 500
var player_id = 0

var instances = []
var active_instance_index = 0

var Global

func _init(speed, player, Global):
	self.speed = speed
	self.player_id = player
	self.Global = Global
	self.time = 120
	self.actual_time = 120.0

func focus():
	instances[0].focus()
	active_instance_index = 0

func focus_next():
	active_instance_index += 1
	instances[active_instance_index].focus()


func focus_last():
	active_instance_index = instances.count() - 1
	instances[active_instance_index].focus()
	pass
	

func subtract_time(delta):
	self.actual_time -= delta
	time = round(self.actual_time)