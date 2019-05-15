extends Spatial

signal level_ended(next_level_file)

export(String, FILE) var next_level_file


func _on_Goal_animation_finished():
	emit_signal("level_ended", next_level_file)


func _on_KillBox_body_entered(body: Ball):
	if not body:
		return
	yield(get_tree().create_timer(2.0), "timeout")
	body.linear_velocity = Vector3()
	body.angular_velocity = Vector3()
	body.global_transform = $Start.global_transform
	body.cam_ball.global_transform.origin = $Start.global_transform.origin + Vector3(0, 2.5, 5)
