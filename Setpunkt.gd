extends LineEdit


var avvik
var setpunkt = 65

func _ready():
	avvik = get_parent().get_node("Avvik")
	avvik.setpunkt = setpunkt


#func _process(delta):
#	avvik.setpunkt = setpunkt

func _on_Setpunkt_text_entered(new_text):
	setpunkt = float(new_text)
	avvik.setpunkt = setpunkt
