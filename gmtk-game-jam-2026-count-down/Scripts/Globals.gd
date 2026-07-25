extends Node

#Cursor assignment
var arrow = load("res://Assets/Test/gauntlet_default.png")
var talk = load("res://Assets/Test/message_dots_round.png")
var look = load("res://Assets/Test/look_c.png")
var door = load("res://Assets/Test/door_enter.png")
var grab = load("res://Assets/Test/gauntlet_open.png")

#game state management
enum gamestate {MENU, MOVE, SPEAK}
var active_state : gamestate = gamestate.MOVE
#I think these vars can probably be removed
var can_move : bool = false
var is_talking : bool = false

#time management
const MAX_TIME : int = 16
var current_time : int = MAX_TIME
var time_IDs : Array = []

#signals
signal trans(target: String)
signal states(state)
signal characters(character)
signal hint(hour)

#Info blocks
var blocks : Array = []
signal update_blocks()

#shit jeff added
var inventory = [] #player's inventory relative to what they collected
var item1 = ""
var item2 = ""
var item3 = ""
var item4 = ""
signal items(item)

func dm_print( p ): #print function so I can print from the dialogue manager
	print(p)

func _ready() -> void:
	pass 

func transition_to_room(target: String) -> void:
	trans.emit(target)

func count_down(num : int, ID : String) -> void:
	if time_IDs.has(ID):
		return
	else:
		time_IDs.append(ID)
		current_time -= num
		print(current_time, "/", MAX_TIME)
	
	if current_time <= 0:
		force_end()
	elif current_time <= 4: 
		play_hint(3)
	elif current_time <= 8:
		play_hint(2)
	elif current_time <= 12:
		play_hint(1)

func play_hint(num : int) -> void:
	set_active_state(gamestate.MENU)
	hint.emit(num)
	pass

func force_end() -> void:
	pass

func set_active_state(state : gamestate) -> void:
	match state:
		gamestate.MENU:
			can_move = false
			is_talking = false
			states.emit("Menu")
		gamestate.MOVE:
			can_move = true
			is_talking = false
			states.emit("Move")
		gamestate.SPEAK:
			can_move = false
			is_talking = true
			states.emit("Speak")

func toggle_characters(character: String):
	match character:
		"Cookie":
			characters.emit(character)
		"Mike":
			characters.emit(character)
		"Jerry":
			characters.emit(character)
		"Clay":
			characters.emit(character)
		"The Count":
			characters.emit(character)
		_:
			pass
