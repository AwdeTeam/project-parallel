extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var get_fps = .25 # don't waste time procesing every _process call, just get the fps 4 times a second

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	get_fps -= delta
	if (get_fps <= 0):
		var fps = 1 / delta
		fps = round(fps)
		set_text(str(fps) + " fps")
		get_fps = .25