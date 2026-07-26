extends Node3D

@onready var pause_menu : Control = %JMenu
var is_pause_mouse_over : bool = false
var is_over_cross : bool = false
var items_added : int = 0
var paused : bool = false

func _ready() -> void:
	Globals.states.connect(set_state)
	
	pause_menu.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		if is_pause_mouse_over:
			paused = true
			open_pause()
		elif is_over_cross:
			paused = false
			close_pause()
	elif event.is_action_pressed("ui_cancel"):
		paused = !paused
		if paused:
			open_pause()
		elif not paused:
			close_pause()

func open_pause() -> void:
	Globals.set_active_state(Globals.gamestate.MENU)
	pause_menu.visible = true

func close_pause() -> void:
	Globals.set_active_state(Globals.gamestate.MOVE)
	pause_menu.visible = false

#func set_state(state) -> void:
	#match state:
		#"Move":
			#icon.visible = true
		#"Speak":
			#icon.visible = false
		#"Menu":
			#icon.visible = false

#SIGNALS
func _on_exit_area_mouse_entered() -> void:
	is_over_cross = true

func _on_exit_area_mouse_exited() -> void:
	is_over_cross = false

func _on_pause_area_mouse_entered() -> void:
	is_pause_mouse_over = true

func _on_pause_area_mouse_exited() -> void:
	is_pause_mouse_over = false
