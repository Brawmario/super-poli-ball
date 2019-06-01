extends Node

var save := {}
const SAVE_PATH := "user://save.json"

func load_save() -> void:
	var save_file := File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	save_file.open(SAVE_PATH, File.READ)
	var json := JSON.parse(save_file.get_as_text())
	save = json.result
	save_file.close()


func save_dict_to_file() -> void:
	var save_file := File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_string(JSON.print(save))
	save_file.close()


func save_stage_time(stage: String, time: float) -> void:
	if not save.has(stage):
		save[stage] = {}
	save[stage].time = time


func save_best_stage_time(stage: String, time: float) -> void:
	if not save.has(stage) or time < save[stage].time:
		save_stage_time(stage, time)
