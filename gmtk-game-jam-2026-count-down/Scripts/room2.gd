extends Node3D

var is_mouse_over : bool = true
var door : String

@onready var camera_pos : Vector3 = %CameraPos.global_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door = "Foyer"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(get_instance_id(), " ", door)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and is_mouse_over:
		get_parent().transition_to_room(door)


#Left Door
func _on_door_l_mouse_entered() -> void:
	is_mouse_over = true
	door = "Left"
	Input.set_default_cursor_shape(Input.CURSOR_IBEAM)


func _on_door_l_mouse_exited() -> void:
	is_mouse_over = false
	#door = "Foyer"
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


#Right Door
func _on_door_r_mouse_entered() -> void:
	is_mouse_over = true
	door = "Right"
	print("Entered right")
	Input.set_default_cursor_shape(Input.CURSOR_IBEAM)

func _on_door_r_mouse_exited() -> void:
	is_mouse_over = false
	#door = "Foyer"
	print("Exited Right")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
