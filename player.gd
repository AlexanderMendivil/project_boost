extends Node3D


# Called when the node enters the scene tree for the first time.
var timer: float = 0.0
var increase: int = 0

func _ready() -> void:
	var my_number: int = 10
	print(my_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		position.y += delta 
	
	if(Input.is_action_pressed("ui_left")):
		rotate_z(delta)
	
	if(Input.is_action_pressed("ui_right")):
		rotate_z(-delta)
	
