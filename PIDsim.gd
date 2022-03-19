extends Node2D

var inflow: float = 300.0
var volum: float = 10.0
var innhold: float = 0.0
var outflow: float = 0.0
var level: float = 0.0
var level_noise: float = 0.0
var current_noise: float = 0.0
var noise_hz: int = 10
var flow_variation: float = 10.0
var flow_var: float = 0.0
var flow_var_max: float = 0.0
var flow_var_time: float = 1.0
var flow_var_max_time: float = 60.0
var time: float = 0.0
var random: bool = false
var prosessverdi


func _ready():
	prosessverdi = get_node("Blokkdiagram/ProsessVerdi")


func _physics_process(delta):
	time += delta
	if Engine.get_frames_drawn() % Engine.iterations_per_second / noise_hz == 0:
		current_noise = rand_range(level_noise, -level_noise)
	
	if flow_var_max > 0:
		flow_var =  flow_variation * sin(time * flow_var_time)
		if flow_var - abs(flow_var) == 0 and random:
			flow_variation = rand_range(1, inflow * flow_var_max)
			flow_var_time = rand_range(flow_var_max_time, 1)
			time = 0
			random = false
		elif not flow_var - abs(flow_var) == 0 and not random:
			random = true
	
	innhold += ((inflow + flow_var) * delta / 3600) - (outflow * delta / 3600)
	level = (innhold / volum * 100) + current_noise
	prosessverdi.prosess_verdi = level
	


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


func _on_FlowVariasjonTid_text_entered(new_text):
	flow_var_max_time = 1.0 / float(new_text)
