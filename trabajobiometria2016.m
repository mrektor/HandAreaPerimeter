% José Antonio Benítez Quevedo
% Máster en Ingeniería de Telecomunicación
% Aplicaciones Tecnológicas en Seguridad
% Bloque II - Introducción a los sistemas de control de acceso biométricos

% Trabajo Bloque II - Evaluación del rendimiento de un sistema biométrico

clear all
close all
clc

load('scores.mat');

% 1 - Estimar la función de probabilidad de ambas distribuciones de scores
% y dibujarlas en la misma gráfica.
paso = 0.05;
valor_scores = 0:paso:10;

prob_falso = histc(score_falso,valor_scores);
area_probfalso = sum(prob_falso.*paso);
prob_falso = prob_falso ./ area_probfalso;

prob_genuino = histc(score_genuino,valor_scores);
area_probgenuino = sum(prob_genuino.*paso);
prob_genuino = prob_genuino ./ area_probgenuino;

subplot(2,2,1)
plot(valor_scores,prob_genuino,valor_scores,prob_falso,'LineWidth',2)
grid on
xlabel('Puntuación')
ylabel('Probabilidad')
title('Función densidad de probabilidad')
legend('Distribución genuinos','Distribución falsos')

% 2 - Dibujar las curvas de falsa aceptación (FA) y falso rechazo (FR).
% Calcular la tasa de error igual (Equal Error Rate, EER).

FAR = cumsum(prob_falso*paso);
FRR = 1 - cumsum(prob_genuino*paso);

distancias = abs(FAR-FRR);

[valor_min pos] = min(distancias);

umbral = valor_scores(pos);
fprintf('El umbral óptimo del sistema biométrico es %1.2f\n',umbral);

EER = (FAR(pos)+FRR(pos))/2;
fprintf('La tasa de error igual (EER) del sistema biométrico es %1.5f\n',EER);

subplot(2,2,2)
plot(valor_scores,FRR,valor_scores,FAR,'LineWidth',2)
grid on
xlabel('Puntuación')
ylabel('Probabilidad')
axis([0 10 0 1])
title('Curvas de falsa aceptación y falso rechazo')
legend('Curva falsa aceptación','Curva falso rechazo')

% 3 - Dibujar la curva DET (Detection Error Tradeoff)

subplot(2,2,3)
plot(FAR,FRR,'LineWidth',2)
grid on
xlabel('Falsa aceptación')
ylabel('Falso rechazo')
axis([0 1 0 1])
title('Curvas de falsa aceptación y falso rechazo')

% 4 - Dibujar la curva ROC (Receiver Operating Characteristics) y calcular
% el área bajo la curva (Area Under Curve: AUC)

subplot(2,2,4)
h = plot(FAR,1-FRR,'LineWidth',2);
grid on
xlabel('Falsa aceptación')
ylabel('1 - Falso rechazo')
axis([0 1 0 1])
title('Curva ROC')

AUC = trapz(FAR,1-FRR);
fprintf('El área bajo la curva ROC (AUC) del sistema biométrico es %1.5f\n',AUC);



