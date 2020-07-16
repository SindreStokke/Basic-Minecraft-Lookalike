extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rendredistanse = 16
var worldgen_noise = null
var overflate_height = 10
var underflate_height = 4
var blokker = ["res://blokker/dirt.tscn", "res://blokker/grass.tscn", "res://blokker/stone.tscn", "res://blokker/sand.tscn"]
var strukturer = ["res://strukturer/tree_oak.tscn"]
var blokk = null
var forrige_helkoordinater = [0,0]
var nytt_objekt = null
var trehyppighet = 80 # Det gjennomsnittlige antallet topp-blokker uten trær

var perspective = 1
var infoscreen = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Definerer verdengenereringens støykart
	randomize()
	worldgen_noise = OpenSimplexNoise.new()
	worldgen_noise.seed = randi()
	worldgen_noise.octaves = 2
	worldgen_noise.period = 100
	worldgen_noise.lacunarity = 15
	worldgen_noise.persistence = 0.75
	
	generer_terreng()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Rendrer inn nytt terreng når spilleren går
	if floor(get_node("Player").global_transform.origin.x) != forrige_helkoordinater[0]:
		pass


func _input(event):
	perspektiv_switch()
	infoscreen_switch()


func generer_terreng():
	for nr_x in 2*rendredistanse:
		for nr_z in 2*rendredistanse:
			
			# Setter terrengets overflate-høyde på gitte x og z koordinater
			var height = int((round(overflate_height*worldgen_noise.get_noise_2d(nr_x,nr_z))+overflate_height)/2)
			if height % 2 == 1:
				height+= 1 # Øker høyden med 1 dersom den er i halvblokkhøyde.
			
			# Flytter spilleren opp til overflaten
			if nr_x == 0 and nr_z == 0:
				get_node("Player").global_transform.origin = Vector3(0,height+20,0)
			
			# Genererer overflaten
			var h = height
			while h >= 0:
				if h == height:
					blokk = blokker[1]
					# Genererer et "oak tree" med en viss sannsynlighet
					if rand_range(0,trehyppighet+1) >= trehyppighet:
						blokk = blokker[0]
						nytt_objekt = load(strukturer[0]).instance()
						nytt_objekt.transform.origin = Vector3((nr_x-rendredistanse)*2,h+1,(nr_z-rendredistanse)*2)
						get_node("Strukturer").add_child(nytt_objekt)
				else:
					blokk = blokker[0]
				# Genererer gress/ jord-blokkene
				nytt_objekt = load(blokk).instance() # Oppretter det nye objektet
				nytt_objekt.transform.origin = Vector3((nr_x-rendredistanse)*2,h,(nr_z-rendredistanse)*2) # Endrer posisjonen til det nye objektet.
				get_node("Blokker").add_child(nytt_objekt) # Legger til det nye objektet på ønsket sted i det totale scene-hierarkiet relativt til der denne koden kjøres.
				h -= 2
			
			# Genererer underflaten
			blokk = blokker[2]
			for nr_y in underflate_height:
				if nr_y != 0:
					nytt_objekt = load(blokk).instance() # Oppretter det nye objektet
					nytt_objekt.transform.origin = Vector3((nr_x-rendredistanse)*2,-nr_y*2,(nr_z-rendredistanse)*2) # Endrer posisjonen til det nye objektet.
					get_node("Blokker").add_child(nytt_objekt) # Legger til det nye objektet på ønsket sted i det totale scene-hierarkiet relativt til der denne koden kjøres.


func perspektiv_switch():
	if Input.is_action_just_pressed("perspective_switch"):
		if perspective == 1:
			perspective = 3
			get_node("Player/Head/Camera_1st/Camera_3rd").current = true
			get_node("crosshair").visible = false
		elif perspective == 3:
			perspective = 1
			get_node("Player/Head/Camera_1st").current = true
			get_node("crosshair").visible = true


func infoscreen_switch():
	if Input.is_action_just_pressed("infoscreen_switch"):
		if infoscreen == 0:
			infoscreen = 1
			get_node("infoscreen").visible = true
		else:
			infoscreen = 0
			get_node("infoscreen").visible = false

