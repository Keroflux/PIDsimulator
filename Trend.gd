extends Node2D

var trend_label = preload("res://TrendLabel.tscn")
var trend_line = preload("res://TrendLine2.tscn")
var trend_color = [Color(1.0, 1.0, 1.0), Color(0.0, 0.0, 1.0), Color(1.0, 0.0, 0.0), Color(0.0, 1.0, 0.0), Color(0.0, 1.0, 1.0), Color(1.0, 1.0, 0.0), Color(1.0, 0.0, 1.0)]
onready var trends = [get_parent().get_node("Blokkdiagram/ProsessVerdi"), get_parent().get_node("Blokkdiagram/Setpunkt"), get_parent().get_node("Blokkdiagram/Pådrag"), get_parent().get_node("Blokkdiagram/Ventil")]
onready var label_panel = $PanelContainer2/HSplitContainer/PanelContainer/VSplitContainer/ScrollContainer/VBoxContainer


func _ready() -> void:
	for i in trends.size():
		var t = trend_line.instance()
		var l = trend_label.instance()
		t.color = trend_color[i]
#		t.default_color = trend_color[i]
		t.data_source = trends[i]
		l.data_source = trends[i]
		l.get_child(0).get_child(0).color = trend_color[i]
		l.get_child(0).get_child(0).connect("color_changed", t, "change_color")
		l.get_node("Config/VBoxContainer/Max").connect("text_entered", t, "change_max")
		l.get_node("Config/VBoxContainer/Min").connect("text_entered", t, "change_min")
		l.get_node("Config/VBoxContainer/Max").text = str(t.maxValue)
		l.get_node("Config/VBoxContainer/Min").text = str(t.minValue)
		l.get_node("Config/VBoxContainer/Slett").connect("pressed", self, "remove_trend", [t, l])
		l.get_child(0).get_child(1).text = trends[i].type
		
		label_panel.add_child(l)
		$PanelContainer2/HSplitContainer/Trend/TrendLines.add_child(t)
		get_node("Timer").connect("timeout", t, "_on_Timer_timeout")


func _on_Timer_timeout() -> void:
	for i in $PanelContainer2/HSplitContainer/Trend/TrendLines.get_child_count():
		$PanelContainer2/HSplitContainer/Trend/TrendLines.get_child(i).redraw_trend(trends[i].trend)


func add_trend(data_point):
	var t = trend_line.instance()
	var l = trend_label.instance()
	t.data_source = data_point
	t.color = random_color()
#	t.default_color = random_color()
	l.data_source = data_point
	l.get_child(0).get_child(0).color = t.color
#	l.get_child(0).get_child(0).color = t.default_color
	l.get_child(0).get_child(0).connect("color_changed", t, "change_color")
	l.get_node("Config/VBoxContainer/Max").connect("text_entered", t, "change_max")
	l.get_node("Config/VBoxContainer/Min").connect("text_entered", t, "change_min")
	l.get_node("Config/VBoxContainer/Max").text = str(t.maxValue)
	l.get_node("Config/VBoxContainer/Min").text = str(t.minValue)
	l.get_node("Config/VBoxContainer/Slett").connect("pressed", self, "remove_trend", [t, l])
	l.get_child(0).get_child(1).text = data_point.type
	$PanelContainer2/HSplitContainer/Trend/TrendLines.add_child(t)
	label_panel.add_child(l)
	get_node("Timer").connect("timeout", t, "_on_Timer_timeout")


func random_color() -> Color:
	var r = rand_range(0.0, 1.0)
	var g = rand_range(0.0, 1.0)
	var b = rand_range(0.0, 1.0)
	var c = Color(r, g, b)
	
	return c


func remove_trend(trend, label):
	label.queue_free()
	trend.queue_free()


func _on_Bakgrunn_color_changed(c):
	$PanelContainer2/HSplitContainer/Trend.color = c


func _on_Button_pressed():
	if not $PanelContainer.visible:
		$PanelContainer.show()
		for tag in get_tree().get_nodes_in_group("Trend"):
			var a = Button.new()
			a.text = tag.type
			a.connect("pressed", self, "add_trend", [tag])
			$PanelContainer/VBoxContainer/VBoxContainer.add_child(a)


func _on_Lukk_pressed():
	$PanelContainer.hide()
	for child in $PanelContainer/VBoxContainer/VBoxContainer.get_children():
		child.queue_free()


func _on_Trend_resized():
	for t in $PanelContainer2/HSplitContainer/Trend/TrendLines.get_children():
		t.change_scale_y()
