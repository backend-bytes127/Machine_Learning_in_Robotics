A = textread('A.txt') % 12*12
B = textread('B.txt') % 8 * 12
pi = textread('pi.txt') % 1* 12
beobachtung_fur_testdatensatz = textread('A_Test_Binned.txt') % 60 * 10
beobachtung_fur_trainingdatensatz = textread('A_Train_Binned.txt') % 60 * 10
[m n] = size(beobachtung_fur_testdatensatz) % m= 60,n= 10

likelihood_train(10,1) = 0;
likelihood_test(10,1) = 0;
classify(10,1) = 0;

for i = 1:n
    
    obs = beobachtung_fur_trainingdatensatz(:,i)
    alpha(60,12) = 0;
    for state = 1:12
        alpha(1,state) = pi(state)*B(obs(1),state)
    end
    for t = 1:(60-1)
     for j = 1:12
        sum = 0;
        for k = 1:12
           sum = sum+alpha(t,k)*A(k,j); 
        end
        alpha(t+1,j) = sum*B(obs(t+1),j);
     end
    end
    prb = 0;
    for z = 1:12
        prb = prb+alpha(60,z)
    end
    likelihood_train(i)=log(prb)
end

% testdatensatz
for i = 1:n
    
    obs = beobachtung_fur_testdatensatz(:,i)
    alpha(60,12) = 0;
    for state = 1:12
        alpha(1,state) = pi(state)*B(obs(1),state)
    end
    for t = 1:(60-1)
     for j = 1:12
        sum = 0;
        for k = 1:12
           sum = sum+alpha(t,k)*A(k,j); 
        end
        alpha(t+1,j) = sum*B(obs(t+1),j);
     end
    end
    prb = 0;
    for z = 1:12
        prb = prb+alpha(60,z)
    end
    likelihood_test(i)=log(prb)
end


for class_var=1:10
    if likelihood_test(class_var)> -120
        classify(i)=1;
    end
end