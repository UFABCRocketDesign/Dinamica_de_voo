% UFABC Rocket Design
% Rotina: Algoritmo de Fluter
% Respons�vel: Giovanna Gon�alves
% Departamento de Estruturas e Aerodin�mica
% Frente de desenvolvimento: Din�mica de voo
% Revis�o: 26/07/2021


clc;
clear all;
close all;

% Vetor altitude (m)
h = 0:3500;

% Par�metros atmosf�ricos (K, m/s, Pa, kg/m^3)
[T,a,P,rho] = atmosisa(h);

% b = altura da empena (m)
b = 0.2;
% Cr = base maior (m)
Cr = 0.4;
% Ct = base menor (m)
Ct = 0.15;
% Corda m�dia da empena
Cav = (Cr + Ct)/2;
% Calculo do Aspect Ratio
AR = b/Cav;
% Calculo do Taper Ratio
lambda = Ct/Cr;
% GE = m�dulo de tor��o do material (MPa)
GE = 25.8*(10^9);
%ta = espessura da empena do tipo A (m)
ta = 0.003;
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


imenu = 2;
while (imenu ~= 1)
    imenu = menu('An�lise de Flutter','Fim da an�lise','Velocidade de Flutter','Mach de Flutter');
    close;
    
    switch (imenu)
        
        case 2
            figure;
            plot(h,FVa,'k','linewidth',1.5),grid;
            xlabel('Altitude (m)');
            ylabel('Velocidade de Flutter (m/s)');
            title('Varia��o da velocidade de Flutter referente a empena com 3 mm de espessura');
            
        case 3 
            figure;
            plot(h,Mach_a,'k','linewidth',1.5'),grid;
            xlabel('Altitude (m)');
            ylabel('N�mero de Mach de Flutter');
            title('Varia��o do n�mero de Mach referente a empena com 3 mm de espessura');
    end 
end
