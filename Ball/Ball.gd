extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_torque(Vector3(-400, 0, -400))
	pass

func _physics_process(delta):
	pass
