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
	var tween = create_tween()
	tween.tween_property(pause_menu, "modulate", Color(0,0,0,0), 0.25)
	await tween.finished
	print("tweened")
	pause_menu.visible = false
	Globals.set_active_state(Globals.gamestate.MOVE)
	self.process_mode = Node.PROCESS_MODE_DISABLED
