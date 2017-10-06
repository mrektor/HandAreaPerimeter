% Jos� Antonio Ben�tez Quevedo
% M�ster en Ingenier�a de Telecomunicaci�n
% Aplicaciones Tecnol�gicas en Seguridad
% Bloque II - Introducci�n a los sistemas de control de acceso biom�tricos

% Trabajo Bloque II - Evaluaci�n del rendimiento de un sistema biom�trico

clear all
close all
clc

load('scores.mat');

% 1 - Estimar la funci�n de probabilidad de ambas distribuciones de scores
% y dibujarlas en la misma gr�fica.
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
xlabel('Puntuaci�n')
ylabel('Probabilidad')
title('Funci�n densidad de probabilidad')
legend('Distribuci�n genuinos','Distribuci�n falsos')

% 2 - Dibujar las curvas de falsa aceptaci�n (FA) y falso rechazo (FR).
% Calcular la tasa de error igual (Equal Error Rate, EER).

FAR = cumsum(prob_falso*paso);
FRR = 1 - cumsum(prob_genuino*paso);

distancias = abs(FAR-FRR);

[valor_min pos] = min(distancias);

umbral = valor_scores(pos);
fprintf('El umbral �ptimo del sistema biom�trico es %1.2f\n',umbral);

EER = (FAR(pos)+FRR(pos))/2;
fprintf('La tasa de error igual (EER) del sistema biom�trico es %1.5f\n',EER);

subplot(2,2,2)
plot(valor_scores,FRR,valor_scores,FAR,'LineWidth',2)
grid on
xlabel('Puntuaci�n')
ylabel('Probabilidad')
axis([0 10 0 1])
title('Curvas de falsa aceptaci�n y falso rechazo')
legend('Curva falsa aceptaci�n','Curva falso rechazo')

% 3 - Dibujar la curva DET (Detection Error Tradeoff)

subplot(2,2,3)
plot(FAR,FRR,'LineWidth',2)
grid on
xlabel('Falsa aceptaci�n')
ylabel('Falso rechazo')
axis([0 1 0 1])
title('Curvas de falsa aceptaci�n y falso rechazo')

% 4 - Dibujar la curva ROC (Receiver Operating Characteristics) y calcular
% el �rea bajo la curva (Area Under Curve: AUC)

subplot(2,2,4)
h = plot(FAR,1-FRR,'LineWidth',2);
grid on
xlabel('Falsa aceptaci�n')
ylabel('1 - Falso rechazo')
axis([0 1 0 1])
title('Curva ROC')

AUC = trapz(FAR,1-FRR);
fprintf('El �rea bajo la curva ROC (AUC) del sistema biom�trico es %1.5f\n',AUC);



