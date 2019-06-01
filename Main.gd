extends Node

var ball_scene = preload("res://Ball/Ball.tscn")
var level
var ball: Ball
var in_level = false

func _ready():
	SaveManager.load_save()

func _unhandled_input(event) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_R and in_level:
			free_level()
			SaveManager.save_dict_to_file()
			$StageSelector.update_times()
			$StageSelector.show()


func _on_StageSelector_level_selected(packed_level: PackedScene) -> void:
	$StageSelector.hide()
	load_level(packed_level)


func _on_StageTemplate_level_ended(next_level_file: String) -> void:
	if not next_level_file:
		print("No next level to load")
		return

	free_level()
	load_level(load(next_level_file))


func load_level(packed_level: PackedScene) -> void:
	level = packed_level.instance()
	print("Loading level \"", level.name, "\"")
	level.connect("level_ended", self, "_on_StageTemplate_level_ended")
	add_child(level)

	ball = ball_scene.instance() as Ball
	ball.global_transform = level.get_node("Start").global_transform
	add_child(ball)
	in_level = true


func free_level() -> void:
	print("Unloading level \"", level.name, "\"")
	remove_child(level)
	level.queue_free()
	remove_child(ball)
	ball.queue_free()
	in_level = false
