%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo Teste Simulação Massa Ponto
% UFABC Rocket Design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;
% Constante da gravidade
g = 9.81; % Aceleração da gravidade (m/s²) 
% Dados Propulsão Vetor de Empuxo VProp
VProp = load('Prop.txt');

% Dados Propulsão Vetor de Massa do propelente VMass 
VMass = load('mass.txt');

% Dado massa do foguete vazio(kg)
Mvazio = 32.3;

% Diâmetro do foguete (m)
d = 0.158;

%Tempo de queima 
Tq = VProp(end, 1);
%Área de Referência (m^2)
Sref = 0.0196;

% Dados Coeficiente de Arrasto 

VCD = [ 0.0 0.3757
        0.1	0.3757
        0.2	0.3403
        0.3	0.3219
        0.4	0.3095
        0.5	0.3001
        0.6	0.2927
        0.7	0.2888
        0.8	0.2863
        0.9	0.3042
        1.0	0.4179
        1.1	0.4666
        1.2	0.4852
        1.3	0.5534
        1.4	0.5114
        1.5	0.4794];

   % Condições iniciais de voo
   V0 = 24; %velocidade inicial de lançamento
   Gamma0 = deg2rad(85); % angulo de ataque (rad)
   X0 = deg2rad(45); % angulo inicial de rumo (rad)
   XEast0= 0; % XEast inicial(m)
   XNorth0 = 0; %XNorth inicial(m)
   XUp0 = 0; % XUp inicial (m)
   
   % Tempo de simulação
   TVoo = 200; %Tempo(s)
   
   % Passo de simulação 
   Step = 0.1;
   
   % Integração Matlab/Simulink
   sim('SimulacaoMassaPonto.slx');
   
   plot(ans.tout,ans.XUp);grid;

