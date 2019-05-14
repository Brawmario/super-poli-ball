extends Spatial

signal level_ended(next_level_file)

export(String, FILE) var next_level_file


func _on_Goal_animation_finished():
	emit_signal("level_ended", next_level_file)
