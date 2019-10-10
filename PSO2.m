% m-file, Particle Swarm Optimization, written by Mojtaba Eslami

clear all

N = 20;
xl = -5;
xu = 5;

theta_max = 0.9;
theta_min = 0.4;
i_max = 200;

c1 = 2;
c2 = 2;

theta = theta_max;

for i=1:N
    X(:,i) = xl+(xu-xl)*rand(2,1); % generate random numbers from the interval [xl,xu]
    f(i) = 20+X(1,i)^2+X(2,i)^2-10*(cos(2*pi*X(1,i))+cos(2*pi*X(2,i)));
end

F = 1./f;
V_old = zeros(2,N);
P_best = -100*ones(1,N);

G_best = -100;

count = 0; %used for counting the number of best solutions 


figure(1);clf;hold on
x=[-5:0.02:5];
y=[-5:0.02:5];
for i=1:length(x)
    for j=1:length(y)
        f(j,i) = 20+x(i)^2+y(j)^2-10*(cos(2*pi*x(i))+cos(2*pi*y(j)));
    end
end
contour(x,y,f,10)
colormap(gray)
xlabel('x_1')
ylabel('x_2')



for i=1:i_max

    for j=1:N
        if F(j)>P_best(j)
            P_best(j) = F(j);
        end
    end
    
    if max(P_best)>G_best
        G_best = max(P_best);
        temp = find(P_best==G_best,1);
        X_best = X(:,temp);
        count = count+1;
    end
    
    V_new = theta*V_old+c1*rand(2,N).*([P_best;P_best]-X)+c2*rand(2,N).*(G_best*ones(2,N)-X);
    X = X+V_new;
    V_old = V_new;
    theta = theta_max-(theta_max-theta_min)*i/i_max;
    Gbest_plot(i) = 1./G_best;
    
    for i=1:N
        f(i) = 20+X(1,i)^2+X(2,i)^2-10*(cos(2*pi*X(1,i))+cos(2*pi*X(2,i)));
    end
    
    F = 1./f;
    plot(X_best(1,1),X_best(2,1),'k.')
    H = text(X_best(1,1),X_best(2,1)+.1,num2str(count));
    set(H,'FontSize',14)
    
end


figure(2)
plot(Gbest_plot,'k.')
xlabel('iteration number, i')
ylabel('G_{best}')

X_best
