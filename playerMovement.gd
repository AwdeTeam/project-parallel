extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	if (Input.is_action_pressed("game_up")):
		move_up()
	if (Input.is_action_pressed("game_down")):
		move_down()
	if (Input.is_action_pressed("game_left")):
		move_left()
	if (Input.is_action_pressed("game_right")):
		move_right()

func move_up():
	var sprite = get_node("Sprite")
	var current_position = sprite.get_pos()
	current_position.y -= 1
	sprite.set_pos(current_position)
	
	
func move_down():
	var sprite = get_node("Sprite")
	var current_position = sprite.get_pos()
	current_position.y += 1
	sprite.set_pos(current_position)
	
func move_left():
	var sprite = get_node("Sprite")
	var current_position = sprite.get_pos()
	current_position.x -= 1
	sprite.set_pos(current_position)
	
func move_right():
	var sprite = get_node("Sprite")
	var current_position = sprite.get_pos()
	current_position.x += 1
	sprite.set_pos(current_position)