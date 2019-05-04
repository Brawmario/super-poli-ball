extends Spatial

onready var area := $area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_area_body_entered(body: Ball):
	if not body:
		return
	print("body entered")
