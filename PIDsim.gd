extends Node2D

var inflow: float = 300.0
var volum: float = 10.0
var innhold: float = 0.0
var outflow: float = 0.0
var level: float = 0.0
var level_noise: float = 0.0
var current_noise: float = 0.0
var noise_hz: int = 10
var prosessverdi


func _ready():
	prosessverdi = get_node("ProsessVerdi")


func _physics_process(delta):
	if Engine.get_frames_drawn() % Engine.iterations_per_second / noise_hz == 0:
		current_noise = rand_range(level_noise, -level_noise)
	
	innhold += (inflow * delta / 3600) - (outflow * delta / 3600)
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
