extends Spatial

var ball_scene = preload("res://Ball/Ball.tscn")
var level_scene = preload("res://Stages/Stage1/Stage1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var level = level_scene.instance()
	add_child(level)

	var ball := ball_scene.instance() as Ball
	ball.global_transform = level.get_node("start").global_transform
	# ball.global_translate(Vector3(0, 5, 0))
	add_child(ball)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
