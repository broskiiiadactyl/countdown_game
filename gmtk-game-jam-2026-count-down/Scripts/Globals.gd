extends Node

#Cursor assignment
var arrow = load("res://Assets/Test/gauntlet_default.png")
var talk = load("res://Assets/Test/message_dots_round.png")
var look = load("res://Assets/Test/look_c.png")
var door = load("res://Assets/Test/door_enter.png")

signal trans(target: String)


func _ready() -> void:
	pass 


func transition_to_room(target: String) -> void:
	trans.emit(target)

func count_down(blocks : int) -> void:
	#logic to count down time blocks
	#current_time - blocks
	pass
