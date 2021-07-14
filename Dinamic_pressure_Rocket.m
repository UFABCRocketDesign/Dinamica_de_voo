clc;
clear all;
close all;
% Inputs do Open Rocket
    data = load('OR_40.txt');
    alt = data(:,2);
    Vel = data(:,3);
%Constantes
    a0 = 331.3;
    Po = 101325;
    d = 0.1584;
    R = 287.058;
% Inputs adicionais
    To = input('Insira o valor da temperatura C� : ');
% Calculo das variaveis envolvidas
    Th = To - ((6.5*alt)/1000);
    To = To +273.15;
    P = Po*((1 - 0.0065*(alt/To)).^(5.2561));
    a = a0 + 0.606*Th;
    Mach = Vel./a;
%Por defini��o temos que um fluido � compressivel se o numero de Mach for
%maior que 0.3, abaixo do valor descrito, o fluido � imcompressivel, no
%entanto, a forma de calcular a press�o esta diretamente ligada ao estado
%do fluido.
% Varia��o da densidade do ar
Th = Th + 273.15;
rho = P./(R.*Th);
% Fator de compressibilidade
for j = 1:length(Mach)
    gamma(j,1) = ((a(j,1).^2).*rho(j,1))/P(j,1);
end
% Calculo da press�o din�mica
for i = 1:length(Mach)
    if Mach(i,1)< 0.3
        q(i,1) =(rho(i,1).*(Vel(i,1).^2))./2;
    else
        q(i,1) =((Mach(i,1).^2).*(gamma(i,1).*P(i,1)))/2;
    end
end
% Calculo do Flutter
% b: the semi-span ; Cr: root chords ; Ct: tip chords
b = 0.2;
Cr = 0.40;
Ct = 0.15;
% Cav: Average Chord 
Cav = (Cr + Ct)/2;
% AR: Aspect Ratio
AR = b/Cav;
lambda = Ct/Cr;
%S: Fins area
%GE: Effective Shear Modulus
GE = 25.8*(10^9);
% t: Fin Thickness
ta = 0.005;
% Parameters for calculating the Flutter speed
r = (ta/Cr)^3;
%Parameter 1
P1 = (1.337*(AR)^3)*(P*(lambda + 1)); 
%Parameter 2
P2 = 2*(AR +2)*r;
%Parameter 3
P3 = P1/P2;
% FV: Flutter velocity
FV = a.*sqrt(GE./P3);
Mach_a = FV./a;
%Flutter Pressure
FP = P + (Mach_a.^2).*((gamma.*P)/2);
% Plot do gr�fico de Press�o din�mica do foguete ai longo do voo at� o apogeu
% Dados para discuss�o
figure(1)
plot(alt,q,'r','lineWidth',2),grid;
hold on 
plot(alt,FP,'k','lineWidth',2);
xlabel('Altitude do foguete ao longo do voo (m)','FontSize',12);
ylabel('Press�o din�mica (Pa)','FontSize',12);
title('Compara��o entre as press�es din�micas do foguete e a de Flutter','FontSize',12);
legend('Press�o din�mica do foguete','Press�o din�mica de Flutter','Location','Northwest');
figure(2)
plot(alt,Vel,'r','lineWidth',2),grid;
hold on 
plot(alt,FV,'k','lineWidth',2);
xlabel('Altitude (m)');
ylabel('Velocidade (m/s)');
title('Varia��o das velocidades do foguete e de Flutter ao longo do voo at� o apogeu');
legend('Velocidade do foguete','Velocidade de Flutter','Location','Northwest');
figure(3)
plot(alt,a,'b-.','lineWidth',1.7),grid;
xlabel('Altitude (m)');
ylabel('Velocidade do som (m/s)');
title('Varia��o da velocidade do som em fun��o da altitude a 25�C');
figure(4)
plot(alt,q,'r','lineWidth',2),grid;
xlabel('Altitude(m)','FontSize',12);
ylabel('Press�o din�mica (Pa)','FontSize',12);
title('Varia��o da press�o din�mica do foguete ao longo do voo','FontSize',12);
