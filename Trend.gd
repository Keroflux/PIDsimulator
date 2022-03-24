extends ColorRect

var trend_label = preload("res://TrendLabel.tscn")
var trend_line = preload("res://TrendLine.tscn")
var trend_color = [Color(1.0, 1.0, 1.0), Color(0.0, 0.0, 1.0), Color(1.0, 0.0, 0.0), Color(0.0, 1.0, 0.0)]
onready var trends = [get_parent().get_parent().get_node("Blokkdiagram/ProsessVerdi"), get_parent().get_parent().get_node("Blokkdiagram/Setpunkt"),get_parent().get_parent().get_node("Blokkdiagram/Pådrag"),get_parent().get_parent().get_node("Blokkdiagram/Ventil")]
onready var label_panel = get_parent().get_node("PanelContainer/VBoxContainer")


func _ready() -> void:
	for i in trends.size():
		var t = trend_line.instance()
		var l = trend_label.instance()
		t.default_color = trend_color[i]
		
		l.get_child(0).color = trend_color[i]
		l.get_child(0).connect("color_changed", t, "change_color")
		l.text = "  " + trends[i].type
		
		label_panel.add_child(l)
		$TrendLines.add_child(t)


func _on_Timer_timeout() -> void:
	for i in $TrendLines.get_child_count():
		$TrendLines.get_child(i).redraw_trend(trends[i].trend)


func add_trend():
	pass
