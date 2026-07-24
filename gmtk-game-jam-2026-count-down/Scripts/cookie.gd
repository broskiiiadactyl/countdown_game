extends StaticBody3D

var is_mouse_over : bool = false


var resource := "res://Dialogue/clay.dialogue"


func _ready() -> void:
	DialogueManager.dialogue_ended.connect(test)


func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") and is_mouse_over:
		Globals.set_active_state(Globals.gamestate.SPEAK)
		self.visible = false
		#spawn in dialogue position
		DialogueManager.show_example_dialogue_balloon(load(resource), "start")


func _on_mouse_entered() -> void:
	is_mouse_over = true
	Input.set_custom_mouse_cursor(Globals.talk)


func _on_mouse_exited() -> void:
	is_mouse_over = false
	Input.set_custom_mouse_cursor(Globals.arrow)

func test(x : Resource) -> void:
	if x.resource_path == resource:
		self.visible = true
		Globals.set_active_state(Globals.gamestate.MOVE)
