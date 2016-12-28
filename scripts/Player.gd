
extends Node # won't get processed without this

var speed = 2
var player_id = 0
var instances = []

var Global
var world

func _init(speed, player, world):
	self.speed = speed
	self.player_id = player
	self.world = world
	print("player is initialized...")

func focus():
	self.instances[0].focus()

func callout():
	print("Yes, this is a player here! ID " + str(player_id))

func create_instance():
	print("inside player, attempting to add instance to world")
	var theinstance = self.world.add_instance(self)
	instances.append(theinstance)
	print("first instance: " + str(instances[0]))
	print("Successfully made instance")
	#self.focus()