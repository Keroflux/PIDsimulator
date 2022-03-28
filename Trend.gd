extends ColorRect

var trend_label = preload("res://TrendLabel.tscn")
var trend_line = preload("res://TrendLine.tscn")
var trend_color = [Color(1.0, 1.0, 1.0), Color(0.0, 0.0, 1.0), Color(1.0, 0.0, 0.0), Color(0.0, 1.0, 0.0), Color(0.0, 1.0, 1.0), Color(1.0, 1.0, 0.0), Color(1.0, 0.0, 1.0)]
onready var trends = [get_parent().get_parent().get_node("Blokkdiagram/ProsessVerdi"), get_parent().get_parent().get_node("Blokkdiagram/Setpunkt"),get_parent().get_parent().get_node("Blokkdiagram/Pådrag"),get_parent().get_parent().get_node("Blokkdiagram/Ventil")]
onready var label_panel = get_parent().get_node("PanelContainer/VSplitContainer/VBoxContainer")


func _ready() -> void:
	for i in trends.size():
		var t = trend_line.instance()
		var l = trend_label.instance()
		t.default_color = trend_color[i]
		t.data_source = trends[i]
		
		l.get_child(0).color = trend_color[i]
		l.get_child(0).connect("color_changed", t, "change_color")
		l.get_node("Config/VBoxContainer/Max").connect("text_entered", t, "change_max")
		l.get_node("Config/VBoxContainer/Min").connect("text_entered", t, "change_min")
		l.get_node("Config/VBoxContainer/Slett").connect("pressed", self, "remove_trend", [t, l])
		l.text = "  " + trends[i].type
		
		label_panel.add_child(l)
		$TrendLines.add_child(t)
		get_parent().get_node("Timer").connect("timeout", t, "_on_Timer_timeout")


func _on_Timer_timeout() -> void:
	for i in $TrendLines.get_child_count():
		$TrendLines.get_child(i).redraw_trend(trends[i].trend)


func add_trend(data_point):
	var t = trend_line.instance()
	var l = trend_label.instance()
	t.data_source = data_point
	$TrendLines.add_child(t)
	label_panel.add_child(l)


func remove_trend(trend, label):
	label.queue_free()
	trend.queue_free()


func _on_Bakgrunn_color_changed(c):
	color = c
