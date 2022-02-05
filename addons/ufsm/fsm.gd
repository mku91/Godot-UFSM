extends Node

var State = preload("state.gd")

signal on_any_enter
signal on_any_exit
signal on_change

const STATE_STACK : Array = []

# In soft mode, enter/exit signals will not work, provided that the state has been changed to a similar one
export var soft_mode = false

func _process(delta):
	if not STATE_STACK.empty():
		STATE_STACK[0].update(delta)
	pass
	
func _physics_process(delta):
	if not STATE_STACK.empty():
		STATE_STACK[0].physics_update(delta)
	pass

func switch(state: State):
	if STATE_STACK.empty():
		STATE_STACK.push_front(state)
		state.enter()
		on_any_enter(state)
		on_change(state, null)
	else:
		if not soft_mode:
			on_change(state, STATE_STACK[0])
			STATE_STACK[0].exit()
			on_any_exit(STATE_STACK[0])
			STATE_STACK[0] = state
			state.enter()
			on_any_enter(state)
		else:
			if state != STATE_STACK[0]:
				on_change(state, STATE_STACK[0])
				STATE_STACK[0].exit()
				on_any_exit(STATE_STACK[0])
				STATE_STACK[0] = state
				state.enter()
				on_any_enter(state)

func push(state: State):
	
	if not STATE_STACK.empty():
		if not soft_mode:
			on_change(state, STATE_STACK[0])
			on_any_exit(STATE_STACK[0])
			STATE_STACK[0].exit()
			STATE_STACK.push_front(state)
			on_any_enter(state)
			state.enter()
		else:
			if state != STATE_STACK[0]:
				on_change(state, STATE_STACK[0])
				on_any_exit(STATE_STACK[0])
				STATE_STACK[0].exit()
				STATE_STACK.push_front(state)
				on_any_enter(state)
				state.enter()
			else:
				STATE_STACK.push_front(state)
	else:
		on_change(state, null)
		STATE_STACK.append(state)
		on_any_enter(state)
		state.enter()
	
func pop():
	
	if not STATE_STACK.empty():
		on_any_exit(STATE_STACK[0])
		STATE_STACK[0].exit()
		STATE_STACK.pop_front()
		if not STATE_STACK.empty():
			on_any_enter(STATE_STACK[0])
			STATE_STACK[0].enter()
	pass

func insert(state: State, index: int):
	if STATE_STACK.empty():
		STATE_STACK.append(state)
		on_any_enter(state)
		on_change(state)
		state.enter()
	else:
		if index <= STATE_STACK.size():
			STATE_STACK.insert(index, state)
		else:
			STATE_STACK.append(state)
		

func on_any_enter(state: State):
	emit_signal("on_any_enter", state)

func on_any_exit(state: State):
	emit_signal("on_any_exit", state)

func on_change(state: State, pre_state: State = null):
	emit_signal("on_change", state, pre_state)
