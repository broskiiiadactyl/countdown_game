extends StaticBody3D

var is_mouse_over : bool = false

var item_name : String = "Hefty Knife"
#var resource := "res://Dialogue/items.dialogue"

func _ready() -> void:
	#DialogueManager.dialogue_ended.connect(test)
	pass

func _unhandled_input(event: InputEvent) -> void:
	pass
	#if event.is_action_pressed("LMB") and is_mouse_over:
		#Globals.set_active_state(Globals.gamestate.SPEAK)
		#self.visible = false
		#TODO: spawn in dialogue position
		#DialogueManager.show_example_dialogue_balloon(load(resource), "start")


func _on_mouse_entered() -> void:
	is_mouse_over = true
	Input.set_custom_mouse_cursor(Globals.talk)


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
			$MeshInstance3D2.visible = true
		"Ripped Nets":
			$MeshInstance3D3.visible = true
		"Gallon Bag":
			$MeshInstance3D4.visible = true
		_:
			$MeshInstance3D.visible = true
			
