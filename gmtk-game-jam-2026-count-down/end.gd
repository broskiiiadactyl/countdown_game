extends Node3D

func _ready() -> void:
	%EndControl.visible = false
	Globals.it_begins.connect(it_begins)
	pass

func it_begins(answer) -> void:
	%EndControl.visible = true
	
	#zander please do not judge this grotesque use of find child
	#i can never get fucking get child to work and navigating these via indexed get_child is too BUF BRAIN for me atm
	
	#container variables
	var accusedText = self.find_child("AccusedBox").get_child(1)
	var murdererText = self.find_child("MurderBox").get_child(1)
	var gradeText = self.find_child("GradeBox").get_child(1)
	var snarkText =self.find_child("SnarkBox").get_child(0)
	var resultText =self.find_child("Result")
	
	#string variable defaults
	var murderer = CharacterGlobals.murderer
	var result = "[rainbow]You Win![/rainbow]"
	var grade = "[rainbow]S[/rainbow]"
	var snark = "[wave]Wowzers! You'd have to be a genius AND get lucky to get this grade! Very nice! Now they'll HAVE to text you back![/wave]"
	
	#calculate all the results
	if Globals.hint1_played == true:
		grade = "[color=green]A[/color]"
		snark = "[wave]Whoa! You're a real life Columbo! I wonder if there's an ever higher grade...[/wave]"
	
	if Globals.hint2_played == true:
		grade = "[color=green]B[/color]"
		snark = "[wave]Solid detective work, but we both know you can do it better.[/wave]"
		
	if Globals.hint3_played == true:
		%Win.play()
		grade = "[color=green]C[/color]"
		snark = "[wave]C's get degrees! Maybe next time put it together a little faster. Be careful though, it won't be the same person![/wave]"
		
	if answer != murderer:
		%Lose.play()
		result = "You Lose!"
		grade = "[color=crimson]F[/color]"
		snark = "[wave]Oof! Let the murderers get one over on ya, huh? Happens to the best of us. Not me, though. I'd just win![/wave]"
	
	if Globals.current_time == Globals.MAX_TIME:
		result = "You Guessed![br][rainbow][font_size=24]Honk Honk![/font_size][/rainbow]"
		grade = "[color=crimson]Huge L![/color]"
		snark = "[wave]We agree that gambling is fun! Please play our game![/wave]"
	
	
	#change all the text in the containers
	accusedText.text = answer
	if Globals.current_time != Globals.MAX_TIME:
		murdererText.text = CharacterGlobals.murderer
		match murderer:
			"Cookie":
				%port.texture = load("res://Assets/Characters/images/cookie.png")
			"Mike":
				%port.texture = load("res://Assets/Characters/images/mike.png")
			"Jerry":
				%port.texture = load("res://Assets/Characters/images/jerry.png")
			"Clay":
				%port.texture = load("res://Assets/Characters/images/clay.png")
			_:
				pass
	else:
		murdererText.text = "? ? ?"
	gradeText.text = grade
	snarkText.text = snark
	resultText.text = result
	
	pass
