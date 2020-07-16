extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bbcode_text = ""
	append_bbcode("FPS: " + str(Engine.get_frames_per_second()) + "\n")
	append_bbcode("X:  " + str(stepify(get_node("../Player").global_transform.origin.x,0.1)) + "    ")
	append_bbcode("Y:  " + str(stepify(get_node("../Player").global_transform.origin.y,0.1)) + "    ")
	append_bbcode("Z:  " + str(stepify(get_node("../Player").global_transform.origin.z,0.1)) + "\n")
	append_bbcode("Player speed: " + str(stepify(get_node("../Player").fart.length(),0.1)) + "\n")
