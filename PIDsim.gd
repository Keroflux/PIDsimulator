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
var tw: Tween
var valve_opening : float = 0.0


func _ready() -> void:
	randomize()
	prosessverdi = get_node("Blokkdiagram/ProsessVerdi")
	random_flow()
	innhold = volum * 0.4
	#tw = get_tree().create_tween()


func _physics_process(delta: float) -> void:
	time += delta
	if Engine.get_frames_drawn() % Engine.physics_ticks_per_second / noise_hz == 0:
		current_noise = randf_range(level_noise, -level_noise)
	
	innhold += (inflow + flow_var - outflow ) * delta / 3600
	level = (innhold / volum * 100) + current_noise
	prosessverdi.prosess_verdi = level
	trend = inflow + flow_var
	$TankDrawing/ArrowInn/FlowmeterInn.text = str(snapped(inflow + flow_var, 0.1))
	$TankDrawing/ArrowOut/FlowmeterOut.text = str(snapped(outflow, 0.01))
	$TankDrawing/ArrowOut/Valve/Opening.text = str(snapped(valve_opening, 0.01))
	$TankDrawing/Controller/Polygon2D/ControllerLevel.text = str(snapped(level, 0.1))
	if valve_opening > 0.1:
		$TankDrawing/ArrowOut/Valve.modulate = Color(0.0, 1.0, 0.0, 1.0)
	else:
		$TankDrawing/ArrowOut/Valve.modulate = Color(1.0, 1.0, 1.0, 1.0)


func random_flow() -> void:
	old_flow_variation = flow_variation
	flow_var_time = randf_range(0, flow_var_max_time)
	flow_variation = randf_range(-inflow * flow_var_max, inflow * flow_var_max)
	if flow_var_max > 0:
		tw = create_tween()
		tw.connect("finished", _tw_complete)
		tw.tween_property(self, "flow_var", flow_variation, flow_var_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


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
	#tw.stop()
	if flow_var_max > 0:
		random_flow()


func _on_FlowVariasjonTid_text_entered(new_text: String) -> void:
	flow_var_max_time = float(new_text)
	random_flow()


func _tw_complete() -> void:
	random_flow()


func _on_NyTrend_pressed():
	var a = load("res://Trend.tscn")
	a = a.instantiate()
	add_child(a)
