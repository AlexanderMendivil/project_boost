extends Node3D


# Called when the node enters the scene tree for the first time.
var timer: float = 0.0
var increase: int = 0

func _ready() -> void:
	var my_number: int = 10
	print(my_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		increase += 1
		print(increase)
	
