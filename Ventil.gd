extends Label

var ventilpossisjon: float = 0.0
var ventilhastighet: float = 5.0
var cv: float = 1200.0
var flow: float = 0.0
var regulator
var separator


func _ready():
	regulator = get_parent().get_node("Pådrag")
	separator = get_parent()


func _physics_process(delta: float) -> void:
	if ventilhastighet <= 0:
		ventilpossisjon = regulator.utgang
	else:
		if ventilpossisjon < regulator.utgang:
			ventilpossisjon += delta * ventilhastighet
		elif ventilpossisjon > regulator.utgang:
			ventilpossisjon -= delta * ventilhastighet
	
	flow = cv * (ventilpossisjon / 100)
	separator.outflow = flow
	
	text = str(stepify(ventilpossisjon, 0.01))


func _on_VentilSize_text_entered(new_text):
	cv = float(new_text)


func _on_VentilHastighet_text_entered(new_text):
	ventilhastighet = float(new_text)
