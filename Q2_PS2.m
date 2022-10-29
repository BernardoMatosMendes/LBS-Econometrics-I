%Econometrics I
%Problem Set 2
%Bernardo Mendes

clear;
rng('default'); %Set seed

%% QUESTION 2, POINT a)
%Unbiasedness means that the estimator, under repeated sampling
%distributions, delivers, on average, the true parameter value

%Assuming 1000 observations per run
n=1000;

%Matrix for the constant term and the matrix of coefficients
x=ones(n,1);
Coefs=[1 0.5]'

%Run the regression and estimate the coefficients 5000 times
for k=1:5000,
    z=chi2rnd(3,n,1); %generate a vector with "i" random values from a N(1,1) distribution
    epsilon=unifrnd(-1,1,n,1); %generate a vector with "i" random values from a U(-1,1) distribution
    X=[x z]; %matrix X
    Y=X*Coefs+epsilon; %define the value of Y (vector of Y values)
    beta(k,:)=inv(X'*X)*X'*Y; %estimate the coefficients of the model
end

mean(beta)


%% QUESTION 2, POINT b)
beta_aux=zeros(1000,8);
alpha_aux=zeros(1000,8);

ss = [10 20 100 500 1000 4000 8000 16000]
for i=1:length(ss)
    for j=1:5000
       z=chi2rnd(3,ss(1,i),1); %generate a vector with "i" random values from a N(1,1) distribution
       epsilon=unifrnd(-1,1,ss(1,i),1); 
       y = 1+0.5*z +epsilon;
       X = [ones(ss(1,i),1) z];
       beta = inv(X'*X)*X'*y;
       beta_aux(j, i) =beta(2,1);
       alpha_aux(j, i) =beta(1,1);
    end 
end




%Plots for Beta 1
figure
histogram(beta_aux(:,1))
grid on;
title('Beta 1 10 Observations')
graph1=gca
exportgraphics(graph1,'Beta 1 10 obs.pdf')

figure
histogram(beta_aux(:,4))
grid on;
title('Beta 1 1000 Observations')
graph1=gca
exportgraphics(graph1,'Beta 1 1000 obs.pdf')

figure
histogram(beta_aux(:,8))
grid on;
title('Beta 1 16000 Observations')
graph1=gca
exportgraphics(graph1,'Beta 1 16000 obs.pdf')

figure
ksdensity(beta_aux(:,1))
hold on;
grid on;
ksdensity(beta_aux(:,2))
ksdensity(beta_aux(:,3))
ksdensity(beta_aux(:,4))
ksdensity(beta_aux(:,5))
ksdensity(beta_aux(:,6))
ksdensity(beta_aux(:,7))
ksdensity(beta_aux(:,8))
title('Beta 1')
legend({'10 Obs.','20 Obs.','100 Obs.','500 Obs.','1000 Obs.','4000 Obs.','8000 Obs.','16000 Obs.'},'Location','northwest')
graph01=gca
exportgraphics(graph01,'Beta 1 combined.pdf')


%Plots for Beta 0
figure
histogram(alpha_aux(:,1))
grid on;
title('Beta 0 10 Observations')
graph1=gca
exportgraphics(graph1,'Beta 0 10 obs.pdf')

figure
histogram(alpha_aux(:,4))
grid on;
title('Beta 0 1000 Observations')
graph1=gca
exportgraphics(graph1,'Beta 0 1000 obs.pdf')

figure
histogram(alpha_aux(:,8))
grid on;
title('Beta 0 16000 Observations')
graph1=gca
exportgraphics(graph1,'Beta 0 16000 obs.pdf')

figure
ksdensity(alpha_aux(:,1))
hold on;
grid on;
ksdensity(alpha_aux(:,2))
ksdensity(alpha_aux(:,3))
ksdensity(alpha_aux(:,4))
ksdensity(alpha_aux(:,5))
ksdensity(alpha_aux(:,6))
ksdensity(alpha_aux(:,7))
ksdensity(alpha_aux(:,8))
title('Beta 0')
legend({'10 Obs.','20 Obs.','100 Obs.','500 Obs.','1000 Obs.','4000 Obs.','8000 Obs.','16000 Obs.'},'Location','northwest')
graph01=gca
exportgraphics(graph01,'Beta 0 combined.pdf')


%% QUESTION 2, POINT c)
figure
r = normrnd(0.5,1/18,16000,1);
histogram(beta_aux(:,8));
histfit(r)
grid on;
legend({'Regression Slope','Normal (1/2, 1/18)'},'Location','northwest')
graph2=gca
exportgraphics(graph2,'Normal Distribution.pdf')



%% QUESTION 2, POINT d)
%Assuming 1000 observations per run
n=1000;

%Matrix for the constant term and the matrix of coefficients
x=ones(n,1);
Coefs=[1 0.5]'

%Run the regression and estimate the coefficients 5000 times
for k=1:5000,
    z=chi2rnd(3,n,1); %generate a vector with "i" random values from a N(1,1) distribution
    epsilon=unifrnd(-1,1,n,1); %generate a vector with "i" random values from a U(-1,1) distribution
    X=[x z]; %matrix X
    Y=X*Coefs+epsilon; %define the value of Y (vector of Y values)
    beta=inv(X'*X)*X'*Y; %estimate the coefficients of the model
    residuals=Y-X*Coefs;
    residuals_sq=residuals'*residuals;
    sigma(k,:)=residuals_sq/(n-2);
end

mean(sigma)
