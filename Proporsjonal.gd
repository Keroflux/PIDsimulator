extends Label

var utgangsverdi: float = 0.0
var Kp: float = 10.0
var avvik: float = 0.0


func _physics_process(delta: float) -> void:
	utgangsverdi = avvik * Kp
	text = str(stepify(utgangsverdi, 0.01))


func _on_Kp_text_entered(new_text):
	Kp = float(new_text)
