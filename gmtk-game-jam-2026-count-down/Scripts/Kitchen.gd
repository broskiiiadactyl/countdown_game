extends Node3D

var is_door_mouse_over : bool = true
var door : String

@onready var camera_pos : Vector3 = %CameraPos.global_position
@onready var camera_basis : Basis = %CameraPos.global_basis
var max_yaw : float = 100.0

var test : String = ""
var test2 : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door = "Kitchen"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#test = str(get_instance_id()) + " " + door
	#if test == test2:
		#pass
	#else: 
		#test2 = test
		#print(test2)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and is_door_mouse_over:
		get_viewport().set_input_as_handled()	#prevents double clicks on accident
		Globals.transition_to_room(door)


#Left Door
func _on_door_l_mouse_entered() -> void:
	is_door_mouse_over = true
	door = "Foyer"
	Input.set_custom_mouse_cursor(Globals.door)

func _on_door_l_mouse_exited() -> void:
	is_door_mouse_over = false
	door = "Kitchen"
	Input.set_custom_mouse_cursor(Globals.arrow)
