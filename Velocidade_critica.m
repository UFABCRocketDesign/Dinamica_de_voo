clc;
clear all;
close all;
%% Dados importados do Open Rocket
data = load('dados_OR40.txt');
t = data(:,1);
h = data(:,2);
V = data(:,3);
M = data(:,4);
I = data(:,5);
CP = data(:,6);
CG = data(:,7);

% Analise 40 cm constantes
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
% Constantes
Po = 101325;
R = 287.058;
To = 30;
Th = To - ((6.5*h)/1000);
To = To + 273.15;
Th = Th + 273.15;
% Variação da pressão
P = Po*((1 - 0.0065*(h/To)).^(5.2561));
rho = P./(R.*Th);
% Area de referencia empenas
cr = 0.3;
ct = 0.15;
b = 0.2;
A = ((cr+ct)*b)/2;
% Parametro 1
P1 = M.*((Z_nc-CG).^2);
% Parametro 2
P2 = ((rho.*A)./2).*(CN_fins.*((Z_fins - CG).^2)+ CN_nc.*((Z_nc - CG).^2));
% Parametro 3
P3 = (rho./2).*A.*CN.*(CP-CG).*I;

%% Damping Ratio
fprintf('Tipos de simulação \n');
fprintf('1: Valores de Damping Ratio indicados para as respctivas camadas da ABL \n');
fprintf('2: Valores de Damping Ratio das simulações do foguete \n');
type = input('Insira o tipo de simulação desejada: ');
 if type == 1   
for i = 1 :length(t)  
% Tempo relativo a 100 metros
if t(i,1)< 1.8523
       Damping(i,1) = 0.7;  
% Tempo relativo a faixa de 100 a 600 metros
elseif  t(i,1)>= 1.8523 && t(i,1)< 4.5522
    
    Damping(i,1) = 0.3;
    
% Tempo relativo a altitude acima de 600 metros
 
else
    Damping(i,1) = 0.1;
end
end
else
Damping = load ('damping.txt');
end
%Calculo da velocidade critica

Vc = P1./((2.*Damping.*sqrt(P3)) - P2);

%% Plot do grafico de Damping

figure(1)
plot(t,V,'r','lineWidth',1.5),grid;
hold on
plot(t,Vc,'k:o','lineWidth',1.1);
xlabel('Tempo de voo até o apogeu (s)');
ylabel('Velocidade (m/s)');
title('Comparação entre a velocidade critica e a do foguete');
legend('Velocidade do foguete','Velocidade critica');
xlim([0.428 5]);
% Detalhamento de região
% axes('Position',[0.6 0.2 0.2 0.3]);
% box on
% plot(t,V,'r','lineWidth',1.5),grid;
% hold on
% plot(t,Vc,'k-.','lineWidth',1.1);
% xlim([2.5 4]);
% ylim([ 150 250]);
