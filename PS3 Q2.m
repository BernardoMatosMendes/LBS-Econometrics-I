%Econometrics I
%Problem Set 3
%Bernardo Mendes

%% QUESTION 2 c)
clear;
rng('default'); %Set seed

[Cost output Plabor Pcapital Pfuel] = readvars('Nerlove1963')

%Generating variables
log_Cost=log(Cost)
log_output=log(output)
log_Pcapital=log(Pcapital)
log_Pfuel=log(Pfuel)
log_Plabor=log(Plabor)

%
beta=linspace(3.76,8.67,1000)';
z=zeros(145,1000);
for i=1:1000,
    for j=1:145
    z(j,i)=log_output(j,1)*(1+exp(beta(i,1)-log_output(j,1)))^(-1);
    end
end


ones=ones(145,1);

%Generate the independent variable Y, imposing the restrictions
beta1=zeros(1000,1);
beta2=zeros(1000,1);
beta3=zeros(1000,1);
beta4=zeros(1000,1);
beta6=zeros(1000,1);
RSS=zeros(1000,1);

Y=log_Cost-log_Pfuel
aux1=log_Plabor-log_Pfuel
aux2=log_Pcapital-log_Pfuel

for i=1:1000,
    X=[ones log_output aux1 aux2 z(:,i)];
    beta_ols=inv(X'*X)*X'*Y;
    beta1(i,1) = beta_ols(1,1);
    beta2(i,1) = beta_ols(2,1);
    beta3(i,1) = beta_ols(3,1);
    beta4(i,1) = beta_ols(4,1);
    beta6(i,1) = beta_ols(5,1);
    RSS(i,1)=(Y-X*beta_ols)'*(Y-X*beta_ols);
end

[M,I] = min(RSS);
beta(I)
beta1(I)
beta2(I)
beta3(I)
beta4(I)
beta6(I)


%% QUESTION 2 d)
beta_hat=[beta1(I) beta2(I) beta3(I) beta4(I) beta6(I)]';
z_hat=zeros(145,1)


for n=1:145
    z_hat(n,1)=log_output(n,1)*(1+exp(beta(I)-log_output(n,1)))^(-1);
end

X_hat= [ones log_output aux1 aux2 z_hat]
RES= Y-X_hat*beta_hat
SSR=sum(RES.*RES)

for i=1:145
    derivative(:,i) = [X_hat(i,:)';-beta6(I)*(output(i)*exp(beta(I))*log_output(i))/(output(i)+exp(beta(I)))^2];
end

D=(derivative*derivative')/145
sigma2 = SSR/(145-6)

Var_Cov = 1/145* sigma2 * inv(D)

sqrt(Var_Cov(1,1))
sqrt(Var_Cov(2,2))
sqrt(Var_Cov(3,3))
sqrt(Var_Cov(4,4))
sqrt(Var_Cov(5,5))
sqrt(Var_Cov(6,6))











