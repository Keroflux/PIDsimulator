extends Node2D

var lt
var sp
var utgang


func _ready():
	lt = get_parent().get_parent().get_node("ProsessVerdi")
	sp = get_parent().get_parent().get_node("Setpunkt")
	utgang = get_parent().get_parent().get_node("Pådrag")


func read_trend():
	var a = [lt.prosess_verdi, sp.setpunkt, utgang.utgang]
	return a


func _on_Timer_timeout():
	var a = read_trend()
	$Trend.redraw_trend(a)

