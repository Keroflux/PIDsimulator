extends Line2D

var data_points = []
var data_source
var trend_box
var distance
var newDistx = 0
var scaleY = 0
var maxValue = 100
var minValue = 0


func _ready():
	trend_box = get_parent().get_parent()
#	data_source = get_parent().get_parent().get_parent().get_node("Blokkdiagram/ProsessVerdi")
	calculate_point_distance()
	position.x = 0
	position.y = trend_box.rect_size.y
	var minmax = maxValue - minValue
	scaleY = trend_box.rect_size.y / minmax
	draw_trend()


func _on_Timer_timeout():
	redraw_trend(data_source.trend)


func calculate_point_distance():
	distance = trend_box.rect_size.x / (data_points.size() -1)


func draw_trend():
	newDistx = 0
	clear_points()
	
	for i in data_points:
		add_point(Vector2(newDistx, (-i + minValue) * scaleY))
		newDistx += distance


func redraw_trend(data_point):
	if data_points.size() > 1500:
		data_points.pop_front()
	
	data_points.append(data_point)
	
	if data_points.size() > 1:
		calculate_point_distance()
#		find_max()
		draw_trend()
