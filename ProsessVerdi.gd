extends Label

var avvik
var prosess_verdi: float = 65.0


func _ready():
	avvik = get_parent().get_node("Avvik")


func _physics_process(delta: float) -> void:
	avvik.prosess_verdi = prosess_verdi
	text = str(stepify(prosess_verdi, 0.1))
