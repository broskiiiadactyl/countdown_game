extends Node3D

var is_mouse_over : bool = true
var door : String

@onready var camera_pos : Vector3 = %CameraPos.global_position

var test : String = ""
var test2 : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door = "Foyer"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	test = str(get_instance_id()) + " " + door
	if test == test2:
		pass
	else: 
		test2 = test
		print(test2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and is_mouse_over:
		get_viewport().set_input_as_handled()	#prevents double clicks on accident
		get_parent().transition_to_room(door)


#Left Door
func _on_door_l_mouse_entered() -> void:
	is_mouse_over = true
	door = "Left"
	Input.set_custom_mouse_cursor(Globals.door)

func _on_door_l_mouse_exited() -> void:
	is_mouse_over = false
	door = "Foyer"
	Input.set_custom_mouse_cursor(Globals.arrow)


#Right Door
func _on_door_r_mouse_entered() -> void:
	is_mouse_over = true
	door = "Right"
	Input.set_custom_mouse_cursor(Globals.door)

func _on_door_r_mouse_exited() -> void:
	is_mouse_over = false
	door = "Foyer"
	Input.set_custom_mouse_cursor(Globals.arrow)


#Front Door
func _on_door_f_mouse_entered() -> void:
	is_mouse_over = true
	door = "Front"
	Input.set_custom_mouse_cursor(Globals.door)

func _on_door_f_mouse_exited() -> void:
	is_mouse_over = false
	door = "Foyer"
	Input.set_custom_mouse_cursor(Globals.arrow)
