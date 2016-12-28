extends Area2D

var set
var Global
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	Global = get_node("/root/Global")
	set_fixed_process(true)
	set = false
	pass

func _set():
	Global.acting = false

func _fixed_process(delta):
	