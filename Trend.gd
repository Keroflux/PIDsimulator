extends Node2D
signal time_changed

onready var top_bar: Node = $PanelContainer2/VBC/TopBar 
var trend_label: PackedScene = preload("res://TrendLabel.tscn")
var trend_line: PackedScene = preload("res://TrendLine2.tscn")
var trend_color: Array = [Color(1.0, 1.0, 1.0), Color(0.0, 0.0, 1.0), Color(1.0, 0.0, 0.0), Color(0.0, 1.0, 0.0), Color(0.0, 1.0, 1.0), Color(1.0, 1.0, 0.0), Color(1.0, 0.0, 1.0)]
onready var trends: Array = [get_parent().get_node("Blokkdiagram/ProsessVerdi"), get_parent().get_node("Blokkdiagram/Setpunkt"), get_parent().get_node("Blokkdiagram/Pådrag"), get_parent().get_node("Blokkdiagram/Ventil")]
onready var label_panel: Node = $PanelContainer2/VBC/HSplitContainer/PanelContainer/VSplitContainer/ScrollContainer/VBoxContainer
var mouse_inside: bool = false
var m_pos: Vector2 = Vector2(0, 0)
var move: bool = false
var time_scale: int = 60


func _ready() -> void:
	for i in trends.size():
		var t: Node = trend_line.instance()
		var l: Node = trend_label.instance()
		t.color = trend_color[i]
		connect("time_changed", t, "change_time_scale")
#		t.default_color = trend_color[i]
		t.data_source = trends[i]
		t.timer = $Timer
		l.data_source = trends[i]
		l.get_child(0).get_child(0).color = trend_color[i]
		l.get_child(0).get_child(0).connect("color_changed", t, "change_color")
		l.get_node("Config/VBoxContainer/Max").connect("text_entered", t, "change_max")
		l.get_node("Config/VBoxContainer/Min").connect("text_entered", t, "change_min")
		l.get_node("Config/VBoxContainer/Max").text = str(t.max_value)
		l.get_node("Config/VBoxContainer/Min").text = str(t.min_value)
		l.get_node("Config/VBoxContainer/Slett").connect("pressed", self, "remove_trend", [t, l])
		l.get_child(0).get_child(1).text = trends[i].type
		
		label_panel.add_child(l)
		$PanelContainer2/VBC/HSplitContainer/Trend/TrendLines.add_child(t)
		get_node("Timer").connect("timeout", t, "_on_Timer_timeout")


func _on_Timer_timeout() -> void:
	for i in $PanelContainer2/HSplitContainer/Trend/TrendLines.get_child_count():
		$PanelContainer2/HSplitContainer/Trend/TrendLines.get_child(i).redraw_trend(trends[i].trend)


func add_trend(data_point: Node) -> void:
	var t: Node = trend_line.instance()
	var l: Node = trend_label.instance()
	t.data_source = data_point
	t.color = random_color()
	connect("time_changed", t, "change_time_scale")
#	t.default_color = random_color()
	t.timer = $Timer
	t.change_time_scale(time_scale)
	l.data_source = data_point
	l.get_child(0).get_child(0).color = t.color
#	l.get_child(0).get_child(0).color = t.default_color
	l.get_child(0).get_child(0).connect("color_changed", t, "change_color")
	l.get_node("Config/VBoxContainer/Max").connect("text_entered", t, "change_max")
	l.get_node("Config/VBoxContainer/Min").connect("text_entered", t, "change_min")
	l.get_node("Config/VBoxContainer/Max").text = str(t.max_value)
	l.get_node("Config/VBoxContainer/Min").text = str(t.min_value)
	l.get_node("Config/VBoxContainer/Slett").connect("pressed", self, "remove_trend", [t, l])
	l.get_child(0).get_child(1).text = data_point.type
	$PanelContainer2/VBC/HSplitContainer/Trend/TrendLines.add_child(t)
	label_panel.add_child(l)
	get_node("Timer").connect("timeout", t, "_on_Timer_timeout")


func random_color() -> Color:
	var r: float = rand_range(0.0, 1.0)
	var g: float = rand_range(0.0, 1.0)
	var b: float = rand_range(0.0, 1.0)
	var c: Color = Color(r, g, b)
	
	return c


func remove_trend(trend: Node, label: Node) -> void:
	label.queue_free()
	trend.queue_free()


func _on_Bakgrunn_color_changed(c) -> void:
	$PanelContainer2/VBC/HSplitContainer/Trend.color = c


func _on_Button_pressed() -> void:
	if not $PanelContainer.visible:
		for tag in get_tree().get_nodes_in_group("Trend"):
			var a: Button = Button.new()
			a.text = tag.type
			a.connect("pressed", self, "add_trend", [tag])
			$PanelContainer/VBoxContainer/VBoxContainer.add_child(a)
		$PanelContainer.show()


func _on_Lukk_pressed() -> void:
	$PanelContainer.hide()
	for child in $PanelContainer/VBoxContainer/VBoxContainer.get_children():
		child.queue_free()


func _on_Trend_resized() -> void:
	for t in $PanelContainer2/VBC/HSplitContainer/Trend/TrendLines.get_children():
		t.change_scale_y()


func _on_OptionButton_item_selected(index: int) -> void:
	if index == 0:
		emit_signal("time_changed", 60)
		time_scale = 60
	elif index == 1:
		emit_signal("time_changed", 300)
		time_scale = 300
	elif index == 2:
		emit_signal("time_changed", 900)
		time_scale = 900
	elif index == 3:
		emit_signal("time_changed", 1800)
		time_scale = 1800
	elif index == 4:
		emit_signal("time_changed", 3600)
		time_scale = 3600


func _on_TopBar_mouse_entered() -> void:
	mouse_inside = true


func _on_TopBar_mouse_exited() -> void:
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


func _on_Exit_pressed():
	queue_free()
