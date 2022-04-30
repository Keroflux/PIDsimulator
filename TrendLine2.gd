extends Node2D


var data_points: Array = []
var data_source: Node
var trend_box: Node
var distance: float
var newDistx: float = 0
var scaleY: float = 0
var maxValue: float = 100
var minValue: float = 0
var pos: Vector2 = Vector2(0,0)
var trend: Array = [Vector2(0,0), Vector2(0,0)]
var color: Color = Color(1.0, 1.0, 1.0)
var parent: Node
var time: float = 600
var timer: Timer


func _ready() -> void:
	parent = get_parent().get_parent()
	calculate_point_distance()
	pos.x = 0
	pos.y = parent.rect_size.y
	var minmax = maxValue - minValue
	scaleY = parent.rect_size.y / minmax
#	draw_trend()


func _draw() -> void:
	draw_polyline(trend, color, 1.0)


func _on_Timer_timeout() -> void:
	redraw_trend(data_source.trend)
	update()


func draw_trend() -> void:
	newDistx = 0
	trend.clear()
	for i in data_points:
		var a = (-i + minValue) * scaleY
		trend.append(Vector2(newDistx, parent.rect_size.y + a))
		newDistx += distance


func redraw_trend(data_point: float) -> void:
	#time = sec/timer.wait_time
	if data_points.size() > time:
		data_points.pop_front()
	
	data_points.append(data_point)
	
	if data_points.size() > 1:
		calculate_point_distance()
#		find_max()
		draw_trend()


func calculate_point_distance() -> void:
	distance = parent.rect_size.x / (data_points.size() -1)


func change_color(c) -> void:
	color = c


func change_max(value: float) -> void:
	maxValue = float(value)
	var minmax = maxValue - minValue
	scaleY = parent.rect_size.y / minmax


func change_min(value: float) -> void:
	minValue = float(value)
	var minmax = maxValue - minValue
	scaleY = parent.rect_size.y / minmax


func change_scale_y() -> void:
	pos.y = parent.rect_size.y
	var minmax = maxValue - minValue
	scaleY = parent.rect_size.y / minmax


func change_time_scale(t: int) -> void:
	time = t / timer.wait_time
	while data_points.size() > time:
		data_points.pop_front()
