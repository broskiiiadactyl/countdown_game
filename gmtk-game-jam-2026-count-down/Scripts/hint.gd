extends Node3D

var hour = Globals.current_time

@onready var hint_screen : Control = $HintScreen
@onready var bg : Control = %BG
@onready var text : Control = $HintScreen/Text
@onready var hour_lab : RichTextLabel = %Hour
@onready var hint_lab : RichTextLabel = %Hint

var hour_text : String = "The clock strikes a new hour."
var hour_remain : String = ""

var hint1 : String = ""
var hint2 : String = ""
var hint3 : String = ""

func _ready() -> void:
	Globals.hint.connect(play_hint)

func play_hint(num : int) -> void:
	match num:
		1:
			print("hint1")
			hour_lab.text = hour_text + "\n3 remain."
			pass
		2:
			hour_lab.text = hour_text + "\n2 remain."
			pass
		3:
			hour_lab.text = hour_text + "\n1 remains."
			pass
		_:
			pass
	
	hint_screen.visible = true
	var tween = create_tween()
	tween.tween_property(bg, "modulate", Color(0,0,0,1.0), 0.25)
	tween.parallel().tween_property(text, "modulate", Color(1,1,1,1.0), 0.25)
	await tween.finished
	
	await get_tree().create_timer(2.0).timeout
	
	hint_screen.visible = true
	
	var tween2 = create_tween()
	tween2.tween_property(bg, "modulate", Color(0,0,0,1.0), 0.25)
	tween2.parallel().tween_property(text, "modulate", Color(1,1,1,0.0), 0.25)
	Globals.game_ready.emit()
	await tween2.finished
	hint_screen.visible = false
