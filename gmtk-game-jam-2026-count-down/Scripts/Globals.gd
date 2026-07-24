extends Node

#Cursor assignment
var arrow = load("res://Assets/Test/gauntlet_default.png")
var talk = load("res://Assets/Test/message_dots_round.png")
var look = load("res://Assets/Test/look_c.png")
var door = load("res://Assets/Test/door_enter.png")

#game state management
enum gamestate {MENU, MOVE, SPEAK}
var active_state : gamestate = gamestate.MOVE
#I think these vars can probably be removed
var can_move : bool = false
var is_talking : bool = false

#time management
const MAX_TIME : int = 16
var current_time : int = MAX_TIME

#signals
signal trans(target: String)
signal states(state)


func _ready() -> void:
	pass 


func transition_to_room(target: String) -> void:
	trans.emit(target)

func count_down(blocks : int) -> void:
	#logic to count down time blocks
	current_time -= blocks
	pass

func set_active_state(state : gamestate) -> void:
	match state:
		gamestate.MENU:
			can_move = false
			is_talking = false
			states.emit("Menu")
		gamestate.MOVE:
			print("Gamestate set to Move!")
			can_move = true
			is_talking = false
			states.emit("Move")
		gamestate.SPEAK:
			can_move = false
			is_talking = true
			states.emit("Speak")
