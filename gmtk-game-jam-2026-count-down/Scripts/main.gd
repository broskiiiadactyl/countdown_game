extends Node3D

@export_group("Initialization")
##Dictates the room the player starts in on scene start. 
##0: [ROOM1], 1: [ROOM2], 2: [ROOM3], 3: [ROOM4]
@export_range(0,3) var current_room : int = 0
##Dictates the remaining time blocks on scene start. Default is 16.
@export var current_time : int = 16

enum gamestate {MENU, MOVE, SPEAK}
var active_state : gamestate = gamestate.MOVE
var can_move : bool = false
var is_talking : bool = false

#init room vars
@onready var foyer : Node3D = %Foyer
@onready var kitchen : Node3D = %Kitchen
@onready var library : Node3D = %Library
@onready var garden : Node3D = %Garden

#Camera vars
@onready var camera : Camera3D = %PlayerCamera
@onready var target_position : Vector3 = camera.global_position
@onready var fade : ColorRect = %Fade
var trans_speed : float = 25.0
var trans_time : float = 0.25
@onready var active_room : Node3D = foyer
var target_room : Node3D
var mouse_pos : Vector2 = Vector2.ZERO

func _ready() -> void:
	Globals.trans.connect(transition_to_room)
	
	#init start scenario
	Input.set_custom_mouse_cursor(Globals.arrow)
	mouse_pos = get_viewport().get_visible_rect().size / 2
	murder_someone()
	
	set_active_state(gamestate.MOVE)

func _process(_delta: float) -> void:
	match active_state:
		gamestate.MENU:
			pass
		gamestate.MOVE:
			pass
		gamestate.SPEAK:
			pass

func _unhandled_input(event: InputEvent) -> void:
	pass


func transition_to_room(room : String) -> void:
	var target : Node3D
	
	print("room: ", room)
	
	match room:
		"Foyer":
			target = foyer
		"Kitchen":
			target = kitchen
		"Library":
			target = library
		"Garden":
			target = garden
		_:
			target = foyer
	
	target_room = target
	camera.max_yaw = target.max_yaw
	print("Active: ", active_room, "\n", "Target: ", target)
	
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


func set_active_state(state : gamestate) -> void:
	match state:
		gamestate.MENU:
			can_move = false
			is_talking = false
		gamestate.MOVE:
			can_move = true
			is_talking = false
			camera.process_mode = Node.PROCESS_MODE_ALWAYS
			Input.warp_mouse(mouse_pos)
		gamestate.SPEAK:
			can_move = false
			is_talking = true
			camera.process_mode = Node.PROCESS_MODE_DISABLED
			mouse_pos = get_viewport().get_mouse_position()

func murder_someone() -> bool:
	#init character traits
	#place items in rooms
	#pick random character to mark as murdered
	#pick random character to mark as culprit
	#place body in murder room
	#randomly place all other characters
	#set starting room for player (active_room)
	#set camera yaw based on active room
	#once everything is loaded in, return true
	return true
	
	
	
	
	
	
	
	
	
	
	
	
	
