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
for i=10:length(type)
    for j=1:length(number)
        image = ['./manos/0',num2str(type(i)),'/mano',num2str(type(i)),'_',num2str(number(j)),'.jpg'];
        rawImages{k} = imread(image);
        k=k+1;
    end   
end

%% computing area and perimeters
%given an image compute area

image = imread('mano1_1.jpg');
cropped_im = image(150:end,:);

%threshold chose using Otsu's method
threshold = graythresh(cropped_im)*255; %times 255 for unit8 format

segmented_im = zeros(size(cropped_im));

for i=1:size(cropped_im,1)
   for j=1:size(cropped_im,2)
       if cropped_im(i,j) < threshold
            segmented_im(i,j) = 0;
       else
            segmented_im(i,j) = 255;
       end
   end
end

%choose the biggest connected blob
manoBella = keepMaxObj(logical(segmented_im));
areaMano = nnz(manoBella) %this count the number of non-zero elements in ManoBella (i.e. the area of the hand)


im_perimetral = edge(manoBella,'Canny',[]); %edge detection with canny algorithm
perimetro = nnz(im_perimetral)
