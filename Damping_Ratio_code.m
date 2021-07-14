clc;
clear all;
close all;
%% Dados importados do Open Rocket
data = load('wilson.txt');
t = data(:,1);
h = data(:,2);
V = data(:,3);
M = data(:,4);
I = data(:,5);
CP = data(:,6);
CG = data(:,7);
%%
% Analise 32 cm constantes
% CN_fins = 15.7;
% CN_nc = 2.16;
% CN = 18.5;
% Z_nc = 0.32;
% Z_fins = 1.797;

% Analise 36 cm constantes

% CN_fins = 15.6;
% CN_nc = 2.18;
% CN = 18.5;
% Z_nc = 0.36;
% Z_fins = 1.837;

%% Analise 40 cm constantes
CN_fins = 15.6;
CN_nc = 2.2;
CN = 18.5;
Z_nc = 0.4;
Z_fins = 1.877;

% Area de referencia empenas

cr = 0.4;
ct = 0.15;
b = 0.2;
A = ((cr+ct)*b)/2;

%% Coeficiente de momento Corretivo
% Densidade do ar
%Constantes
Po = 101325;
R = 287.058;
% To = input('Insira o valor da temperatura no local de lançamento C° : ');
To = 30;
% variação da temperatura em função da altitude
Th = To - ((6.5*h)/1000);
To = To + 273.15;
a0 = 331.3;
a = a0 + 0.606*Th;
Mach = V./a;
Th = Th + 273.15;
% Variação da pressão 
P = Po*((1 - 0.0065*(h/To)).^(5.2561));
rho = P./(R.*Th);
% Calculo do momento corretivo
C1 = (rho./2).*(V.^2).*A.*CN.*(CP-CG);

%% Coeficiente de Momento Dissipativo/amortecedor
% Calculo do C1 
C2_R = M.*((Z_nc-CG).^2);
% Calculo de C2
C2_A = ((rho.*V.*A)./2).*(CN_fins.*((Z_fins - CG).^2)+ CN_nc.*((Z_nc - CG).^2));
C2 = C2_A + C2_R;
% Damping Ratio
Dr = C2./(2.*sqrt(C1.*I));
save('Damping','Dr');

%% Frequência natural
for i = 1: length(C1)
w(i,1) = sqrt(C1(i,1)./I(i,1));
end
min = 0.15*V;
max = 0.18*V;

for i = 1: length(C1)
P2(i,1) = (w(i,1)./V(i,1)).*100;
end

%% Damping máximo e minimo recomendado para um voo estável

for j = 1: length(w)
    drm(j,1) = 0.05;
    drmx(j,1) = 0.3;
end

%% Calculo da velocidade angular de Homogeneous Response e Step Response
D = C2./(2*I);
B = 1;
omega = 0;
B1 = 0;
B2 = 1;
for k = 1: length(w)
    Vah(k,1) = B.*exp(-D(k,1).*t(k,1)) + sin(w(k,1).*t(k,1) + omega);
    Vas(k,1) = (B1 + B2.*t(k,1)).*exp(-D(k,1).*t(k,1)) + sin(w(k,1).*t(k,1) + omega);
end

% Calculo do anglo de ataque do foguete

for k = 1: length(w)
  angleH(k,1) = (Vah(k,1).*(CP(k,1)-CG(k,1)))./V(k,1);
  angleS(k,1) = (Vas(k,1).*(CP(k,1)-CG(k,1)))./V(k,1);
end

%% Plot do grafico de Damping
% figure(1)
% plot(h,Dr,'k','lineWidth',1.5),grid;
% hold on
% plot(h,drm,'r--','lineWidth',1.1);
% hold on
% plot(h,drmx,'r--','lineWidth',1.1);
% xlabel('Altitude do foguete (m)');
% ylabel('Damping Ratio');
% title('Variação do Damping Ratio em função da altitude');
% legend('Curva do Damping Ratio','Limite de Damping ótimo para voo ');
% 
% %Plot da Homogeneous Response
% figure(5)
% plot(t,angleH,'k','lineWidth',1.5),grid;
% xlabel('Tempo (s)');
% ylabel('Ângulo de ataque (rad)');
% title('Homogeneous Response: Variação do ângulo de ataque do foguete');
% xlim([0.43, 12])
% 
% %Plot da Step Response
% figure(6)
% plot(t,angleS,'r','lineWidth',1.5),grid;
% xlabel('Tempo (s)');
% ylabel('Ângulo de ataque (rad)');
% title('Step Response: Variação do ângulo de ataque do foguete');
% xlim([0.43, 12])

%% Plot da frequência natural do foguete
% figure(2)
% plot(h,w,'k','lineWidth',1.5),grid;
% hold on
% plot(h,min,'r-.','lineWidth',1.5);
% hold on
% plot(h,max,'r-.','lineWidth',1.5);
% xlabel('Altitude do foguete (m)');
% ylabel('Frequência natural do foguete (rad/s)');
% title('Variação da frequência natural do foguete em função da altitude');
% legend('Frequência natural do foguete','Faixa indicada para estabilidade do foguete');

% Ampliação de area
% figure(3)
% plot(h,w,'k','lineWidth',1.5),grid;
% hold on
% plot(h,min,'r-.','lineWidth',1.5);
% hold on
% plot(h,max,'r-.','lineWidth',1.5);
% xlabel('Altitude do foguete (m)');
% ylabel('Frequência natural do foguete (rad/s)');
% title('Variação da frequência natural do foguete em função da altitude');
% legend('Frequência natural do foguete','Faixa indicada para estabilidade do foguete');
% axes('Position',[0.25 0.2 0.15 0.3]);
% box on
% plot(h,w,'k','lineWidth',1.5),grid;
% hold on
% plot(h,min,'r-.','lineWidth',1.5);
% hold on
% plot(h,max,'r-.','lineWidth',1.5);
% xlim([500 1000]);
% ylim([25 55]);

% Percentual da frequencia
% figure(4)
% plot(h,P2,'b-.','lineWidth',1.5),grid;
% xlabel('Altitude do foguete (m)');
% ylabel('Percentual da frequência natural do foguete (%)');
% title('Variação do percentual da frequência natural do foguete em função da altitude');

figure(5)
plot(h,V,'k-','lineWidth',1.5),grid;
xlabel('Altitude do foguete (m)');
ylabel('Velocidade [m/s]');
title('Velocidade do Foguete vs. Altitude');

