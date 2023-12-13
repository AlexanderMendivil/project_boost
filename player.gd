extends RigidBody3D

## How much vertical force to apply when pressing the jump button.
@export_range(0.0, 1000.0) var thrust: float = 1000.0

## How much torque apply when pressing the left, right keys.
@export_range(0.0, 100.0) var torque: float = 100.0

var is_transitioning: bool = false
var timer: float = 0.0
var increase: int = 0

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		_on_effects_playing()
	else:
		rocket_audio.stop()
		booster_particles.emitting = false
		
	
	if(Input.is_action_pressed("rotate_left")):
		right_booster_particles.emitting = true
		apply_torque(Vector3(0.0, 0.0, torque) * delta)
	else:
		right_booster_particles.emitting = false
		
	if(Input.is_action_pressed("rotate_right")):
		left_booster_particles.emitting = true
		apply_torque(Vector3(0.0, 0.0, -torque) * delta)
	else:
		left_booster_particles.emitting = false
	


func _on_body_entered(body:Node) -> void:

	if is_transitioning == false:
		if Groups.GOAL in body.get_groups():
			complete_level(body.file_path)
		elif Groups.LOOSE in body.get_groups():
			crash_sequence()


func crash_sequence() -> void:

	explosion_audio.play()	
	is_transitioning = true
	var tween = create_tween()
	set_process(false)
	tween.tween_interval(explosion_audio.stream.get_length() + 0.5)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_level(next_level_file: String) -> void:
	success_audio.play()  
	is_transitioning = true
	set_process(false)
	var tween = create_tween()
	tween.tween_interval(success_audio.stream.get_length() + 0.2)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))

func _on_effects_playing() -> void:
	if rocket_audio.playing == false:
		booster_particles.emitting = true
		rocket_audio.play()

class Groups:
	static var GOAL = "GOAL"
	static var LOOSE = "LOOSE"
