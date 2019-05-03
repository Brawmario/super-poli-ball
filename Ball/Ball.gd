extends RigidBody
class_name Ball

onready var ball_cam := $ball_cam as Camera

export var rot_speed = 5.0

func _ready() -> void:
	pass

func _physics_process(delta) -> void:

	var dir := Vector3()
	var cam_xform := ball_cam.get_global_transform() as Transform

	# Pegar direção que o jogador quer andar para em relação a camera
	if (Input.is_action_pressed("ui_up")):
		dir += -cam_xform.basis[2]
	if (Input.is_action_pressed("ui_down")):
		dir += cam_xform.basis[2]
	if (Input.is_action_pressed("ui_left")):
		dir += -cam_xform.basis[0]
	if (Input.is_action_pressed("ui_right")):
		dir += cam_xform.basis[0]

	# Achar vetor de direção com eixo Y igual a zero (no plano XZ)
	var target_dir := (dir - Vector3.UP*dir.dot(Vector3.UP)).normalized()

	# Achar vetor no plano XZ à +90 graus da direção que se deseja ir para
	# var target_axis := Vector3.UP.cross(target_dir).normalized()
	var target_axis := target_dir.rotated(Vector3.UP, PI/2)

	# Aplicar torque a bola para que ela gire no sentido desejado
	add_torque(target_axis*rot_speed)
