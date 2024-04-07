extends Label

var type: String = "Nivå"
var avvik: Node
var prosess_verdi: float = 65.0
var trend: float = 0.0


func _ready() -> void:
	avvik = get_parent().get_node("Avvik")


func _physics_process(_delta: float) -> void:
	avvik.prosess_verdi = prosess_verdi
	trend = prosess_verdi
	text = str(snapped(prosess_verdi, 0.01))
