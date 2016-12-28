extends Area2D

var set
var Global
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var type

func _ready():
	Global = get_node("/root/Global")
	
	type = Global.trap_type_being_added
	Global.trap_instances.append(self)
	
	set_fixed_process(true)
	set = false
	pass

# body is whatever entered
func activate_trap(body):
	print("I'm activated by: " + str(body))

func _set():
	Global.acting = false

func _fixed_process(delta):
	pass

func _on_trap_body_enter( body ):
	self.activate_trap(body)
	pass # replace with function body
