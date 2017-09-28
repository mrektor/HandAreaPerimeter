%Loading the images
type = 1:9;
number = 1:10;
k=1;
rawImages = cell(200,1);
for i=1:length(type)
    for j=1:length(number)
        image = ['./manos/00',num2str(type(i)),'/mano',num2str(type(i)),'_',num2str(number(j)),'.jpg'];
        rawImages{k} = imread(image);
        k=k+1;
    end   
end
type2 = 10:20; %qui ci potrebbe essere un probelma
for i=10:length(type2)
    for j=1:length(number)
        image = ['./manos/0',num2str(type2(i)),'/mano',num2str(type2(i)),'_',num2str(number(j)),'.jpg'];
        rawImages{k} = imread(image);
        k=k+1;
    end   
end
%%

perimeters = zeros(200,1);
areas = zeros(200,1);

for i=1:10
    [area, per] = getAreaPerimeterHand(rawImages{i})
    areas(i) = area;
    perimeters(i) = per;
end
    





