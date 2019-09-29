extends Node2D

var gold = 0 setget set_gold
var metal = 0 setget set_metal
var magic = 0 setget set_magic
var wood = 0 setget set_wood
var food = 0 setget set_food
var stone = 0 setget set_stone
onready var goldLabel = get_node("GoldLabel")
onready var metalLabel = get_node("MetalLabel")
onready var magicLabel = get_node("MagicLabel")
onready var woodLabel = get_node("WoodLabel")
onready var foodLabel = get_node("FoodLabel")
onready var stoneLabel = get_node("StoneLabel")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_gold(val):
	gold = val
	goldLabel.text = String(gold)
	pass

func set_metal(val):
	metal = val
	metalLabel.text = String(metal)
	pass

func set_magic(val):
	magic = val
	magicLabel.text = String(magic)
	pass

func set_wood(val):
	wood = val
	woodLabel.text = String(wood)
	pass

func set_food(val):
	food = val
	foodLabel.text = String(food)
	pass

func set_stone(val):
	stone = val
	stoneLabel.text = String(stone)
	pass

func add_resource(type, amount):
	print(GlobalEnums.ResourceType.GOLD)
	print(GlobalEnums.ResourceType.METAL)
	print(GlobalEnums.ResourceType.MAGIC)
	print(GlobalEnums.ResourceType.WOOD)
	print(GlobalEnums.ResourceType.FOOD)
	print(GlobalEnums.ResourceType.STONE)
	print(type, ' ', amount)
	match(type):
		GlobalEnums.ResourceType.GOLD:
			set_gold(gold + amount)
		GlobalEnums.ResourceType.METAL:
			set_metal(metal + amount)
		GlobalEnums.ResourceType.MAGIC:
			set_magic(magic + amount)
		GlobalEnums.ResourceType.WOOD:
			set_wood(wood + amount)
		GlobalEnums.ResourceType.FOOD:
			set_food(food + amount)
		GlobalEnums.ResourceType.STONE:
			set_stone(stone + amount)
		_:
			pass