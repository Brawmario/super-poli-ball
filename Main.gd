extends Spatial

var ball_scene = preload("res://Ball/Ball.tscn")
var level
var ball

var in_level = false
# Called when the node enters the scene tree for the first time.
func _ready():
#	var level = level_scene.instance()
#	add_child(level)
#
#	var ball := ball_scene.instance() as Ball
##	ball.global_transform = level.get_node("start").global_transform
#	# ball.global_translate(Vector3(0, 5, 0))
#	add_child(ball)

	$StageSelector.connect("level_selected", self, "_on_level_selected")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_level_selected(packed_level):
	$StageSelector.hide()
	level = packed_level.instance()
	add_child(level)

	ball = ball_scene.instance() as Ball
	ball.global_transform = level.get_node("start").global_transform
	# ball.global_translate(Vector3(0, 5, 0))
	add_child(ball)
	in_level = true

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_R and in_level:
			in_level = false
			remove_child(level)
			remove_child(ball)
			$StageSelector.show()
