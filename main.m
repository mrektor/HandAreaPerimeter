% Inicialización
clear all;

%en frame.jpg se guarda cada uno de los frames de la webcam, los cuales
%serán analizados para detectar caras
dos('del frame.jpg');

vid = videoinput('winvideo',1,'RGB24_320x240'); %Formato de la cámara
vid.TimerPeriod = 0.01; %Parámetros de la cámara
vid.FramesPerTrigger = inf; %Parámetros de la cámara
start(vid); %Iniciar captura

coeficientes=10; %Número de coeficientes de la parametrización, coeficientes DCT por filas

%%%%%%%%%%%%%%%%%%%%%%
%%% Adquiero la cara 1
%%%%%%%%%%%%%%%%%%%%%%

%en result.jpg se guarda la cara segmentada por el algoritmo de
%Viola Jones, el cual ejecutaos más adelante
dos('del result.jpg');  %Borro cualquier imagen previa
flag=0; %Para para parar cuando se encuentre una cara
while(flag==0)
    frame=getsnapshot(vid); %Adquirir frame de la webcam
    flushdata(vid);    %Vaciar buffer de la webcam
    try
        imwrite(frame,'frame.jpg'); %Escribo en disco la imagen en la que aplicaré la detección
        dos('facedetect.exe'); %Ejecut la detección basada en Viola Jones cuyo resultado en caso de haber cara se guarda en result.jpg
    end
    imshow(frame)
    drawnow;
    try
        cara1=imread('result.jpg'); %Leo el resultado de la detección
        hold on
        imshow(cara1); %Muestro la cara detectada
        hold off
        flag=1;
    end
    
end


pause

%%%%%%%%%%%%%%%%%%%%%%
%%% Adquiero la cara 2
%%%%%%%%%%%%%%%%%%%%%%

%en result.jpg se guarda la cara segmentada por el algoritmo de
%Viola Jones, el cual ejecutaos más adelante
dos('del result.jpg');  %Borro cualquier imagen previa
flag=0; %Para para parar cuando se encuentre una cara
while(flag==0)
    frame=getsnapshot(vid); %Adquirir frame de la webcam
    flushdata(vid);    %Vaciar buffer de la webcam
    try
        imwrite(frame,'frame.jpg'); %Escribo en disco la imagen en la que aplicaré la detección
        dos('facedetect.exe'); %Ejecut la detección basada en Viola Jones cuyo resultado en caso de haber cara se guarda en result.jpg
    end
    
    
    imshow(frame)
    drawnow;
    try
        cara2=imread('result.jpg'); %Leo el resultado de la detección
        hold on
        imshow(cara2); %Muestro la cara detectada
        hold off
        flag=1;
    end
    
end
stop(vid)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calculo distancia entre caras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
gallery=imresize(cara1(:,:,1),[75 75]); %Nos quedamos con el plano R y se normaliza el tamaño
query=imresize(cara2(:,:,1),[75 75]); %Se normaliza el tamaño
                    
gallery_features=extraer_parametros(gallery,coeficientes); %Se extraen las características
query_features=extraer_parametros(query,coeficientes); %Se extraen las características
 

distancia=mean(abs(gallery_features(2:end)-query_features(2:end)));%MAD
fprintf(['Distancia=',num2str(distancia),' \n'])
 figure
subplot(211)
imshow(gallery)
title('Imagen almacenada en la base de datos');
subplot(212)
imshow(query)
title(['Distancia=',num2str(distancia)])
                  