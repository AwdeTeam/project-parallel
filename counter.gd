extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time = 0
var ttotal = 999

func _ready():
	set_process(true)
	pass

func _process(delta):
	time += delta
	self.set_text(str(round(ttotal - time)))