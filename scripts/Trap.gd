extends Area2D

var set
var Global
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var type

var output_gridsquare

func _ready():
	Global = get_node("/root/Global")
	
	type = Global.trap_type_being_added
	Global.trap_instances.append(self)
	
	set_fixed_process(true)
	set = false
	pass

# body is whatever entered
func activate_trap(body):
	if (set == false): return
	print("I'm activated by: " + str(body))
	
	if (self.type == "portal_in"):
		var pos = Global.get_gridsquare_pixels(output_gridsquare[0], output_gridsquare[1])
		var vector_pos = Vector2(pos[0], pos[1])
		body.set_pos(vector_pos)

func _set():
	Global.acting = false
	set = true
	
	# testing only
	if (self.type == "portal_in"):
		output_gridsquare = [8, 8]

func _fixed_process(delta):
	pass

func _on_trap_body_enter( body ):
	self.activate_trap(body)
	pass # replace with function body
