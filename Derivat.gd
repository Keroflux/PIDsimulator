extends Label

var type: String = "D"
var utgangsverdi: float = 0.0
var Td: float = 0.0
var Kp: float = 1
var avvik: float = 0.0
var forrige_avvik: float = 0.0
var forrige_prosessverdi: float = 0.0
var trend: float = 0.0
var prosessverdi: float = 0.0


func _physics_process(delta: float) -> void:
	utgangsverdi = ((prosessverdi - forrige_prosessverdi) / delta) * Td * Kp
#	utgangsverdi = ((avvik - forrige_avvik) / delta) * Td * Kp
	forrige_prosessverdi = prosessverdi
#	forrige_avvik = avvik
	
	trend = utgangsverdi
	text = str(snapped(utgangsverdi, 0.01))
	$Label2.text = str("((", snapped(prosessverdi, 0.01), " - ", snapped(forrige_prosessverdi, 0.01), ") / ", snapped(delta, 0.01), ") * ", Td, " * ", Kp)


func _on_Td_text_entered(new_text: String) -> void:
	Td = float(new_text)


func _on_Kp_text_entered(new_text: String) -> void:
	if float(new_text) > 0:
		Kp = float(new_text)
	else:
		Kp = 1
	
