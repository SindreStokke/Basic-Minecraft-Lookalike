extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rendredistanse = 8
var rendre_height_min = -6


# Called when the node enters the scene tree for the first time.
func _ready():
	generer_terreng()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generer_terreng():
	for nr_x in 2*rendredistanse:
		for nr_z in 2*rendredistanse:
			var height = 0
			while height > rendre_height_min:
				var nytt_objekt = load("res://Block.tscn").instance() # Oppretter det nye objektet
				nytt_objekt.transform.origin = Vector3((nr_x-rendredistanse)*2,height,(nr_z-rendredistanse)*2) # Endrer posisjonen til det nye objektet.
				get_node("Blokker").add_child(nytt_objekt) # Legger til det nye objektet på ønsket sted i det totale scene-hierarkiet relativt til der denne koden kjøres.
				height -= 2
