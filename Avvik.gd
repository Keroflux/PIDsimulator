extends Label

var type = "Avvik"
var avvik: float = 0.0
var prosess_verdi: float = 0.0
var setpunkt: float = 0.0
var trend: float = 0.0
var p
var i 
var d

func _ready():
	p = get_parent().get_node("Proporsjonal")
	i = get_parent().get_node("Integral")
	d = get_parent().get_node("Derivat")


func _physics_process(delta: float) -> void:
	avvik = prosess_verdi - setpunkt
	trend = avvik
	p.avvik = avvik
	i.avvik = avvik
	d.avvik = avvik
	d.prosessverdi = prosess_verdi
	text = str(stepify(avvik, 0.01))
	
