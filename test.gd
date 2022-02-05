extends Sprite

onready var FSM = $UFSM
onready var lab = get_tree().get_root().get_node("Node2D/Label")

var default_state = State.new(self, {
	"phy_update": "def_phy_update",
#	"enter": "some_func",
#	"exit": "some_func",
#	"update": "some_func",
})

var up_state = State.new(self, {
	"phy_update": "up_phy_update"
})

var soft_state = State.new(self, {
	"enter": "soft_enter"
})

var insert_state = State.new(self, {
	"enter": "insert_enter"
})

func _process(_delta):
	lab.text = ""
	for i in FSM.STATE_STACK:
		lab.text = lab.text + "STATE \n"

########################################## UFSM #######################################

func def_phy_update(delta):
	if position.x < 600:
		position.x += 100 * delta
	else:
		FSM.pop()
	
func up_phy_update(delta):
	if position.y > 100:
		position.y -= 100 * delta
	else:
		FSM.pop()

func soft_enter():
	print_debug("Hello!")
	FSM.pop()

func insert_enter():
	print_debug("I insert state!")
	FSM.pop()

######################################## END UFSM #####################################

func _on_right_pressed():
	FSM.push(default_state)

func _on_up_pressed():
	FSM.push(up_state)

func _on_Soft_Mode_Button_pressed():
	FSM.soft_mode = true
	FSM.switch(soft_state) # log Hello
	FSM.switch(soft_state) # no logs
	FSM.switch(soft_state) # no logs
	FSM.soft_mode = false
	FSM.switch(soft_state) # log Hello
	FSM.switch(soft_state) # log Hello
	FSM.switch(soft_state) # log Hello


func _on_Insert_Button_pressed():
	FSM.insert(insert_state, 2)

func _input(event):
	if event is InputEventKey:
		var _ev = event as InputEventKey
		if _ev.pressed:
			if _ev.as_text() == "R":
				get_tree().reload_current_scene()
