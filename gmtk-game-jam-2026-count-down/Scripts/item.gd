extends StaticBody3D

var is_mouse_over : bool = false

var item_name : String = "Hefty Knife"

#var resource := "res://Dialogue/items.dialogue"

@onready var bag = %bag
@onready var gloves = %gloves
@onready var knife = %knife
@onready var net = %nets
@onready var nightshade = %nightshade
@onready var scissors = %scissors

func _ready() -> void:
	#DialogueManager.dialogue_ended.connect(test)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and is_mouse_over and Globals.can_move:
		#Globals.set_active_state(Globals.gamestate.SPEAK)
		take_item()
		#DialogueManager.show_example_dialogue_balloon(load(resource), "start")


func _on_mouse_entered() -> void:
	is_mouse_over = true
	Input.set_custom_mouse_cursor(Globals.grab)


func _on_mouse_exited() -> void:
	is_mouse_over = false
	Input.set_custom_mouse_cursor(Globals.arrow)

#func test(x : Resource) -> void:
	#if x.resource_path == resource:
		#self.visible = true
		#Globals.set_active_state(Globals.gamestate.MOVE)

func set_item(naem: String):
	item_name = naem
	
	match naem:
		"Hefty Knife":
			knife.visible = true
		"Ripped Nets":
			net.visible = true
		"Gallon Bag":
			bag.visible = true
		"Rubber Gloves":
			gloves.visible = true
		"Nightshade":
			nightshade.visible = true
		"Large Scissors":
			scissors.visible = true
		_:
			push_error("OOPS")
			

func take_item() -> void:
	self.visible = false
	Globals.inventory.append(item_name)
	Globals.items.emit(item_name)
	if Globals.item1 == "":
		Globals.item1 = item_name
	elif Globals.item2 == "":
		Globals.item2 = item_name
	elif Globals.item3 == "":
		Globals.item3 = item_name
	elif Globals.item4 == "":
		Globals.item4 = item_name

func turn_off_lights() -> void:
	%Light3.visible = false
	%Light1.visible = false
	%Light2.visible = false
