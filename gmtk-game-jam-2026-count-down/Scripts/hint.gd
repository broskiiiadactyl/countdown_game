extends Node3D

var hour = Globals.current_time

@onready var hint_screen : Control = $HintScreen
@onready var bg : Control = %BG
@onready var text : Control = $HintScreen/Text
@onready var hour_lab : RichTextLabel = %Hour
@onready var hint_lab : RichTextLabel = %Hint

var hour_text : String = "The clock strikes a new hour."
var hour_remain : String = ""

var hint1 : String = "You Hear the Spirits say:\nEach (-) dialogue option only counts down time once."
var hint2 : String = ""
var hint3 : String = ""

func _ready() -> void:
	Globals.hint.connect(play_hint)

func play_hint(num : int) -> void:
	var ToD = CharacterGlobals.victim.time_of_death
	var weapon = CharacterGlobals.victim.murder_weapon
	
	hint2 = "You Hear the Spirits say:\nThe Count was killed at " + ToD + "."
	hint3 = "You Hear the Spirits say:\nThe murder weapon was the " + weapon + "."
	
	%Chime.play()
	
	Globals.shake.emit()
	await Globals.shake_done
	print("finished")
	
	match num:
		1:
			hour_lab.text = hour_text + "\n3 remain."
			hint_lab.text = hint1
		2:
			hour_lab.text = hour_text + "\n2 remain."
			hint_lab.text = hint2
		3:
			hour_lab.text = hour_text + "\n1 remains."
			hint_lab.text = hint3
		_:
			pass
	
	hint_screen.visible = true
	hour_lab.visible = true
	var tween = create_tween()
	tween.tween_property(bg, "modulate", Color(0,0,0,1.0), 0.5)
	await tween.finished
	
	var tween5 = create_tween()
	tween5.tween_property(hour_lab, "modulate", Color(1,1,1,1.0), 0.25)
	
	await get_tree().create_timer(2.0).timeout
	
	var tween3 = create_tween()
	tween3.tween_property(hour_lab, "modulate", Color(0,0,0,0.0), 0.25)
	await tween3.finished
	hour_lab.visible = false
	
	Globals.timer_down.emit()
	
	hint_lab.visible = true
	%Cat.visible = true
	var tween4 = create_tween()
	tween4.tween_property(hint_lab, "modulate", Color(1,1,1,1.0), 0.25)
	tween4.parallel().tween_property(%Cat, "modulate", Color(1,1,1,1.0), 0.25)
	await tween4.finished
	
	await get_tree().create_timer(3.0).timeout
	
	var tween2 = create_tween()
	tween2.tween_property(hint_lab, "modulate", Color(0,0,0,0.0), 0.25)
	tween2.parallel().tween_property(%Cat, "modulate", Color(0,0,0,0.0), 0.25)
	await tween2.finished
	
	var tween6 = create_tween()
	tween6.parallel().tween_property(bg, "modulate", Color(0,0,0,0.0), 0.5)
	Globals.game_ready.emit()
	await tween6.finished
	hint_screen.visible = false
	hint_lab.visible = false
	%Cat.visible = false
