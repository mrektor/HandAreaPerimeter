clear all
close all
%% Loading the images
type = 1:9;
number = 1:10;
k=1;
l=1;
rawImages = cell(9,10);
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

perimeters = zeros(9,10);
areas = zeros(9,10);

for i=1:9
    for k=1:10
        [area, per] = getAreaPerimeterHand(rawImages{i,k})
        areas(i,k) = area;
        perimeters(i,k) = per;
    end
end
   
%% score

score = zeros(9,2); %9 persone, 2 grandezze (prima media perimetro, dopo media area)

for i=1:9
    score(i,1) = mean(areas(i,1:4));
    score(i,2) = mean(perimeters(i,1:4));
end


