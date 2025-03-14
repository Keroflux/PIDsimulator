extends Label

var type: String = "I"
var utgangsverdi: float = 0.0
var Ti: float = 50.0
var Kp: float = 10.0
var avvik: float = 0.0
var i: float = 0.0
var trend: float = 0.0
var ventil: Node


func _ready() -> void:
	ventil = get_parent().get_node("Pådrag")


func _physics_process(delta: float) -> void:
	if Ti > 0:
		utgangsverdi = utgangsverdi + ((avvik/Ti) * delta * Kp)
		utgangsverdi = clamp(utgangsverdi, 0, 100)
	
	trend = utgangsverdi
	text = str(snapped(utgangsverdi, 0.01))
	$Label2.text = str(snapped(utgangsverdi, 0.01), " + ((", snapped(avvik, 0.01), "/", Ti, ") * ", snapped(delta, 0.01), " * ", Kp) 


func _on_Ti_text_entered(new_text: String) -> void:
	Ti = float(new_text)
	if float(new_text) <= 0:
		utgangsverdi = 0


func _on_Kp_text_entered(new_text: String) -> void:
	if float(new_text) > 0:
		Kp = float(new_text)
	else:
		Kp = 1
