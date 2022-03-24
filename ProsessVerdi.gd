extends Label

var type = "Nivå"
var avvik
var prosess_verdi: float = 65.0
var trend: float = 0.0


func _ready():
	avvik = get_parent().get_node("Avvik")


func _physics_process(delta: float) -> void:
	avvik.prosess_verdi = prosess_verdi
	trend = prosess_verdi
	text = str(stepify(prosess_verdi, 0.01))
