extends Node2D

var lt
var sp
var utgang
var ventil


func _ready():
	lt = get_parent().get_node("Blokkdiagram/ProsessVerdi")
	sp = get_parent().get_node("Blokkdiagram/Setpunkt")
	utgang = get_parent().get_node("Blokkdiagram/Pådrag")
	ventil = get_parent().get_node("Blokkdiagram/Ventil")


func read_trend():
	var a = [lt.prosess_verdi, sp.setpunkt, utgang.utgang, ventil.ventilpossisjon]
	return a


func _on_Timer_timeout():
	var a = read_trend()
	$Trend.redraw_trend(a)

