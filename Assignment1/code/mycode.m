
A = load('data.mat');
input = A.Input;
output = A.Output;
degree = 6
%polyvaln(input(1:2,:),output(1:3,:),7)

v = input(1,:);
w = input(2,:);
[m,n] = size(input);
v = v.';
w = w.';
inp = [v,w];
out = output;
out = out.';
z = []
for i=1:degree
z=[z,v.^i, w.^i, v.^i.*w.^i];
    
end

z = [ones(n,1),z];
beta = inv(z.'*z)*z.';

value = beta * out;

weight = value;

final_output = weight.'*z.';

error = (output - final_output).^2;

my_x = (output(1,:) - final_output(1,:)).^2;
my_y = (output(2,:) - final_output(2,:)).^2;
my_theta=(output(3,:) - final_output(3,:)).^2;
position_error = sum((my_x)+(my_y));
position_error = sqrt(position_error);
position_error = position_error/n;

orientaton_error = sqrt(sum(my_theta))/n;


%k = 2

%training_data = 1+((k-1)* 20000/k);
%test_data = k * 20000/k;
 

%value_x = weight(1,:)
%value_x =value(1,1) + value(2,1)*v(1,1) + value(3,1)*w(1,1)+ value(4,1)*v(1,1)*w(1,1);
%value_y =value(1,2) + value(2,2)*v(1,1) + value(3,2)*w(1,1)+ value(4,2)*v(1,1)*w(1,1);
%value_theta = value(1,3) + value(2,3)*v(1,1) + value(3,3)*w(1,1)+ value(4,3)*v(1,1)*w(1,1);