extends Control

signal ball_chosen

func _ready():
	if not SaveManager.save.has("ball"):
		$HBoxContainer/ButMadeira.grab_focus()
	else:
		match SaveManager.save.ball:
			"res://Ball/Materials/wood_dissolve_shader.tres":
				$HBoxContainer/ButMadeira.grab_focus()
			"res://Ball/Materials/white_plastic_dissolve.tres":
				$HBoxContainer/ButGNU.grab_focus()


func _on_ButMadeira_pressed():
	SaveManager.save.ball = "res://Ball/Materials/wood_dissolve_shader.tres"
	emit_signal("ball_chosen")


func _on_ButGNU_pressed():
	SaveManager.save.ball = "res://Ball/Materials/white_plastic_dissolve.tres"
	emit_signal("ball_chosen")
