extends Node

#Cursor assignment
var arrow = load("res://Assets/Test/gauntlet_default.png")
var talk = load("res://Assets/Test/message_dots_round.png")
var look = load("res://Assets/Test/look_c.png")
var door = load("res://Assets/Test/door_enter.png")

signal trans(target: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func transition_to_room(target: String) -> void:
	trans.emit(target)
