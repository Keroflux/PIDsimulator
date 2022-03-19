extends ColorRect

var level = []
var sp = []
var utgang = []
var distance
var newDistx = 0
var scaleY = 0
var maxValue = 100
var minValue = 0


func _ready():
#	for i in range(1990):
#		values.append(rand_range(0, 2000))
	calculate_point_distance()
	scaleY = rect_size.y / 100
	draw_trend()


func calculate_point_distance():
	distance = rect_size.x / (level.size() -1)


func find_max():
	scaleY = 0
	maxValue = 0
	minValue = 9999
	for i in level:
		if i > maxValue:
			maxValue = i
		if i < minValue:
			minValue = i
	
	var minmax = maxValue - minValue
	if minmax == 0:
		minmax = 1
		
	scaleY = rect_size.y / (minmax)
	
	var diff = maxValue - minValue


func draw_trend():
	newDistx = 0
	$Level.clear_points()
	$Setpunkt.clear_points()
	$Utgang.clear_points()
	for i in level:
		$Level.add_point(Vector2(newDistx, (-i + minValue) * scaleY))
		newDistx += distance
	newDistx = 0
	for i in sp:
		$Setpunkt.add_point(Vector2(newDistx, (-i + minValue) * scaleY))
		newDistx += distance
	newDistx = 0
	for i in utgang:
		$Utgang.add_point(Vector2(newDistx, (-i + minValue) * scaleY))
		newDistx += distance


func redraw_trend(data_point):
	if level.size() > 500:
		level.pop_front()
		sp.pop_front()
		utgang.pop_front()
	level.append(data_point[0])
	sp.append(data_point[1])
	utgang.append(data_point[2])
	if level.size() > 1:
		calculate_point_distance()
#		find_max()
		draw_trend()


