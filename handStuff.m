clear all
close all
%% Loading the images
type = 1:9;
number = 1:10;
k=1;
l=1;
numUsers = 20;
rawImages = cell(numUsers,10);
for i=1:length(type)
    for j=1:length(number)
        image = ['../manos/00',num2str(type(i)),'/mano',num2str(type(i)),'_',num2str(number(j)),'.jpg'];
        rawImages{k,l} = imread(image);
        l=l+1;
    end 
    l=1;
    k=k+1;
end


k=1;
l=1;
type2 = 10:20;

for i=10:numUsers
    for j=1:length(number)
        image = ['../manos/0',num2str(type2(k)),'/mano',num2str(type2(k)),'_',num2str(number(j)),'.jpg'];
        rawImages{i,l} = imread(image);
        l=l+1;
    end 
    l=1;
    k=k+1;
end


%% computing perimeter and area with ad-hoc external function

perimeters = zeros(numUsers,10);
areas = zeros(numUsers,10);

for i=1:numUsers
    for k=1:10
        [area, per] = getAreaPerimeterHand(rawImages{i,k});
        areas(i,k) = area;
        perimeters(i,k) = per;
    end
end
   
%% estimate (modelo usuario)

modelo = zeros(numUsers,2); %numUser persone, 2 grandezze (prima media perimetro, dopo media area)

for i=1:numUsers
    modelo(i,1) = mean(areas(i,1:4));
    modelo(i,2) = mean(perimeters(i,1:4));
end

%% distanza da le mani validation set
genuineScore = zeros(numUsers,5);
%score genuine
for i=1:numUsers    
    j=1;
    for k=5:10
       genuineScore(i,j) = euclDist(modelo(i,:),[areas(i,j) perimeters(i,j)]);
       j=j+1;
    end
end

%% distanza da le mani score impostore

for i=1:numUsers %dell'utente i-esimo vero
    l=1;
    for k=1:numUsers %con l'impostore k-esimo stronzo
        for j=4:10 %1:10 usando tutte le immagini per l'impostore. Comunque usiamo 4:10
            if k~=i %fai il confronto solo se non � la stessa persona
                disp('diedje')
                impostorScore(i,l) = euclDist(modelo(i,:),[areas(k,j) perimeters(k,j)]); %confronta il modello del tizio vero (i) con i dati dell'impostore (k)
                l=l+1;
            end
        end
    end
end


