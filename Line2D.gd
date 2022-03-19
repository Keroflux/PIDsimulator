extends Line2D

var pos = Vector2(0,0)
var tag
#onready var trend = get_parent().get_parent().get_node(tag)
var trend
var time = 0
var timeScale = 10
var upperLimit = 15
var lowerLimit = 0
var trendScale



func plot_point(value):
	var offset = 2
	var scale = 0.15
	global_position -= Vector2(offset, 0)
	pos += Vector2(offset, 0)
	add_point(pos - Vector2(0, float(value) * scale))
	if get_point_count() > 1000:
		remove_point(0)


func change_scaling(scale):
	for point in get_point_count():
		var pointPos = get_point_position(point)
		pointPos = Vector2(pointPos.x, pointPos.y * scale)
		set_point_position(point, pointPos)


func change_min(new_text):
#	var pLimits = lowerLimit
#	lowerLimit = float(new_text)
#	var limits = upperLimit - lowerLimit
#	if limits == 0:
#		limits = 1
#	if pLimits == 0:
#		pLimits = 1
#	var newScale = lowerLimit / pLimits
#	trendScale = get_parent().get_node("TrendBackground").rect_size.y / limits
#	change_scaling(newScale)
	pass



func change_max(new_text):
	var pLimits = upperLimit - lowerLimit
	upperLimit = float(new_text)
	var limits = upperLimit - lowerLimit
	if limits == 0:
		limits = 1
	var newScale = pLimits / limits
	trendScale = get_parent().get_node("TrendBackground").rect_size.y / limits
	change_scaling(newScale)


func change_color(color):
	default_color = color


func change_thickness(value):
	width = value

