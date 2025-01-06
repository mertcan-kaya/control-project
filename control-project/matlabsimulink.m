%Group 3
%Mertcan Kaya
%Hakan Ýmamoðlu
%Engin Can Akalýn
%Mustafa Doruk

clear all
close all
clc

m = 0.01; % [kg]
b = 0; % [N.m/(rad/s)]
g = 9.81; % [m/s^2]
l = 0.5; % [m]
lambda = m*l^2;

Kp_d = 26;

plant = tf(1, [lambda b -m*g*l]);
newPlant = tf([1 Kp_d], [lambda b -m*g*l]);

figure(1)
pzmap(plant)

figure(2)
rlocus(newPlant)

D = 0.03; % (Choosed from the figure)
P = Kp_d*D;
I = 0;

sim('Simulinkproject')

figure(3)
plot(theta.time,theta.signals.values)
xlabel('Time [s]')
ylabel('Theta [deg]')
legend('Pend. Angle')

endTime = theta.time(end);
deltaT = endTime/length(theta.time);

figure(4)
for i = 1:length(theta.time)
    currentAngle = (pi/180)*(theta.signals.values(i));
    clf
    pX = [0,2*l*sin(currentAngle)];
    pY = [0,2*l*cos(currentAngle)];
    plot([0 2*l*sin(currentAngle)],[0 2*l*cos(currentAngle)],'k-',2*l*sin(currentAngle),2*l*cos(currentAngle),'ro','linewidth',2.5)
    border = [-2*l 2*l 0 2*l];
    axis(border)
    xlabel('x-axis [m]');
    ylabel('y-axis [m]');
    pause(0.02);  
end