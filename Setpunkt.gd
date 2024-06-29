extends LineEdit

var type: String = "Setpunkt"
var avvik: Node
var setpunkt: float = 50
var trend: float = 0.0
var controllerSP


func _ready() -> void:
	avvik = get_parent().get_node("Avvik")
	controllerSP = get_parent().get_parent().get_node("TankDrawing/Controller/Polygon2D/ControllerSP")
	avvik.setpunkt = setpunkt
	trend = setpunkt
	controllerSP.text = str(setpunkt)


#func _process(delta):
#	avvik.setpunkt = setpunkt

func _on_Setpunkt_text_entered(new_text: String) -> void:
	setpunkt = float(new_text)
	avvik.setpunkt = setpunkt
	trend = setpunkt
	controllerSP.text = new_text
