function [ output_state] = WalkQLearning( initial)
Q = zeros(16,4)
state_transition_matrix = [2 4 5 13; 1 3 6 14; 4 2 7 15; 3 1 8 16; 6 8 1 9; 5 7 2 10; 8 6 3 11; 7 5 4 12; 10 12 13 5; 9 11 14 6; 12 10 15 7; 11 9 16 8; 14 16 9 1; 13 15 10 2; 16 14 11 3; 15 13 12 4];
reward_matrix =  [2 -2  2 -2;
            -2 2 -2 -2;
            2 -2 -2 -2;
            -2 -2 2 -2;
            -2 -2 -2 2;
            2  -2 2 -2;
            2 -2  2 -2;
            -2 2 -2 -2;
            -2 -2 2 -2;
            2 -2 2  -2;
            2  2  2  2;
            -2 2 -2 2;
            2 -2 -2 -2;

            -2 -2 -2 2;
            -2 2 -2 2;
            -2 2 -2 2];
epsilon = 10;
alpha = 0.1;
discount_factor = 0.9;
initial_state = initial;
T = 80
number_of_steps=1;

while(number_of_steps < T)
    
    [value1,maximum_action] = max(Q(initial_state,:));
    random_action = randi([1,4])
    random_number_generator = randi([1,100]);

if(random_number_generator<=epsilon)
    action_taken = random_action;
    policy(initial_state) = action_taken
else
    action_taken = maximum_action;
    policy(initial_state) = action_taken
end

[new_state,reward] = SimulateRobot(initial_state,action_taken,state_transition_matrix,reward_matrix);

Q(initial_state,action_taken) = Q(initial_state,action_taken)  + alpha*(reward+discount_factor*max(Q(new_state, :)) - Q(initial_state, action_taken));
initial_state = new_state
number_of_steps = number_of_steps+1;
end


initial_state = initial;
states = [];
states(1) = initial_state;

for i=2:16
    [value index] = max(Q(states(i-1),:));
    states(i) = state_transition_matrix(states(i-1),index);
end
output_state = states;
walkshow(states)