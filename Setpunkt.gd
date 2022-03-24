extends LineEdit

var type = "Setpunkt"
var avvik
var setpunkt: float = 65
var trend: float = 0.0


func _ready():
	avvik = get_parent().get_node("Avvik")
	avvik.setpunkt = setpunkt
	trend = setpunkt


#func _process(delta):
#	avvik.setpunkt = setpunkt

func _on_Setpunkt_text_entered(new_text):
	setpunkt = float(new_text)
	avvik.setpunkt = setpunkt
	trend = setpunkt
