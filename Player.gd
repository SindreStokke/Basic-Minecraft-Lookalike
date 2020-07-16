extends KinematicBody


# Declare member variables here.
var akselerasjon = 20
var banefart = 7
var run_factor = 1.6
var gravity = 9.8*4
var jump_height = gravity*0.4

var mouse_sensitivity = 0.05

var fart = Vector3()
var direction = Vector3()
var fall = Vector3()

onready var head = $Head

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement(delta)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func movement(delta):
	direction = Vector3()
	
	if not is_on_floor():
		fall.y -= gravity*delta
	if Input.is_action_just_pressed("space") and is_on_floor():
		fall.y = jump_height
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	if Input.is_action_just_pressed("crouch"):
		banefart = banefart*run_factor
	if Input.is_action_just_released("crouch"):
		banefart = banefart/run_factor
	
	direction = direction.normalized()
	fart = fart.linear_interpolate(direction * banefart, akselerasjon * delta)
	fart = move_and_slide(fart, Vector3.UP)
	move_and_slide(fall, Vector3.UP)
