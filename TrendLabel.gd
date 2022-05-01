extends Button
 
var data_source: Node


func _ready() -> void:
	$Config.set_as_toplevel(true)
	$Config.rect_global_position = rect_global_position
	$Config.rect_position.x += 100


func _process(_delta: float) -> void:
	$HBoxContainer/Label2.text = str(stepify(data_source.trend, 0.01))


func _on_Button_pressed() -> void:
	$Config.show()


func _on_Lukk_pressed() -> void:
	$Config.hide()

