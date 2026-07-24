extends Node3D

@export_group("Initialization")
##Dictates the room the player starts in on scene start. 
##0: [ROOM1], 1: [ROOM2], 2: [ROOM3], 3: [ROOM4]
@export_range(0,3) var current_room : int = 0
##Dictates the remaining time blocks on scene start. Default is 16.
@export var current_time : int = 16

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
	Globals.states.connect(change_camera_state)
	
	#init start scenario
	Input.set_custom_mouse_cursor(Globals.arrow)
	mouse_pos = get_viewport().get_visible_rect().size / 2
	down_count()
	
	Globals.set_active_state(Globals.gamestate.MOVE)
	
	print(CharacterGlobals.characters["Clay"].has_met)

func _process(_delta: float) -> void:
	#match active_state:
		#gamestate.MENU:
			#pass
		#gamestate.MOVE:
			#pass
		#gamestate.SPEAK:
			#pass
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
	camera.start_basis = target.camera_basis
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

func down_count() -> bool:
	#init character traits
	#note: need list of traits for this
	#place items in rooms
	#pick random character to mark as murdered
	#pick random character to mark as culprit
	#place body in murder room
	#randomly place all other characters
	#make those characters children of their assigned rooms
	#set starting room for player (active_room)
	#once everything is loaded in, return true
	return true
	

	
func change_camera_state(state):
	match state:
		"Move":
			camera.process_mode = Node.PROCESS_MODE_ALWAYS
			Input.warp_mouse(mouse_pos)
		"Speak":
			camera.process_mode = Node.PROCESS_MODE_DISABLED
			mouse_pos = get_viewport().get_mouse_position()
		"Menu":
			pass
	
	
	
	

	
	
	
	
	
	
	
	
	
	
