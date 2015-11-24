function [ counter ] = WalkPolicyIteration( initial )
input_state = initial
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
       
discount_factor = 0.9;
policy = ceil(rand(16,1)*4);
value(16,1) = 0;
difference = 1;
old_value(16,4) = 0;
lhs_equation(16,16)=0
rhs_equation(16,1)=0;
counter = 0;
% initial step
while(difference ~= 0)
for s = 1:16
    action_given_policy = policy(s);
    s_prime = state_transition_matrix(s,action_given_policy);
    lhs_equation(s,s) = 1;
    lhs_equation(s,state_transition_matrix(s,policy(s))) = -discount_factor;
    rhs_equation(s) = reward_matrix(s,policy(s));
end

V_s = lhs_equation\rhs_equation;
utility = V_s;

% update step

for state = 1:16
    for action = 1:4
       value_for_action(action) = reward_matrix(state,action)+discount_factor*utility(policy(state_transition_matrix(state,action))); % removed policy out here
    end
    new_value(state,:) = value_for_action;
    [max_value policy(state)] = max(value_for_action);
end

difference = sum(new_value-old_value);
old_value = new_value; 
lhs_equation(16,16) = 0;
rhs_equation(16,1) = 0;
counter = counter+1;
end

states = [];
 states(1) = input_state;
 for my_state = 2:16
     states(my_state) = state_transition_matrix(states(my_state-1),policy(states(my_state-1)));
 end
 walkshow(states);

