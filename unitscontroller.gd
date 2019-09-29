extends Node2D

class Order:
	var toPosition
	var targetObject
	var orderType
	
	func _init(toPosition, targetObject, orderType):
		self.toPosition = toPosition
		self.targetObject = targetObject
		self.orderType = orderType

onready var doodadController = get_node("../levelTiles")
onready var selectionGeometry = get_node("../selection-geometry")
onready var selectionGeometryShape = get_node("../selection-geometry/CollisionShape2D")

var selectedUnits = []
var moveOrders = []

var selectionStart = Vector2.ZERO
var selectionEnd = Vector2.ZERO

func _ready():
	set_process_input(true)

func _input(event):
	if(event is InputEventMouseMotion && selectionStart != Vector2.ZERO):
		set_mouse_selection_bounds()
	
	if(event is InputEventMouseButton):
		var mbEvent = event as InputEventMouseButton
		if(mbEvent.button_index == BUTTON_LEFT && mbEvent.pressed):
			selectionStart = get_global_mouse_position()
		elif(mbEvent.button_index == BUTTON_LEFT && !mbEvent.pressed && Input.is_key_pressed(KEY_SHIFT)):
			add_selection(selectionGeometry.get_overlapping_bodies())
			selectionStart = Vector2.ZERO
		elif(mbEvent.button_index == BUTTON_LEFT && !mbEvent.pressed):
			set_selection(selectionGeometry.get_overlapping_bodies())
			selectionStart = Vector2.ZERO
		elif(mbEvent.button_index == BUTTON_RIGHT && mbEvent.pressed && Input.is_key_pressed(KEY_SHIFT)):
			if(doodadController.currentTargetDoodad != null):
				add_order(Order.new(get_global_mouse_position(), doodadController.currentTargetDoodad, GlobalEnums.OrderType.GATHER))
			else:
				add_order(Order.new(get_global_mouse_position(), null, GlobalEnums.OrderType.MOVE))
			pass
		elif(mbEvent.button_index == BUTTON_RIGHT && mbEvent.pressed):
			if(doodadController.currentTargetDoodad != null && doodadController.currentTargetDoodad.has_method("harvest")):
				set_order(Order.new(get_global_mouse_position(), doodadController.currentTargetDoodad, GlobalEnums.OrderType.GATHER))
			elif(doodadController.currentTargetDoodad != null && doodadController.currentTargetDoodad.has_method("add_resources")):
				set_order(Order.new(get_global_mouse_position(), doodadController.currentTargetDoodad, GlobalEnums.OrderType.DEPOSIT))
			else:
				set_order(Order.new(get_global_mouse_position(), null, GlobalEnums.OrderType.MOVE))
			pass

func set_mouse_selection_bounds():
	selectionEnd = get_global_mouse_position()
	var bounds = selectionStart - selectionEnd
	var center = selectionStart - bounds / 2
	selectionGeometry.global_position = center
	selectionGeometryShape.shape.extents = Vector2(abs(bounds.x), abs(bounds.y)) / 2

func set_order(order):
	moveOrders = [order]
	updated_ordered_units()

func add_order(order):
	moveOrders.append(order)
	updated_ordered_units()

func updated_ordered_units():
	print(selectedUnits)
	for unit in selectedUnits:
		unit.set_order(moveOrders[0])

func order_finished():
	moveOrders.remove(0)
	if(moveOrders.size() > 0):
		return moveOrders[0]
	else:
		return false

func set_selection(selection):
	selectedUnits = selection
	updated_selected_units()

func add_selection(selection):
	selectedUnits += selection
	updated_selected_units()

func updated_selected_units():
	for unit in self.get_children():
		if(unit in selectedUnits):
			unit.get_node("selection-circle").visible = true
		else:
			unit.get_node("selection-circle").visible = false