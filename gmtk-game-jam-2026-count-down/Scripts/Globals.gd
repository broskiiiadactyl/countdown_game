extends Node

#Cursor assignment
var arrow = load("res://Assets/Test/gauntlet_default.png")
var talk = load("res://Assets/Test/message_dots_round.png")
var look = load("res://Assets/Test/look_c.png")
var door = load("res://Assets/Test/door_enter.png")
var grab = load("res://Assets/Test/gauntlet_open.png")

#game state management
enum gamestate {MENU, MOVE, SPEAK, STOP}
var active_state : gamestate = gamestate.MOVE
#I think these vars can probably be removed
var can_move : bool = false
var last_state : gamestate

#time management
const MAX_TIME : int = 16
var current_time : int = MAX_TIME
var time_IDs : Array = []
var hint1_played = false
var hint2_played = false
var hint3_played = false

#signals
signal trans(target: String)
signal states(state)
signal states_finished()
signal characters(character)
signal hint(hour)
signal timer_down()
signal start()
signal game_ready()
signal it_begins()
signal shake()
signal shake_done()
signal end(room)
signal end_done()

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
		timer_down.emit()
		print(current_time, "/", MAX_TIME)
	
	if current_time <= 0:
		force_end()
	elif current_time <= 4 and not hint3_played: 
		play_hint(3)
		hint3_played = true
	elif current_time <= 8 and not hint2_played:
		play_hint(2)
		hint2_played = true
	elif current_time <= 12 and not hint1_played:
		play_hint(1)
		hint1_played = true

func play_hint(num : int) -> void:
	await states_finished
	can_move = false
	print("Hint ", num)
	set_active_state(gamestate.STOP)
	hint.emit(num)
	await game_ready
	set_active_state(gamestate.MOVE)
	print("done")
	pass

func force_end() -> void:
	await states_finished
	can_move = false
	end.emit(CharacterGlobals.victim.in_room)
	

func set_active_state(state : gamestate) -> void:
	last_state = active_state
	match state:
		gamestate.MENU:
			can_move = false
			states.emit("Menu")
		gamestate.MOVE:
			can_move = true
			states.emit("Move")
		gamestate.SPEAK:
			can_move = false
			states.emit("Speak")
		gamestate.STOP:
			can_move = false
			states.emit("STOP")

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

func game_end(answer) -> void:
	it_begins.emit(answer)
	pass
