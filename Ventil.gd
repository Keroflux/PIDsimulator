extends Label

var type: String = "Ventil"
var ventilpossisjon: float = 0.0
var ventilhastighet: float = 5.0
var cv: float = 1200.0
var flow: float = 0.0
var deadband: float = 0.2
var trend: float = 0.0
var regulator
var separator


func _ready() -> void:
	regulator = get_parent().get_node("Pådrag")
	separator = get_parent().get_parent()


func _physics_process(delta: float) -> void:
	if ventilhastighet <= 0:
		ventilpossisjon = regulator.utgang
	else:
		if ventilpossisjon + deadband < regulator.utgang:
			ventilpossisjon += delta * ventilhastighet
		elif ventilpossisjon - deadband > regulator.utgang:
			ventilpossisjon -= delta * ventilhastighet
	
	ventilpossisjon = clamp(ventilpossisjon, 0, 100)
	flow = cv * (ventilpossisjon / 100.0)
	separator.outflow = flow
	separator.valve_opening = ventilpossisjon
	
	trend = ventilpossisjon
	text = str(snapped(ventilpossisjon, 0.01))


func _on_VentilSize_text_entered(new_text: String) -> void:
	cv = float(new_text)


func _on_VentilHastighet_text_entered(new_text: String) -> void:
	ventilhastighet = float(new_text)


func _on_VentilDdbnd_text_entered(new_text: String) -> void:
	deadband = float(new_text)
