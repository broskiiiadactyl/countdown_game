extends Node3D

var hour = Globals.current_time

@onready var hour_lab : RichTextLabel = %Hour
@onready var hint_lab : RichTextLabel = %Hint

var hint1 : String = ""
var hint2 : String = ""
var hint3 : String = ""

func _ready() -> void:
	Globals.hint.connect(play_hint)

func play_hint(num : int) -> void:
	match num:
		1:
			
			pass
		2:
			pass
		3:
			pass
		_:
			pass
	pass
