%% Simone Bertè
clear all;
close all;

level = 0.45;
%% LOAD IMAGES
% IMPORTANT: we need to put all the images in the same folder and not in 10
% differents folders 
srcFiles = dir('C:\Users\esmi\Desktop\LAS PALMAS\Aplicaciones tecnologicas en seguridad\manos\*.jpg');  % the folder in which ur images exists
Vecc = zeros(1,length(srcFiles)); %vector to load area and perimeter
for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\esmi\Desktop\LAS PALMAS\Aplicaciones tecnologicas en seguridad\manos\', srcFiles(i).name);
    I = imread(filename);
    %figure, imshow(I);
    BW = im2bw(I, level); %level = Threshold belongs to [0,1]
    %figure, imshow(BW);
    BW2 = edge(BW,'Canny'); %function to compute the perimeter
    %figure, imshow(BW2);
    total_area = bwarea(BW); % compute area
    total_perimeter = bwarea(BW2);
    Vecc(1,i,1) = total_area;
    Vecc(1,i,2) = total_perimeter;
end

%% COMPUTING MODELS 
Model = zeros(1,20,2);
a = 0; % count indicator
for j = 1 : 10 : 200
    a = a+1;
    for k = 1 : 4
        Model(1,a,1) = Model(1,a,1) + Vecc(1,j+k-1,1) ;
        Model(1,a,2) = Model(1,a,2) + Vecc(1,j+k-1,2) ;
    end
    Model(1,a,1) = Model(1,a,1) / 4; % average to obtain the final model
    Model(1,a,2) = Model(1,a,2) / 4;
end

%% SCORES  GENUINS AND IMPOSTORES
Genuin = zeros(1,120);
Impost = zeros(1,2280);
b = 0; % count indicator
c = 0; % count indicator
v = 0; % count indicator
for i = 1 : 10 : 200
    b  = b+1;
    for h = 5 : 10
        c = c+1;
        Genuin(1,c) = sqrt( (Model(1,b,1) - Vecc(1,i+h-1,1))^2 + (Model(1,b,2)-Vecc(1,i+h-1,2))^2 );
    end
end
for j = 1 : 20
    for d = 1 : 10 : 190
        for g = 5 : 10
            v = v+1;
            if (j*10-5 <= d+g-1 < j*10)
                Impost(1,v) = sqrt( (Model(1,j,1) - Vecc(1,d+g-1,1))^2 + (Model(1,j,2)-Vecc(1,d+g-1,2))^2 );
            end
        end
    end
end

%% HISTOGRAMM, FALSO RECHAZO Y FALSA ACCEPTACION
a = min(Genuin);
b = min(Impost);
c = max(Genuin);
d = max(Impost);

[H, x] = hist(Genuin,200);
H_eq = H / sum(H); % normalization
figure
title('Histograms')
pdf = bar(x, H_eq); % to compute the pdf
grid on
[H1, x1] = hist(Impost,200);
H_eq1 = H1 / sum(H1); % normalization
hold on
pdf1 = bar(x1, H_eq1, 'r');

[FA, z] = ecdf(H_eq); % to compute the comulative functio (integral of pdf)
[FR, z1] = ecdf(H_eq1);
figure, plot(FA)
grid on
title('Falsa Acceptaciòn')
xlabel('x')
ylabel('F(x)')
figure, plot(FR)
grid on
title('Falso Rechazo')
xlabel('x')
ylabel('F(x)')

xq = 1:0.25:10;
vq = interp1(FA,xq); % interpolation to obtain the same number of points between FA and FR
FA_1 = vq';
FA_2 = 1 - FA_1;
figure
plot(FA_2)
grid on
title('1 - Falsa Acceptaciòn Interpolated')

%% DET Y EER
figure 
plot(FA_2,FR);
grid on
title('Curve DET y EER')
xlabel('Falsa aceptaciòn')
ylabel('Falso rechazo')
hold on
x = 0:0.001:1;
y = 0:0.001:1;
hold on
plot(x,y,'g --')
x_EER = 0.2809; % intersection between the DET and the bisector
y_EER = 0.2809; % intersection between the DET and the bisector
plot(x_EER, y_EER, 'r-o')
legend('DET', 'Bisector', 'EER')














