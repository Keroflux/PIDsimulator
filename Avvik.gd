extends Label

var type: String = "Avvik"
var avvik: float = 0.0
var prosess_verdi: float = 0.0
var setpunkt: float = 0.0
var trend: float = 0.0
var p: Node
var i: Node 
var d: Node

func _ready():
	p = get_parent().get_node("Proporsjonal")
	i = get_parent().get_node("Integral")
	d = get_parent().get_node("Derivat")


func _physics_process(_delta: float) -> void:
	avvik = prosess_verdi - setpunkt
	trend = avvik
	p.avvik = avvik
	i.avvik = avvik
	d.avvik = avvik
	d.prosessverdi = prosess_verdi
	text = str(snapped(avvik, 0.01))
	
