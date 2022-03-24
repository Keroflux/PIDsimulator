extends Label

var utgangsverdi: float = 0.0
var Td: float = 0.0
var Kp: float = 10
var avvik: float = 0.0
var forrige_avvik: float = 0.0
var trend: float = 0.0


func _physics_process(delta: float) -> void:
	utgangsverdi = ((avvik - forrige_avvik) / delta) * Td * Kp
	forrige_avvik = avvik
	
	trend = utgangsverdi
	text = str(stepify(utgangsverdi, 0.01))


func _on_Td_text_entered(new_text):
	Td = float(new_text)


func _on_Kp_text_entered(new_text):
	Kp = float(new_text)
