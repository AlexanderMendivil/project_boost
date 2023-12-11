extends RigidBody3D

## How much vertical force to apply when pressing the jump button.
@export_range(0.0, 1000.0) var thrust: float = 1000.0

## How much torque apply when pressing the left, right keys.
@export_range(0.0, 100.0) var torque: float = 100.0

var is_transitioning: bool = false
var timer: float = 0.0
var increase: int = 0

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
	
	if(Input.is_action_pressed("rotate_left")):
		apply_torque(Vector3(0.0, 0.0, torque) * delta)
		
	if(Input.is_action_pressed("rotate_right")):
		apply_torque(Vector3(0.0, 0.0, -torque) * delta)
	


func _on_body_entered(body:Node) -> void:

	if is_transitioning == false:
		if Groups.GOAL in body.get_groups():
			complete_level(body.file_path)
		elif Groups.LOOSE in body.get_groups():
			crash_sequence()


func crash_sequence() -> void:
	is_transitioning = true
	var tween = create_tween()
	set_process(false)
	tween.tween_interval(1)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_level(next_level_file: String) -> void:
	is_transitioning = true
	set_process(false)
	var tween = create_tween()
	tween.tween_interval(1)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))

class Groups:
	static var GOAL = "GOAL"
	static var LOOSE = "LOOSE"
