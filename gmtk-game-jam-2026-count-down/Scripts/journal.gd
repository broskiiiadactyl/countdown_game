extends Node3D

@onready var collision := %IconColl
@onready var icon : MeshInstance3D = %Icon
@onready var journal_menu : Control = %JMenu
var is_journal_mouse_over : bool = false
var is_over_cross : bool = false

func _ready() -> void:
	Globals.states.connect(set_state)
	Globals.update_blocks.connect(populate_journal)
	
	Globals.blocks.append("test1")
	Globals.blocks.append("test2")
	Globals.update_blocks.emit()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		if is_journal_mouse_over:
			open_journal()
		elif is_over_cross:
			close_journal()

func open_journal() -> void:
	Globals.set_active_state(Globals.gamestate.MENU)
	journal_menu.visible = true

func close_journal() -> void:
	Globals.set_active_state(Globals.gamestate.MOVE)
	journal_menu.visible = false

func set_state(state) -> void:
	match state:
		"Move":
			icon.visible = true
		"Speak":
			icon.visible = false
		"Menu":
			icon.visible = false

func populate_journal() -> void:
	var journal_blocks : Array = Globals.blocks
	
	for block in journal_blocks:
		var new_label = Label.new()
		new_label.text = block
		%LPage.add_child(new_label)


#SIGNALS
func _on_jornal_area_mouse_entered() -> void:
	is_journal_mouse_over = true
	Input.set_custom_mouse_cursor(Globals.look)

func _on_jornal_area_mouse_exited() -> void:
	is_journal_mouse_over = false
	Input.set_custom_mouse_cursor(Globals.arrow)

func _on_exit_area_mouse_entered() -> void:
	is_over_cross = true
	print(true)

func _on_exit_area_mouse_exited() -> void:
	is_over_cross = false
