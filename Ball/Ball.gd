extends RigidBody
class_name Ball

onready var cam_ball := $CamBall as Camera
onready var mesh := $MeshSphere as MeshInstance

export(Material) var material = null
export var rot_speed = 5.0

var _time := -1.0
var dissolving := false


func _ready() -> void:
	_set_ball_material()
	reset_dissolve()


func _process(delta: float) -> void:
	if dissolving:
		_time += delta
		_set_dissolve_shader()


func _physics_process(delta: float) -> void:
	var dir := Vector3()
	var cam_xform := cam_ball.get_global_transform()

	# Pegar direção que o jogador quer andar para em relação a camera
	dir += -cam_xform.basis[2] * Input.get_action_strength("move_up")
	dir +=  cam_xform.basis[2] * Input.get_action_strength("move_down")
	dir += -cam_xform.basis[0] * Input.get_action_strength("move_left")
	dir +=  cam_xform.basis[0] * Input.get_action_strength("move_right")

	# Achar vetor de direção com eixo Y igual a zero (no plano XZ)
	var target_dir := (dir - Vector3.UP*dir.dot(Vector3.UP))

	# Achar vetor no plano XZ à +90 graus da direção que se deseja ir para
	# var target_axis := Vector3.UP.cross(target_dir).normalized()
	var target_axis := target_dir.rotated(Vector3.UP, PI/2)

	# Aplicar torque a bola para que ela gire no sentido desejado
	add_torque(target_axis*rot_speed)


func dissolve() -> void:
	dissolving = true
	_time = -1.0


func reset_dissolve() -> void:
	dissolving = false
	_time = -1.0
	_set_dissolve_shader()


func _set_dissolve_shader() -> void:
	var mat := mesh.get_surface_material(0) as ShaderMaterial
	var time = mat.get_shader_param("time")
	mat.set_shader_param("_time", _time)

func _set_ball_material() -> void:
	if not material and SaveManager.save.has("ball"):
		material = load(SaveManager.save.ball)
	if material:
		mesh.set_surface_material(0, material)
	if mesh.get_surface_material(0) == preload("res://Ball/Materials/white_plastic_dissolve.tres"):
		$MeshSphere/Sprite3D.visible = true
	else:
		$MeshSphere/Sprite3D.visible = false