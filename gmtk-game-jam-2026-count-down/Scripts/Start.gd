extends Node3D

@onready var pause_menu : Control = %JMenu
var is_start_mouse_over : bool = false
var is_over_cross : bool = false
var items_added : int = 0
var paused : bool = false

func _ready() -> void:
	%Volume.value = .5
	Globals.set_active_state(Globals.gamestate.MENU)
	Globals.can_move = false
	Globals.game_ready.connect(turn_off)

func _on_button_pressed() -> void:
	Globals.start.emit()
	%Start.process_mode = Node.PROCESS_MODE_DISABLED
	%Start.visible = false
	%Load.visible = true

func turn_off() -> void:
	var tween1 = create_tween()
	tween1.tween_property(%JMenu, "modulate", Color(0,0,0,0.0), 0.5)
	await tween1.finished
	
	var tween2 = create_tween()
	tween2.tween_property(%Hint, "modulate", Color(1,1,1,1.0), 0.5)
	await tween2.finished
	
	await get_tree().create_timer(2.0).timeout
	
	var tween3 = create_tween()
	tween3.tween_property(%Hint, "modulate", Color(1,1,1,0.0), 0.5)
	await tween3.finished
	
	var tween4 = create_tween()
	tween4.tween_property(%Hint2, "modulate", Color(1,1,1,1.0), 0.5)
	await tween4.finished
	
	await get_tree().create_timer(2.0).timeout
	
	var tween5 = create_tween()
	tween5.tween_property(%Hint2, "modulate", Color(1,1,1,0.0), 0.5)
	await tween5.finished
	
	Globals.set_active_state(Globals.gamestate.MOVE)
	var tween = create_tween()
	tween.tween_property(pause_menu, "modulate", Color(0,0,0,0), 0.25)
	tween.parallel().tween_property(%HintScreen, "modulate", Color(0,0,0,0), 0.25)
	await tween.finished
	pause_menu.visible = false
	%HintScreen.visible = false
	self.process_mode = Node.PROCESS_MODE_DISABLED
