extends Node3D

@export_group("Initialization")
##Dictates the room the player starts in on scene start. 
##0: [ROOM1], 1: [ROOM2], 2: [ROOM3], 3: [ROOM4]
@export_range(0,3) var current_room : int = 0
##Dictates the remaining time blocks on scene start. Default is 16.
@export var current_time : int = 16

#init room vars
@onready var foyer : Node3D = %Room1
@onready var right : Node3D = %Room3
@onready var left : Node3D = %Room2
@onready var front : Node3D = %Room4

#Camera vars
@onready var camera : Camera3D = %PlayerCamera
@onready var target_position : Vector3 = camera.global_position
@onready var fade : ColorRect = %Fade
var trans_speed : float = 25.0
var trans_time : float = 0.25
@onready var active_room : Node3D = foyer
var target_room : Node3D

func _ready() -> void:
	#init start scenario
	Input.set_custom_mouse_cursor(Globals.arrow)
	murder_someone()

func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		#some kind of transition effect?
		camera.global_position = %Room2.get_node("%CameraPos").global_position
	if event.is_action_pressed("ui_left"):
		#some kind of transition effect?
		camera.global_position = %Room1.get_node("%CameraPos").global_position


func count_down(blocks : int) -> void:
	#logic to count down time blocks
	#current_time - blocks
	pass

func transition_to_room(room : String) -> void:
	var target : Node3D
	
	match room:
		"Foyer":
			target = foyer
		"Right":
			target = right
		"Left":
			target = left
		"Front":
			target = front
		_:
			target = foyer
	
	target_room = target
	#print("Active: ", active_room, "\n", "Target: ", target)
	
	#is already in the target room do nothing
	if target == active_room:
		return
	
	#move camera in the direction of the room
	#fade in black overlay over time
	var tween0 = create_tween()
	tween0.tween_property(camera, "global_position", target.camera_pos, trans_speed)
	
	await get_tree().create_timer(trans_time).timeout
	
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0.0, 0.0, 0.0, 1.0), trans_time)
	await tween.finished
	
	#move camera position to target room
	target.visible = true
	target.process_mode = Node.PROCESS_MODE_INHERIT
	tween0.stop()
	camera.global_position = target.camera_pos
	active_room.visible = false
	active_room.process_mode = Node.PROCESS_MODE_DISABLED
	
	#fade out black overlay
	await get_tree().create_timer(trans_time).timeout
	
	var tween2 = create_tween()
	tween2.tween_property(fade, "color", Color(0.0, 0.0, 0.0, 0.0), trans_time)
	await tween2.finished
	
	#set target room as active room
	active_room = target
	pass


func murder_someone() -> bool:
	#init character traits
	#place items in rooms
	#pick random character to mark as murdered
	#pick random character to mark as culprit
	#place body in murder room
	#randomly place all other characters
	#set starting room for player (active_room)
	#once everything is loaded in, return true
	return true
	
	
	
	
	
	
	
	
	
	
	
	
	
