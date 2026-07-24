extends Node

var liar : String = ""
var murderer : String = ""

var victim : Dictionary = {
	"name": "The Count",
	"has_met": false,
	"time_of_death": "",
	"murder_weapon": "",
	"in_room": ""
}

var characters : Dictionary = {
	"Clay": {
		"has_met": false,
		"is_lying": false,
		"activity": "",
		"morning": "",
		"noon": "",
		"night": "",
		"item": "",
		"in_room": ""
	},
	
	"Cookie": {
		"has_met": false,
		"is_lying": false,
		"activity": "",
		"morning": "",
		"noon": "",
		"night": "",
		"item": "",
		"in_room": ""
	},
	
	"Mike": {
		"has_met": false,
		"is_lying": false,
		"activity": "",
		"morning": "",
		"noon": "",
		"night": "",
		"item": "",
		"in_room": ""
	},
	
	"Jerry": {
		"has_met": false,
		"is_lying": false,
		"activity": "",
		"morning": "",
		"noon": "",
		"night": "",
		"item": "",
		"in_room": ""
	}
}

var activities : Dictionary = {
	"Fishing": {
		1: "Hefty Knife",
		2: "Ripped Nets",
		3: "Gallon Bag"
	},
	"Cooking": {
		1: "Hefty Knife",
		2: "Rubber Gloves",
		3: "Nightshade"
	},
	"Gardening": {
		1: "Large Scissors",
		2: "Gallon Bag",
		3: "Nightshade"
	},
	"Dressing up": {
		1: "Ripped Nets",
		2: "Rubber Gloves",
		3: "Large Scissors"
	}
}

var places : Dictionary = {
	"Foyer": "",
	"Garden": "",
	"Kitchen": "",
	"Library": ""
}
