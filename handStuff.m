clear all
close all
%% Loading the images
type = 1:9;
number = 1:10;
k=1;
l=1;
numUsers = 9;
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
% 
% type2 = 10:20; %qui ci potrebbe essere un probelma
% for i=10:length(type2)
%     for j=1:length(number)
%         image = ['./manos/0',num2str(type2(i)),'/mano',num2str(type2(i)),'_',num2str(number(j)),'.jpg'];
%         rawImages{k} = imread(image);
%         k=k+1;
%     end   
% end

%% computing perimeter and area with ad-hoc external function

perimeters = zeros(numUsers,10);
areas = zeros(numUsers,10);

for i=1:numUsers
    for k=1:10
        [area, per] = getAreaPerimeterHand(rawImages{i,k})
        areas(i,k) = area;
        perimeters(i,k) = per;
    end
end
   
%% estimate (modelo usuario)

modelo = zeros(numUsers,2); %9 persone, 2 grandezze (prima media perimetro, dopo media area)

for i=1:9
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
k=1
i=1
j=1
l=1

for i=1:numUsers
    for k=1:numUsers
%         disp('k')
%         disp(k)
%         disp('i')
%         disp(i)
        for j=1:10
            if k~=i
                disp('diedje')
                impostorScore(k,l) = euclDist(modelo(k,:),[areas(i,j) perimeters(i,j)]);
                l=l+1;
            end
        end
    end
end


impostorScore




