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
var trans_offset : Vector3 = Vector3.ZERO
var trans_time : float = 1.0
@onready var active_room : Node3D = foyer
var target_room : Node3D

#Cursor assignment
var arrow = load("res://Assets/Test/gauntlet_default.png")
var talk = load("res://Assets/Test/message_dots_round.png")
var point = load("res://Assets/Test/look_c.png")
var door = load("res://Assets/Test/door_enter.png")

func _ready() -> void:
	#init start scenario
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
	#move camera in the direction of the room
	#fade in black overlay over time
	target.visible = true
	target.process_mode = Node.PROCESS_MODE_INHERIT
	camera.global_position = target.camera_pos
	active_room.visible = false
	active_room.process_mode = Node.PROCESS_MODE_INHERIT
	#move camer from starting position to resting position
	#fade out black overlay over time
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
	
	
	
	
	
	
	
	
	
	
	
	
	
