
extends Node # won't get processed without this

var speed = 2
var player_id = 0
var instances = []

func _init(speed, player):
	self.speed = speed
	self.player_id = player