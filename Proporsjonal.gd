extends Label

var type: String = "P"
var utgangsverdi: float = 0.0
var Kp: float = 10.0
var avvik: float = 0.0
var trend: float = 0.0


func _physics_process(_delta: float) -> void:
	utgangsverdi = avvik * Kp
	trend = utgangsverdi
	text = str(snapped(utgangsverdi, 0.01))
	$Label2.text = str(snapped(avvik, 0.01), " * ", Kp)


func _on_Kp_text_entered(new_text: String) -> void:
	Kp = float(new_text)
