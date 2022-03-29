extends Button
 
var data_point = "E"


func _ready():
	$Config.set_as_toplevel(true)
	$Config.rect_global_position = rect_global_position
	$Config.rect_position.x += 100


func _process(delta):
	$HBoxContainer/Label2.text = str(stepify(data_point.trend, 0.01))


func _on_Button_pressed():
	$Config.show()


func _on_Lukk_pressed():
	$Config.hide()

