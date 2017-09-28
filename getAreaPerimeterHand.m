function [area, perimeter] = getAreaPerimeterHand(image)
    %external function for computing area and perimeters
    
    %given an image compute area

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
    area = nnz(manoBella); %this count the number of non-zero elements in ManoBella (i.e. the area of the hand)


    im_perimetral = edge(manoBella,'Canny',[]); %edge detection with canny algorithm
    perimeter = nnz(im_perimetral);

end