extends Button
 
var data_source: Node


func _ready() -> void:
	$Config.set_as_top_level(true)
	$Config.global_position = global_position
	$Config.position.x += 100


func _process(_delta: float) -> void:
	$HBoxContainer/Label2.text = str(snapped(data_source.trend, 0.01))


func _on_Button_pressed() -> void:
	$Config.show()
	$Config.global_position = global_position
	$Config.global_position.x += size.x + 10


func _on_Lukk_pressed() -> void:
	$Config.hide()
