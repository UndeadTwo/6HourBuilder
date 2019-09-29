extends KinematicBody2D

onready var jank = get_node("../Camera2D/ui")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_resources(type, amount):
	jank.add_resource(type, amount)
	pass