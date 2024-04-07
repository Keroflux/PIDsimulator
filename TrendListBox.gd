extends PanelContainer

var mouse_inside: bool = false
var move: bool = false
var m_pos: Vector2 = Vector2(0, 0)


func _on_PanelContainer_mouse_entered() -> void:
	mouse_inside = true


func _on_PanelContainer_mouse_exited() -> void:
	mouse_inside = false


func _input(event: InputEvent) -> void:
	if  mouse_inside:
		if event.is_action_pressed("left_mouse"):
			m_pos = get_global_mouse_position() - global_position
			move = true
		if event.is_action_released("left_mouse"):
			move = false


func _process(_delta: float) -> void:
	if move:
		global_position = get_global_mouse_position() - m_pos
