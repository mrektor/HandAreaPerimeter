function [param] = extraer_parametros (imagen,coeficientes)

% modificacion 2
imagen=imadjust(imagen);
imagen=histeq(imagen);
%imagen(adapthisteq(imagen));

espectro=dct2(imagen);
% transfromada radon? A=radon(B);
% seguir la matriz en zigzag?
% utilizar varias caras de entrenamiento. elegir el m�ximo o media o m�nimo
% de distancia....


%Obtencion vector de parametros
for i=1:coeficientes
    test(coeficientes*(i-1)+1:coeficientes*i)=espectro(i,1:coeficientes);
end

test = zigzag(espectro)


param=test;