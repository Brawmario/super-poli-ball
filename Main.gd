extends Node

var ball_scene = preload("res://Ball/Ball.tscn")
var level
var ball: Ball
var in_level := false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("return") and in_level:
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

func _on_StageSelector_ball_pressed():
	$StageSelector.hide()
	var ball_selector = preload("res://Menu/BallSelector.tscn").instance()
	add_child(ball_selector)
	yield(ball_selector, "ball_chosen")
	remove_child(ball_selector)
	ball_selector.queue_free()
	SaveManager.save_dict_to_file()
	$StageSelector.show()

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
