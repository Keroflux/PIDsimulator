extends Label

var type = "Pådrag"
var utgang: float = 0.0
var p: float = 0.0
var i: float = 0.0
var d: float = 0.0
var trend: float = 0.0
var proporsjonal
var integral
var derivat


func _ready():
	proporsjonal = get_parent().get_node("Proporsjonal")
	integral = get_parent().get_node("Integral")
	derivat = get_parent().get_node("Derivat")


func _physics_process(delta: float) -> void:
	p = proporsjonal.utgangsverdi
	i = integral.utgangsverdi
	d = derivat.utgangsverdi
	utgang = p + i + d
	utgang = clamp(utgang, 0, 100)
	trend = utgang
	text = str(stepify(utgang, 0.01))

