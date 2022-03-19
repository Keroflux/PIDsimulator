extends Label

var utgang: float = 0.0
var p: float = 0.0
var i: float = 0.0
var d: float = 0.0
var cv: float = 1200.0
var flow: float = 0.0
var proporsjonal
var integral
var derivat
var separator


func _ready():
	proporsjonal = get_parent().get_node("Proporsjonal")
	integral = get_parent().get_node("Integral")
	derivat = get_parent().get_node("Derivat")
	separator = get_parent()


func _physics_process(delta: float) -> void:
	p = proporsjonal.utgangsverdi
	i = integral.utgangsverdi
	d = derivat.utgangsverdi
	utgang = p + i + d
	utgang = clamp(utgang, 0, 100)
	flow = cv * (utgang / 100)
	separator.outflow = flow
	text = str(stepify(utgang, 0.1))


func _on_VentilSize_text_entered(new_text):
	cv = float(new_text)
