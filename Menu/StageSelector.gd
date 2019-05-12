extends MarginContainer

var level_scene

signal level_selected(packed_level)

func _ready():
	pass # Replace with function body.

func _on_ButStage1_pressed():
	var level_scene = preload("res://Stages/Stage1/Stage1.tscn")
	emit_signal("level_selected", level_scene)

func _on_ButStage2_pressed():
	pass # Replace with function body.

func _on_ButStage3_pressed():
	var level_scene = preload("res://Stages/Stage3/Stage3.tscn")
	emit_signal("level_selected", level_scene)

func _on_ButStage4_pressed():
	pass # Replace with function body.

func _on_ButStage5_pressed():
	var level_scene = preload("res://Stages/Stage5/Stage5.tscn")
	emit_signal("level_selected", level_scene)
