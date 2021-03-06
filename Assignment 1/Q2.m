y=zeros(100,1);                                   % mole fraction of ethanol in vapor phase
T=zeros(100,1);
x=zeros(100,1);                                   % mole fraction of ethanol in liquid phase
x(1)=0.01;
for i=2:100
    x(i)=x(i-1)+0.01;
end
t2=temp(3.55959,643.748,-198.043,760);            % saturation temperature for water
t1=temp(4.92531,1432.526,-61.819,760);            % saturation temperature for ethanol
for i=1:100
    g1=gamma1(x(i));
    g2=gamma2(x(i));
    T(i)=t1*x(i)+t2*(1-x(i));
    p2=pressure(3.55959,643.748,-198.043,T(i));   %saturation pressure for water at T(i)
    p1=pressure(4.92531,1432.526,-61.819,T(i));   %saturation pressure for ethanol at T(i)
    p=p1*g1*x(i)+p2*g2*(1-x(i));
    y(i)=p1*g1*x(i)/p;
end
%% Plotting y vs x curve
figure
plot(x,y);
xlim([0,1]);
hold on;
xlabel('x');
ylabel('y');
title('y Vs x');
function [t]=temp(A,B,C,P)
    t=(B/(A-log10(P)))-C+273;
end
function [g1]=gamma1(x)
    g1=exp(0.4883*((1.1504*(1-x))/((0.4883*x)+1.1504*(1-x)))^(2));
end
function [g2]=gamma2(x)
    g2=exp(1.1504*((0.4883*x)/((0.4883*x)+1.1504*(1-x)))^(2));
end
function [p]=pressure(A,B,C,t)
    p=(10^(A-(B/(t-273+C))));
end