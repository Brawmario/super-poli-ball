extends Spatial

onready var area := $area
onready var tween := $Tween

func _on_Area_body_entered(body: Ball):
	if not body:
		return
	print("ball entered")

	body.custom_integrator = true
	body.gravity_scale = 0
	body.linear_velocity = Vector3()
	body.angular_velocity = Vector3()
	tween.interpolate_property(body, "translation", body.global_transform.origin, self.global_transform.origin + Vector3(0, 5, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
