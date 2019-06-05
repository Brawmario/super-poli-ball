extends Control

signal ball_chosen


func _on_ButMadeira_pressed():
	SaveManager.save.ball = "res://Ball/Materials/wood_dissolve_shader.tres"
	emit_signal("ball_chosen")


func _on_ButGNU_pressed():
	SaveManager.save.ball = "res://Ball/Materials/white_plastic_dissolve.tres"
	emit_signal("ball_chosen")
