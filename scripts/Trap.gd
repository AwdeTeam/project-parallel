extends Area2D

var set
var Global
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var type

var output_gridsquare
var has_output = false

var parent_player

var instance_index

func _ready():
	Global = get_node("/root/Global")
	
	type = Global.trap_type_being_added
	parent_player = Global.player_adding_trap
	Global.trap_instances.append(self)
	instance_index = Global.trap_instances.size() - 1
	
	set_fixed_process(true)
	set = false
	pass

func set_portal_output(output):
	print("Attempting to set output....")
	has_output = true
	output_gridsquare = output.get_gridsquare()

func get_gridsquare():
	var pixel_pos = self.get_pos()
	print("pixelposx: " + str(pixel_pos.x) + " pixelposy: " + str(pixel_pos.y))
	var pos = Global.get_pixels_gridsquare(pixel_pos.x, pixel_pos.y)
	return pos

# body is whatever entered
func activate_trap(body):
	if (set == false): return
	print("I'm activated by: " + str(body))
	
	if (self.type == "portal_in" and self.has_output == true):
		var pos = Global.get_gridsquare_pixels(output_gridsquare[0], output_gridsquare[1])
		var vector_pos = Vector2(pos[0], pos[1])
		body.set_pos(vector_pos)
	
	if (self.type == "proxbomb"):
		if (body.parent_player.instances.size() > 1):
			body.remove()
			Global.remove_trap(instance_index)
			return

func remove():
	#get_parent().remove_child(get_node("trap"))
	pass

func _set():
	Global.acting = false
	set = true
	
	if (type == "portal_in"):
		print("adding input portal...")
		parent_player.uncompleted_portals.append(self)
	elif (type == "portal_out"):
		var test_pos = get_parent().get_node("trap").get_pos()
		print("testx: " + str(test_pos.x) + " testy: " + str(test_pos.y))
		if (parent_player.uncompleted_portals.size() == 0):
			print("ERROR, no uncompleted input portals")
		else:
			var input = parent_player.uncompleted_portals[0]
			input.set_portal_output(self)
			parent_player.uncompleted_portals.remove(0)
	
	# testing only
	#if (self.type == "portal_in"):
		#output_gridsquare = [8, 8]

func _fixed_process(delta):
	if (Global.game_running == false): 
		set_process(false)
		return

func _on_trap_body_enter( body ):
	self.activate_trap(body)
	pass # replace with function body
