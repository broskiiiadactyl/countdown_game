extends Node3D

@onready var collision := $"."
var is_mouse_over := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_jornal_area_mouse_entered() -> void:
	is_mouse_over = true
	Input.set_default_cursor_shape(Input.CURSOR_HELP)


func _on_jornal_area_mouse_exited() -> void:
	is_mouse_over = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
