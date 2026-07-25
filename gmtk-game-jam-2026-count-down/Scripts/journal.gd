extends Node3D

@onready var collision := $"."
@onready var icon : MeshInstance3D = %Icon
var is_journal_mouse_over := false

func _ready() -> void:
	Globals.states.connect(set_state)

func _unhandled_input(event: InputEvent) -> void:	
	if event.is_action_pressed("LMB") and is_journal_mouse_over:
		open_journal()
	pass

func _on_jornal_area_mouse_entered() -> void:
	is_journal_mouse_over = true
	Input.set_custom_mouse_cursor(Globals.look)

func _on_jornal_area_mouse_exited() -> void:
	is_journal_mouse_over = false
	Input.set_custom_mouse_cursor(Globals.arrow)

func open_journal():
	Globals.set_active_state(Globals.gamestate.MENU)
	pass

func set_state(state):
	match state:
		"Move":
			icon.visible = true
		"Speak":
			icon.visible = false
		"Menu":
			icon.visible = false
