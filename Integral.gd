extends Label

var utgangsverdi: float = 0.0
var Ti: float = 50.0
var Kp: float = 10.0
var avvik: float = 0.0
var i: float = 0.0
var trend: float = 0.0
var ventil


func _ready():
	ventil = get_parent().get_node("Pådrag")


func _physics_process(delta: float) -> void:
	if Ti > 0:
		if ventil.utgang < 99.9 and ventil.utgang > 0.1:
			utgangsverdi = (utgangsverdi + (avvik * delta * (Kp/Ti)))
			utgangsverdi = clamp(utgangsverdi, 0, 100)
	
	trend = utgangsverdi
	text = str(stepify(utgangsverdi, 0.01))


func _on_Ti_text_entered(new_text):
	Ti = float(new_text)


func _on_Kp_text_entered(new_text):
	Kp = float(new_text)
