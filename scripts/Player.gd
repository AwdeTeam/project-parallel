
extends Node # won't get processed without this

var speed = 500
var player_id = 0

func _init(speed, player):
	self.speed = speed
	self.player_id = player