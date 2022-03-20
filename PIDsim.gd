extends Node2D

var inflow: float = 300.0
var volum: float = 10.0
var innhold: float = 0.0
var outflow: float = 0.0
var level: float = 0.0
var level_noise: float = 0.0
var current_noise: float = 0.0
var noise_hz: int = 10
var flow_variation: float = 0.0
var old_flow_variation = 0.0
var flow_var: float = 0.0
var flow_var_max: float = 0.0
var flow_var_time: float = 0.0
var flow_var_max_time: float = 60.0
var time: float = 0.0
var random: bool = false
var prosessverdi


func _ready():
	randomize()
	prosessverdi = get_node("Blokkdiagram/ProsessVerdi")
	random_flow()


func _physics_process(delta):
	time += delta
	if Engine.get_frames_drawn() % Engine.iterations_per_second / noise_hz == 0:
		current_noise = rand_range(level_noise, -level_noise)
	
	print(flow_variation)
	innhold += ((inflow + flow_var) * delta / 3600) - (outflow * delta / 3600)
	level = (innhold / volum * 100) + current_noise
	prosessverdi.prosess_verdi = level


func random_flow():
	old_flow_variation = flow_variation
	flow_var_time = rand_range(0, flow_var_max_time)
	flow_variation = rand_range(-inflow * flow_var_max, inflow * flow_var_max)
	if flow_var_max > 0:
		$Tween.interpolate_property(self, "flow_var", old_flow_variation, flow_variation, flow_var_time,Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()


func _on_InnFlow_text_entered(new_text):
	inflow = float(new_text)


func _on_TankSize_text_entered(new_text):
	volum = float(new_text)


func _on_Mlesty_text_entered(new_text):
	level_noise = float(new_text)


func _on_MlestyHZ_text_entered(new_text):
	noise_hz = int(new_text)


func _on_FlowVariasjon_text_entered(new_text):
	flow_var_max = float(new_text) / float(100.0)
	flow_var = 0.0
	flow_variation = 0.0
	$Tween.stop_all()
	if flow_var_max > 0:
		random_flow()


func _on_FlowVariasjonTid_text_entered(new_text):
	flow_var_max_time = float(new_text)
	random_flow()


func _on_Tween_tween_all_completed():
	random_flow()
