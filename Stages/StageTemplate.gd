extends Spatial

signal level_ended(next_level_file)

export(String, FILE) var next_level_file

var time := 0.0
var level_ended := false

func _process(delta: float) -> void:
	if not level_ended:
		time += delta
		$StageUI/Time.text = FN.seconds_to_mm_ss_mmm(time)


func _on_Goal_ball_entered():
	level_ended = true
	SaveManager.save_best_stage_time(name, time)


func _on_Goal_animation_finished():
	emit_signal("level_ended", next_level_file)


func _on_KillBox_body_entered(body: Ball):
	if not body:
		return

	body.dissolve()

	yield(get_tree().create_timer(2.0), "timeout")
	body.reset_dissolve()
	body.linear_velocity = Vector3()
	body.angular_velocity = Vector3()
	body.global_transform = $Start.global_transform
	body.cam_ball.global_transform.origin = $Start.global_transform.origin + Vector3(0, 2.5, 5).rotated(Vector3.UP, $Start.rotation.y)
