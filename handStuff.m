%given an image compute area

image = imread('mano1_1.jpg');
cropped_im = image(150:end,:);
threshold = graythresh(cropped_im)*255;

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

imshow(segmented_im)