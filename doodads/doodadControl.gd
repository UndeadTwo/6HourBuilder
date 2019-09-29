extends KinematicBody2D

export(GlobalEnums.ResourceType) var resourceType
export(float) var amount
var doodad_controller = null

func _ready():
	connect('mouse_entered', self, 'mouse_entered')
	connect('mouse_exited', self, 'mouse_exited')

func harvest():
	if(amount > 0):
		amount -= 1
		return 1
	else:
		if(self.get_parent() != null):
			self.get_parent().remove_child(self)
		return 0

func mouse_entered():
	doodad_controller.currentTargetDoodad = self

func mouse_exited():
	if(doodad_controller.currentTargetDoodad == self):
		doodad_controller.currentTargetDoodad = null