extends Node3D

@onready var collision := %IconColl
@onready var icon : MeshInstance3D = %Icon
@onready var journal_menu : Control = %JMenu
var is_journal_mouse_over : bool = false
var is_over_cross : bool = false
var items_added : int = 0

@onready var item1 = %"1"
@onready var item2 = %"2"
@onready var item3 = %"3"
@onready var item4 = %"4"

func _ready() -> void:
	Globals.states.connect(set_state)
	Globals.update_blocks.connect(populate_journal)
	Globals.items.connect(add_item)
	

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
	print("JOURNAL")
	var journal_blocks : Array = Globals.blocks
	
	#skip title and buffer
	var x = 2
	for child in %LPage.get_children():
		if x <= 0:
			child.queue_free()
		x -= 1
	
	for block in journal_blocks:
		var new_label = Label.new()
		new_label.text = block
		new_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		%LPage.add_child(new_label)

func add_item(item) -> void:
	print("add ", item)
	var trimmed_name : String = item.to_lower()
	var trim_spot : int = item.rfind(" ")
	trimmed_name = trimmed_name.substr(trim_spot + 1)
	print(trimmed_name)
	
	
	match items_added:
		0:
			item1.get_node("%" + trimmed_name).visible = true
			item1.visible =  true
			%Label1.text = item
			%Label1.visible =  true
		1:
			item2.get_node("%" + trimmed_name).visible = true
			item2.visible =  true
			%Label2.text = item
			%Label2.visible =  true
		2:
			item3.get_node("%" + trimmed_name).visible = true
			item3.visible =  true
			%Label3.text = item
			%Label3.visible =  true
		3:
			item4.get_node("%" + trimmed_name).visible = true
			item4.visible =  true
			%Label4.text = item
			%Label4.visible =  true
		_:
			pass
	
	items_added += 1
	


#SIGNALS
func _on_jornal_area_mouse_entered() -> void:
	is_journal_mouse_over = true
	Input.set_custom_mouse_cursor(Globals.look)

func _on_jornal_area_mouse_exited() -> void:
	is_journal_mouse_over = false
	Input.set_custom_mouse_cursor(Globals.arrow)

func _on_exit_area_mouse_entered() -> void:
	is_over_cross = true

func _on_exit_area_mouse_exited() -> void:
	is_over_cross = false
