extends Node3D

@export_group("Initialization")
##Dictates the room the player starts in on scene start. 
##0: [ROOM1], 1: [ROOM2], 2: [ROOM3], 3: [ROOM4]
@export_range(0,3) var current_room : int = 0
##Dictates the remaining time blocks on scene start. Default is 16.
@export var current_time : int = 16

var arrow = load("res://Assets/Test/gauntlet_default.png")
var talk = load("res://Assets/Test/message_dots_round.png")
var point = load("res://Assets/Test/look_c.png")
var door = load("res://Assets/Test/door_enter.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(arrow)
	Input.set_custom_mouse_cursor(talk, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(point, Input.CURSOR_HELP)
	Input.set_custom_mouse_cursor(door, Input.CURSOR_IBEAM)
	pass

func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		#some kind of transition effect?
		%Player.global_position = %Room2.get_node("%CameraPos").global_position
	if event.is_action_pressed("ui_left"):
		#some kind of transition effect?
		%Player.global_position = %Room1.get_node("%CameraPos").global_position


func count_down(blocks : int) -> void:
	#logic to count down time blocks
	#current_time - blocks
	pass


func move_right() -> void:
	%Player.global_position = %Room2.get_node("%CameraPos").global_position
