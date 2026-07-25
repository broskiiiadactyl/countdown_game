extends Node3D

var is_door_mouse_over : bool = false
var door : String

@onready var camera_pos : Vector3 = %CameraPos.global_position
@onready var camera_basis : Basis = %CameraPos.global_basis
var max_yaw : float = 100.0

@onready var body_pos : Vector3 = %BodyPos.global_position
@onready var item_pos : Vector3 = %ItemPos.global_position
@onready var char_pos1 : Vector3 = %CharacterPos1.global_position
@onready var char_pos2 : Vector3 = %CharacterPos2.global_position
var is_placed : bool = false

var test : String = ""
var test2 : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door = "Foyer"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and is_door_mouse_over:
		get_viewport().set_input_as_handled()	#prevents double clicks on accident
		Globals.transition_to_room(door)


#Left Door
func _on_door_l_mouse_entered() -> void:
	is_door_mouse_over = true
	door = "Library"
	Input.set_custom_mouse_cursor(Globals.door)

func _on_door_l_mouse_exited() -> void:
	is_door_mouse_over = false
	door = "Foyer"
	Input.set_custom_mouse_cursor(Globals.arrow)


#Right Door
func _on_door_r_mouse_entered() -> void:
	is_door_mouse_over = true
	door = "Kitchen"
	Input.set_custom_mouse_cursor(Globals.door)

func _on_door_r_mouse_exited() -> void:
	is_door_mouse_over = false
	door = "Foyer"
	Input.set_custom_mouse_cursor(Globals.arrow)


#Front Door
func _on_door_f_mouse_entered() -> void:
	is_door_mouse_over = true
	door = "Garden"
	Input.set_custom_mouse_cursor(Globals.door)

func _on_door_f_mouse_exited() -> void:
	is_door_mouse_over = false
	door = "Foyer"
	Input.set_custom_mouse_cursor(Globals.arrow)
