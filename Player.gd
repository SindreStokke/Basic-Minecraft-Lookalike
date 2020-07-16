extends KinematicBody


# Declare member variables here.
var fart = Vector3(0,0,0)
var banefart = 5
var gravity = 9.8
var jump_height = gravity*0.8


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)

func _input(event):
	movement_input()

func movement_input():
	if Input.is_action_pressed("ui_down"):
		fart.z = banefart
	if Input.is_action_just_released("ui_down"):
		fart.z = 0
	if Input.is_action_pressed("ui_up"):
		fart.z = -banefart
	if Input.is_action_just_released("ui_up"):
		fart.z = 0
	if Input.is_action_pressed("ui_right"):
		fart.x = banefart
	if Input.is_action_just_released("ui_right"):
		fart.x = 0
	if Input.is_action_pressed("ui_left"):
		fart.x = -banefart
	if Input.is_action_just_released("ui_left"):
		fart.x = 0
	if Input.is_action_just_pressed("space") and is_on_floor():
		fart.y = jump_height

func movement(delta):
	if not is_on_floor():
		fart.y -= gravity*delta
	move_and_slide(fart, Vector3.UP)
