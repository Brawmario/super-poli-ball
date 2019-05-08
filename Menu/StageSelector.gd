extends MarginContainer

var level_scene

signal level_selected(packed_level)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_but_stage1_pressed():
	var level_scene = preload("res://Stages/Stage1/Stage1.tscn")
	emit_signal("level_selected", level_scene)


func _on_but_stage2_pressed():
	pass # Replace with function body.


func _on_but_stage3_pressed():
	var level_scene = preload("res://Stages/Stage3/Stage3.tscn")
	emit_signal("level_selected", level_scene)


func _on_but_stage4_pressed():
	pass # Replace with function body.


func _on_but_stage5_pressed():
	var level_scene = preload("res://Stages/Stage5/Stage5.tscn")
	emit_signal("level_selected", level_scene)
