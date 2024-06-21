extends Node2D


var data_points: Array = []
var data_source: Node
var trend_box: Node
var trend_label: Node
var distance: float
var new_dist_x: float = 0
var scale_y: float = 0
var max_value: float = 100
var min_value: float = 0
var pos: Vector2 = Vector2(0,0)
var trend: Array = [Vector2(0,0), Vector2(0,0)]
var color: Color = Color(1.0, 1.0, 1.0)
var parent: Node
var time: float = 600
var timer: Timer
var auto_scale_y: bool = false


func _ready() -> void:
	parent = get_parent().get_parent()
	calculate_point_distance()
	pos.x = 0
	pos.y = parent.size.y
	var minmax: float = max_value - min_value
	scale_y = parent.size.y / minmax
#	draw_trend()


func _draw() -> void:
	draw_polyline(trend, color, 1.0)


func _on_Timer_timeout() -> void:
	redraw_trend(data_source.trend)
	queue_redraw()


func draw_trend() -> void:
	new_dist_x = 0
	trend.clear()
	for i in data_points:
		var a: float = (-i + min_value) * scale_y
		trend.append(Vector2(new_dist_x, parent.size.y + a))
		new_dist_x += distance


func redraw_trend(data_point: float) -> void:
	#time = sec/timer.wait_time
	if data_points.size() > time:
		data_points.pop_front()
	
	data_points.append(data_point)
	
	if data_points.size() > 1:
		calculate_point_distance()
		if auto_scale_y:
			find_max()
		draw_trend()


func calculate_point_distance() -> void:
	distance = parent.size.x / (data_points.size() -1)


func change_color(c) -> void:
	color = c


func find_max():
	scale_y = 0
	max_value = -9999
	min_value = 9999
	for i in data_points:
		if i > max_value:
			max_value = i
		if i < min_value:
			min_value = i
	
	var minmax = max_value - min_value
	if minmax == 0:
		minmax = 1
	scale_y = parent.size.y / (minmax)
	


func change_max(value: String) -> void:
	max_value = float(value)
	var minmax: float = max_value - min_value
	if ! minmax == 0:
		scale_y = parent.size.y / minmax


func change_min(value: String) -> void:
	min_value = float(value)
	var minmax: float = max_value - min_value
	if ! minmax == 0:
		scale_y = parent.size.y / minmax


func change_scale_y() -> void:
	pos.y = parent.size.y
	var minmax: float = max_value - min_value
	if ! minmax == 0:
		scale_y = parent.size.y / minmax


func change_time_scale(t: int) -> void:
	time = t / timer.wait_time
	while data_points.size() > time:
		data_points.pop_front()


func set_auto_scale_y(enable: bool) -> void:
	auto_scale_y = enable
	trend_label.get_node("Config/VBoxContainer/Max").editable = !enable
	trend_label.get_node("Config/VBoxContainer/Max").text = str(max_value)
	trend_label.get_node("Config/VBoxContainer/Min").editable = !enable
	trend_label.get_node("Config/VBoxContainer/Min").text = str(min_value)
