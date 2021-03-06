extends Node2D

var inflow: float = 300.0
var volum: float = 10.0
var innhold: float = 0.0
var outflow: float = 0.0
var level: float = 0.0
var level_noise: float = 0.0
var current_noise: float = 0.0
var noise_hz: float = 10.0
var flow_variation: float = 0.0
var old_flow_variation = 0.0
var flow_var: float = 0.0
var flow_var_max: float = 0.0
var flow_var_time: float = 0.0
var flow_var_max_time: float = 60.0
var time: float = 0.0
var random: bool = false
var prosessverdi: Node
var trend : float = 0.0
var type: String = "Flow"


func _ready() -> void:
	randomize()
	prosessverdi = get_node("Blokkdiagram/ProsessVerdi")
	random_flow()


func _physics_process(delta: float) -> void:
	time += delta
	if Engine.get_frames_drawn() % Engine.iterations_per_second / noise_hz == 0:
		current_noise = rand_range(level_noise, -level_noise)
	
	innhold += (inflow + flow_var - outflow ) * delta / 3600
	level = (innhold / volum * 100) + current_noise
	prosessverdi.prosess_verdi = level
	trend = inflow + flow_var


func random_flow() -> void:
	old_flow_variation = flow_variation
	flow_var_time = rand_range(0, flow_var_max_time)
	flow_variation = rand_range(-inflow * flow_var_max, inflow * flow_var_max)
	if flow_var_max > 0:
		$Tween.interpolate_property(self, "flow_var", old_flow_variation, flow_variation, flow_var_time,Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()


func _on_InnFlow_text_entered(new_text: String) -> void:
	inflow = float(new_text)


func _on_TankSize_text_entered(new_text: String):
	volum = float(new_text)


func _on_Mlesty_text_entered(new_text: String):
	level_noise = float(new_text)


func _on_MlestyHZ_text_entered(new_text: String) -> void:
	noise_hz = int(new_text)


func _on_FlowVariasjon_text_entered(new_text: String) -> void:
	flow_var_max = float(new_text) / float(100.0)
	flow_var = 0.0
	flow_variation = 0.0
	$Tween.stop_all()
	if flow_var_max > 0:
		random_flow()


func _on_FlowVariasjonTid_text_entered(new_text: String) -> void:
	flow_var_max_time = float(new_text)
	random_flow()


func _on_Tween_tween_all_completed() -> void:
	random_flow()


func _on_NyTrend_pressed():
	var a = load("res://Trend.tscn")
	a = a.instance()
	add_child(a)
