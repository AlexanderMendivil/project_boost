extends RigidBody3D


# Called when the node enters the scene tree for the first time.
var timer: float = 0.0
var increase: int = 0

func _ready() -> void:
	var my_number: int = 10
	print(my_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * 1000)
	
	if(Input.is_action_pressed("rotate_left")):
		apply_torque(Vector3(0.0, 0.0, 100.0) * delta)
		
	if(Input.is_action_pressed("rotate_right")):
		apply_torque(Vector3(0.0, 0.0, -100.0) * delta)
	


func _on_body_entered(body:Node) -> void:
	if Groups.GOAL in body.get_groups():
		print("You Win!")
	elif Groups.LOOSE in body.get_groups():
		print("You Lose!")


class Groups:
	static var GOAL = "GOAL"
	static var LOOSE = "LOOSE"
