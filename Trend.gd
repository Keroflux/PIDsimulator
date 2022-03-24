extends ColorRect


onready var trends = [get_parent().get_parent().get_node("Blokkdiagram/ProsessVerdi"), get_parent().get_parent().get_node("Blokkdiagram/Setpunkt"),get_parent().get_parent().get_node("Blokkdiagram/Pådrag"),get_parent().get_parent().get_node("Blokkdiagram/Ventil")]


func _on_Timer_timeout():
	for i in $TrendLines.get_child_count():
		$TrendLines.get_child(i).redraw_trend(trends[i].trend)
