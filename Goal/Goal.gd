extends Spatial

signal ball_entered
signal animation_finished

onready var tween: Tween = $Tween

func _on_Area_body_entered(body: Ball) -> void:
	if not body:
		return

	print("Ball entered")
	emit_signal("ball_entered")

	body.custom_integrator = true
	body.gravity_scale = 0
	body.linear_velocity = Vector3()
	body.angular_velocity = Vector3()
	tween.interpolate_property(body, "translation", body.global_transform.origin, self.global_transform.origin + Vector3(0, 5, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

	yield(tween, "tween_completed")
	print("Goal animation finished")
	emit_signal("animation_finished")
