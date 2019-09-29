extends KinematicBody2D

export(float) var unitSpeed = 60.0
export(float) var gatherDistance = 15.0

onready var ui = get_node("../../Camera2D/ui")
onready var unitSelection = get_node("selection-circle")
onready var orderLabel = get_node("Label")
var unitSelected = false

var moveTarget = Vector2.ZERO
var moveDistance = 0
var isMoving = false

var harvestTimer = 0

var currentOrder = null
var carriedResource = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_order(order):
	currentOrder = order
	match(order.orderType):
		GlobalEnums.OrderType.MOVE:
			moveTarget = order.toPosition
			moveDistance = self.global_position.distance_to(moveTarget)
			isMoving = true
			orderLabel.text = 'Moving...'
		GlobalEnums.OrderType.ATTACK:
			orderLabel.text = 'Attacking...'
			pass
		GlobalEnums.OrderType.GATHER:
			orderLabel.text = 'Gathering...'
			moveTarget = order.toPosition
			moveDistance = self.global_position.distance_to(moveTarget) - gatherDistance
			isMoving = true

func _physics_process(delta):
	harvestTimer -= delta
	if(currentOrder != null):
		match(currentOrder.orderType):
			GlobalEnums.OrderType.MOVE:
				if(isMoving && moveDistance >= 0):
					moveDistance -= (self.global_position.direction_to(moveTarget) * unitSpeed * delta).length()
					self.move_and_slide(self.global_position.direction_to(moveTarget) * unitSpeed)
				else:
					isMoving = false
			GlobalEnums.OrderType.GATHER:
				if(isMoving && moveDistance >= 0):
					moveDistance -= (self.global_position.direction_to(moveTarget) * unitSpeed * delta).length()
					self.move_and_slide(self.global_position.direction_to(moveTarget) * unitSpeed)
				else:
					isMoving = false
					if(harvestTimer <= 0):
						harvest()

func harvest():
	harvestTimer = 1.25
	ui.add_resource(currentOrder.targetObject.resourceType, currentOrder.targetObject.harvest())
	if(currentOrder.targetObject.amount == 0):
		currentOrder = null