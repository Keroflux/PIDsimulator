extends PanelContainer

var mouse_inside: bool = false
var move: bool = false
var m_pos: Vector2 = Vector2(0, 0)


func _on_PanelContainer_mouse_entered():
	mouse_inside = true


func _on_PanelContainer_mouse_exited():
	mouse_inside = false


func _input(event):
	if  mouse_inside:
		if event.is_action_pressed("left_mouse"):
			m_pos = get_global_mouse_position() - rect_global_position
			move = true
		if event.is_action_released("left_mouse"):
			move = false


func _process(delta):
	if move:
		rect_global_position = get_global_mouse_position() - m_pos
