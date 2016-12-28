extends KinematicBody2D

var Global
var PlayerClass = load("scripts/Player.gd")
var parent_player

var instance_index # index in players instance array

var elapsed_time
var lbl_counter

var health # TODO: not implemented yet


var action_button_was_pressed = false

func _init():
	pass

func _ready():
	
	self.elapsed_time = 0

	Global = get_node("/root/Global")
	set_fixed_process(true)

	print(str(Global.player_adding_instance))
	if (Global.player_adding_instance == 1):
		parent_player = Global.player_1
	elif (Global.player_adding_instance == 2):
		parent_player = Global.player_2

	parent_player.instances.append(self)
	parent_player.refresh_instance_indices()
	
	# make all other members of this player's instance team ignore eachother
	for instance in parent_player.instances:
		self.ignore_collision_body(instance)
		instance.ignore_collision_body(self)
		
	lbl_counter = get_node("counter")

func focus():
	get_node("instance_camera").make_current()
	Global.currently_active_instance = self
	parent_player.active_instance_index = self.instance_index

func ignore_collision_body(body):
	self.add_collision_exception_with(body)

func get_gridsquare():
	var pos = self.get_pos()
	var gridsquare = Global.get_pixels_gridsquare(pos.x, pos.y)
	return gridsquare

func _fixed_process(delta):
	if (Global.game_running == false): 
		set_process(false)
		return
	if(Global.player_turn != self.parent_player.player_id):
		return
	if (Global.currently_active_instance != self):
		return
	
	parent_player.subtract_time(delta)

	elapsed_time += delta
	lbl_counter.set_text(str(round(elapsed_time)))

	# determine if must move
	var up = Input.is_action_pressed("game_up")
	var down = Input.is_action_pressed("game_down")
	var left = Input.is_action_pressed("game_left")
	var right = Input.is_action_pressed("game_right")
	
	# check if placing trao
	var act = Input.is_action_pressed("game_action")
	if (!act): action_button_was_pressed = false
	if (act and !action_button_was_pressed):
		action_button_was_pressed = true
		# get mouse position
		var local_mouse_pixel = get_node("/root/container/world").get_local_mouse_pos()
		
		# account for offset
		local_mouse_pixel.x -= 80
		local_mouse_pixel.y -= 80
		
		var sqr = Global.get_pixels_gridsquare(local_mouse_pixel.x, local_mouse_pixel.y)
		
		var type = ""
		if (parent_player.trap_selection == Global.PORTAL_IN): type = "portal_in"
		elif (parent_player.trap_selection == Global.PORTAL_OUT): type = "portal_out"
		elif (parent_player.trap_selection == Global.PROX_BOMB): type = "proxbomb"
		Global.game.world.add_trap(sqr[0], sqr[1], self.parent_player.player_id, type)
		Global.trap_instances[Global.trap_instances.size() - 1]._set()
	
	var dpos = [0,0]
	# diagonals
	if (up && left): dpos = calculate_movement(delta, Global.NORTHWEST)
	elif (up && right): dpos = calculate_movement(delta, Global.NORTHEAST)
	elif (down && left): dpos = calculate_movement(delta, Global.SOUTHWEST)
	elif (down && right): dpos = calculate_movement(delta, Global.SOUTHEAST)
	
	# cancel out
	elif (down && up): dpos = [0, 0]
	elif (left && right): dpos = [0, 0]
	
	# cardinals
	elif (up): dpos = calculate_movement(delta, Global.NORTH)
	elif (down): dpos = calculate_movement(delta, Global.SOUTH)
	elif (left): dpos = calculate_movement(delta, Global.WEST)
	elif (right): dpos = calculate_movement(delta, Global.EAST)

	# make it move!
	var movement = Vector2(dpos[0], dpos[1])
	move(movement)
	
	# fix sticking to walls issue
	if (is_colliding()):
		var collision_normal = get_collision_normal()
		movement = collision_normal.slide(movement)
		move(movement)
	
	# check if in gridsquare of another instance
	if (self.elapsed_time > 2):
		var current_gridsquare = self.get_gridsquare()
		for instance in parent_player.instances:
			if (instance == self): continue # don't check with self!!
			var instance_gridsquare = instance.get_gridsquare()
			
			# if same, trigger a merge
			if (instance_gridsquare[0] == current_gridsquare[0] and instance_gridsquare[1] == current_gridsquare[1]):
				merge(instance)
				break

# merges this instance into the passed instance
func merge(instance):
	# compare instance times
	var instance_time = instance.elapsed_time
	
	# determine smaller instance
	var smaller_instance
	var larger_instance
	if (instance_time < self.elapsed_time): 
		smaller_instance = instance
		larger_instance = self
	else: 
		smaller_instance = self
		larger_instance = instance
	
	# add smaller instance time back to counter
	var smaller_time = smaller_instance.elapsed_time
	parent_player.subtract_time(-smaller_time)
	
	# remove smaller instance
	smaller_instance.remove()
	larger_instance.focus()

func remove():
	parent_player.instances.remove(self.instance_index)
	parent_player.refresh_instance_indices()
	parent_player.focus_next()
	get_parent().remove_child(self)

func calculate_movement(delta, direction):
	# Calculate cardinal distance and diaganol distance
	var distance = delta * parent_player.speed
	var distanceroot = delta * sqrt((parent_player.speed*parent_player.speed/2))
	
	var dy = 0
	var dx = 0
	
	# determine distance changes
	if (direction == 0):
		dy = -distance
	elif (direction == 1):
		dy = -distanceroot
		dx = distanceroot
	elif (direction == 2):
		dx = distance
	elif (direction == 3):
		dy = distanceroot
		dx = distanceroot
	elif (direction == 4):
		dy = distance
	elif (direction == 5):
		dy = distanceroot
		dx = -distanceroot
	elif (direction == 6):
		dx = -distance
	elif (direction == 7):
		dy = -distanceroot
		dx = -distanceroot
	
	return [dx, dy]
	