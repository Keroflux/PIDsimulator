extends ProgressBar

var parent 
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_tree().current_scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	value = parent.level
