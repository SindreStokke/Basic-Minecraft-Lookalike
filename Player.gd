extends KinematicBody


# Declare member variables here.
var akselerasjon = 20
var banefart = 7
var run_factor = 1.6
var gravity = 9.8*4
var jump_height = gravity*0.4
var crouch_scale = 0.75
var tid_siden_sist_foroverklikk = 0
var sprint = 0

var mouse_sensitivity = 0.05

var fart = Vector3()
var direction = Vector3()
var fall = Vector3()

var forrige_markerte_objekt = null
var markeringsboks = null
var peker_mot_blokkid = null
var peker_mot_blokkpos = null

var nytt_objekt = null

onready var head = $Head


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement(delta)
	marker()


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
	manipuler_verden()


func marker():
	# Markerer objektet som spilleren peker mot
	if get_node("Head/Camera_1st/RayCast").get_collider() != null:
		if forrige_markerte_objekt != get_node("Head/Camera_1st/RayCast").get_collider():
			# Oppretter markeringsboksen dersom den ikke eksisterer
			if forrige_markerte_objekt == null:
				markeringsboks = load("res://marker.tscn").instance()
				get_tree().get_root().add_child(markeringsboks)
			# Plasserer markeringsboksen i samme posisjon som blokken spilleren peker mot
			markeringsboks.transform.origin = get_node("Head/Camera_1st/RayCast").get_collider().global_transform.origin
			peker_mot_blokkpos = get_node("Head/Camera_1st/RayCast").get_collider().global_transform.origin
			peker_mot_blokkid = get_node("Head/Camera_1st/RayCast").get_collider()
			forrige_markerte_objekt = get_node("Head/Camera_1st/RayCast").get_collider()
	else:
		if forrige_markerte_objekt != null:
			# Sletter markeringsnoden
			markeringsboks.queue_free()
			forrige_markerte_objekt = null
			peker_mot_blokkpos = null


func manipuler_verden():
	# Sletter markert blokk ved venstreklikk
	if Input.is_action_just_pressed("mouse_left"):
		if get_node("Head/Camera_1st/RayCast").get_collider() != null:
			get_node("Head/Camera_1st/RayCast").get_collider().queue_free()
	
	# Utplasserer blokk ved høyreklikk
	if Input.is_action_just_pressed("mouse_right"):
		if peker_mot_blokkpos != null:
			# Utplasser blokk på riktig posisjon
			nytt_objekt = load("res://blokker/dirt.tscn").instance()
			nytt_objekt.transform.origin = peker_mot_blokkpos+2*get_node("Head/Camera_1st/RayCast").get_collision_normal()
			get_node("../Blokker").add_child(nytt_objekt)
			pass


func movement(delta):
	direction = Vector3()
	# Akselererer spilleren på grunn av tyngdekraften dersom den ikke er i kontakt med bakken
	if not is_on_floor():
		fall.y -= gravity*delta
	if Input.is_action_just_pressed("space") and is_on_floor():
		fall.y = jump_height
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_just_pressed("move_forward"):
		if tid_siden_sist_foroverklikk+1000 > OS.get_ticks_msec() and sprint == 0:
			print("Dobbelfram:")
			print(tid_siden_sist_foroverklikk+1000)
			print(OS.get_ticks_msec())
			banefart = banefart*run_factor
			sprint = 1
		else:
			tid_siden_sist_foroverklikk = OS.get_ticks_msec()
	if Input.is_action_just_released("move_forward"):
		if sprint == 1:
			banefart = banefart/run_factor
			sprint = 0
	
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	if Input.is_action_just_pressed("sprint"):
		if sprint == 0:
			banefart = banefart*run_factor
			sprint = 1
	if Input.is_action_just_released("sprint"):
		if sprint == 1:
			banefart = banefart/run_factor
			sprint = 0
	if Input.is_action_just_pressed("crouch"):
		scale = Vector3(1,crouch_scale,1)
	if Input.is_action_just_released("crouch"):
		scale = Vector3(1,1,1)
	
	direction = direction.normalized()
	fart = fart.linear_interpolate(direction * banefart, akselerasjon * delta)
	fart = move_and_slide(fart, Vector3.UP)
	move_and_slide(fall, Vector3.UP)

