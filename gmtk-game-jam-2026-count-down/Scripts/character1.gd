extends StaticBody3D

var is_mouse_over : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and is_mouse_over:
		print(true)


func _on_mouse_entered() -> void:
	is_mouse_over = true
	Input.set_custom_mouse_cursor(Globals.talk)


func _on_mouse_exited() -> void:
	is_mouse_over = false
	Input.set_custom_mouse_cursor(Globals.arrow)
