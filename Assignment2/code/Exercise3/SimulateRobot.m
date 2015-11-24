function [new_state reward]=SimulateRobot(state,action,state_transition_matrix,reward_matrix)

new_state =state_transition_matrix(state,action);
reward = reward_matrix(state,action);
end