extends Node2D


var data_points = []
var data_source
var trend_box
var distance
var newDistx = 0
var scaleY = 0
var maxValue = 100
var minValue = 0
var pos = Vector2(0,0)
var trend = [Vector2(0,0), Vector2(0,0)]
var color = Color(1.0, 1.0, 1.0)
var parent


func _ready():
	parent = get_parent().get_parent()
	calculate_point_distance()
	pos.x = 0
	pos.y = parent.rect_size.y
	var minmax = maxValue - minValue
	scaleY = parent.rect_size.y / minmax
#	draw_trend()


func _draw():
	draw_polyline(trend, color, 1.0)


func _on_Timer_timeout():
	redraw_trend(data_source.trend)
	update()


func draw_trend():
	newDistx = 0
	trend.clear()
	for i in data_points:
		var a = (-i + minValue) * scaleY
		trend.append(Vector2(newDistx, parent.rect_size.y + a))
		newDistx += distance


func redraw_trend(data_point):
	#time = sec/timer.wait_time
	if data_points.size() > 600:
		data_points.pop_front()
	
	data_points.append(data_point)
	
	if data_points.size() > 1:
		calculate_point_distance()
#		find_max()
		draw_trend()


func calculate_point_distance():
	distance = parent.rect_size.x / (data_points.size() -1)


func change_color(c):
	color = c


func change_max(value):
	maxValue = float(value)
	var minmax = maxValue - minValue
	scaleY = parent.rect_size.y / minmax


func change_min(value):
	minValue = float(value)
	var minmax = maxValue - minValue
	scaleY = parent.rect_size.y / minmax


func change_scale_y():
	pos.y = parent.rect_size.y
	var minmax = maxValue - minValue
	scaleY = parent.rect_size.y / minmax
