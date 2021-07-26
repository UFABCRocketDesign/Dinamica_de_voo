% UFABC Rocket Design
% Rotina: Algoritmo de Fluter
% Responsável: Giovanna Gonçalves
% Departamento de Estruturas e Aerodinâmica
% Frente de desenvolvimento: Dinâmica de voo
% Revisão: 19/07/2021


clc;
clear all;
close all;

% Constantes
Po = 101325; % Pressão atmosférica a nível do mar [Pa]
h = 0:3500; % Vetor altitude [m]



Th = 25 - ((6.5*h)/1000);
% Calculo da velocidade do som (m/s)
 a0 = 331.3;
 a = a0 + 0.606*Th;
% Calculo da pressão atmosférica
To = 25 + 273.15;
P = Po*((1-0.0065*(h/To)).^(5.2561));
% b = input('Digite o valor da altura da empena (m): ');
b = 0.2;
% Cr = input('Digite o valor da base maior (m): ');
Cr = 0.4;
% Ct = input('Digite o valor da base menor (m): ');
Ct = 0.15;
Cav = (Cr + Ct)/2;
% Calculo do Aspect Ratio
AR = b/Cav;
% Calculo do Taper Ratio
lambda = Ct/Cr;
% GE = input('Digite o valor do módulo de torção do material (MPa) :');
GE = 25.8*(10^9);
%ta = input('Digite a espessura da empena do tipo A (m) :');
ta = 0.005;
ra = (ta/Cr)^3;
% Parametro 1
P1a = (1.337*(AR)^3)*(P*(lambda + 1)); 
% Parametro 2
P2a = 2*(AR +2)*ra;
%Parametro 3
P3a = P1a/P2a;
% Calculo da velocidade de Flutter
FVa = a.*sqrt(GE./P3a);
% Calculo do Mach de Flutter
Mach_a = FVa./a;
%-----------------------------------------------------------------------
%ta = input('Digite a espessura da empena do tipo B (m) :');
tb = 0.004;
rb = (tb/Cr)^3;
% Parametro 1
P1b = (1.337*(AR)^3)*(P*(lambda + 1)); 
% Parametro 2
P2b = 2*(AR +2)*rb;
% Parametro 3
P3b = P1b/P2b;
% Calculo da velocidade de Flutter
FVb = a.*sqrt(GE./P3b);
% Calculo do Mach de Flutter
Mach_b = FVb./a;
%------------------------------------------------------------------------
%ta = input('Digite a espessura da empena do tipo C (m) :');
tc = 0.003;
rc = (tc/Cr)^3;
% Parametro 1
P1c = (1.337*(AR)^3)*(P*(lambda + 1)); 
% Parametro 2
P2c = 2*(AR +2)*rc;
% Parametro 3
P3c = P1c/P2c;
% Calculo da velocidade de Flutter
FVc = a.*sqrt(GE./P3c);
% Calculo do Mach de Flutter
Mach_c = FVc./a;
%-------------------------------------------------------------------------
% plot graficos

% Salvar Dados
%Flutter1 = [FVa; FVb; FVc; Mach_a; Mach_b; Mach_c]';
%save('Flutter1');

%% Dados de comparação
[T1,a1,P1,rho1] = atmosisa(h);

% Empena 1
% Parametro 1
P1a1 = (1.337*(AR)^3)*(P1*(lambda + 1)); 
% Parametro 2
P2a1 = 2*(AR +2)*ra;
%Parametro 3
P3a1 = P1a1/P2a1;
% Calculo da velocidade de Flutter
FVa1 = a1.*sqrt(GE./P3a1);
% Calculo do Mach de Flutter
Mach_a1 = FVa1./a1;

% figure(1)
% plot(h,FVc,'b','linewidth',1.2),grid;
% xlabel('Altitude (m)');
% ylabel('Velocidade de Flutter (m/s)');
% title('Variação da velocidade de Flutter referente a empena com 3 mm de espessura');
% 
% figure(2)
% plot(h,FVb,'k','linewidth',1.5),grid;
% xlabel('Altitude (m)');
% ylabel('Velocidade de Flutter (m/s)');
% title('Variação da velocidade de Flutter referente a empena com 4 mm de espessura');
% 
% figure(3)
% plot(h,FVa,'r','linewidth',1.5),grid;
% xlabel('Altitude (m)');
% ylabel('Velocidade de Flutter (m/s)');
% title('Variação da velocidade de Flutter referente a empena com 5 mm de espessura');
% 
% % Plot dos gráficos referentes ao número de Mach
% 
% figure(4)
% plot(h,Mach_c,'b-.','linewidth',1.5'),grid;
% xlabel('Altitude (m)');
% ylabel('Número de Mach de Flutter');
% title('Variação do número de Mach referente a empena com 3 mm de espessura');
% 
% figure(5)
% plot(h,Mach_b,'k-.','linewidth',1.5'),grid;
% xlabel('Altitude (m)');
% ylabel('Número de Mach de Flutter');
% title('Variação do número de Mach referente a empena com 4 mm de espessura');
% 
% figure(6)
% plot(h,Mach_a,'r-.','linewidth',1.5'),grid;
% xlabel('Altitude (m)');
% ylabel('Número de Mach de Flutter');
% title('Variação do número de Mach referente a empena com 5 mm de espessura');

