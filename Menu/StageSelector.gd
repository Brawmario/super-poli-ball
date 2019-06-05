extends MarginContainer

const DUMMY_TIME := "--:--.---"

signal level_selected(packed_level)
signal ball_pressed


func update_times():
	var keys_to_remove := []
	for stage in SaveManager.save:
		var label := find_node("Time" + stage) as Label
		if not label:
			# Invalid level name, mark for deletion and skip
			# keys_to_remove.push_back(stage)
			continue
		label.text = FN.seconds_to_mm_ss_mmm(SaveManager.save[stage].time)
	# for key in keys_to_remove:
		# SaveManager.save.erase(key)


func _ready():
	update_times()


func _on_ButStage1_pressed():
	var level_scene = preload("res://Stages/Stage1/Stage1.tscn")
	emit_signal("level_selected", level_scene)


func _on_ButStage2_pressed():
	var level_scene = preload("res://Stages/Stage2/Stage2.tscn")
	emit_signal("level_selected", level_scene)


func _on_ButStage3_pressed():
	var level_scene = preload("res://Stages/Stage3/Stage3.tscn")
	emit_signal("level_selected", level_scene)


func _on_ButStage4_pressed():
	var level_scene = preload("res://Stages/Stage4/Stage4.tscn")
	emit_signal("level_selected", level_scene)


func _on_ButStage5_pressed():
	var level_scene = preload("res://Stages/Stage5/Stage5.tscn")
	emit_signal("level_selected", level_scene)


func _on_ButStage6_pressed():
	var level_scene = preload("res://Stages/Stage6/Stage6.tscn")
	emit_signal("level_selected", level_scene)


func _on_ButStage7_pressed():
	var level_scene = preload("res://Stages/Stage7/Stage7.tscn")
	emit_signal("level_selected", level_scene)


func _on_ButStage8_pressed():
	var level_scene = preload("res://Stages/Stage8/Stage8.tscn")
	emit_signal("level_selected", level_scene)


func _on_ButClearTimes_pressed():
	for label in get_tree().get_nodes_in_group("TimeLabels"):
		SaveManager.save.clear()
		SaveManager.save_dict_to_file()
		label.text = DUMMY_TIME


func _on_ButBola_pressed():
	emit_signal("ball_pressed")
