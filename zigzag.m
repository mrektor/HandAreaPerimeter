function v = zigzag(matrix)


    t = 0; %auxiliary index for v
    matrDim = size(matrix);
    numElements = matrDim(2)*matrDim(1);  %calculating the M*N
    v = zeros(numElements,1); %init v

    for d=2:numElements
     c=rem(d,2);  %checking whether d is even or odd
        for i=1:matrDim(1)
            for j=1:matrDim(2)
                if((i+j)==d)
                    t=t+1;
                    if(c==0)
                        v(t)=matrix(j,d-j);
                    else          
                        v(t)=matrix(d-j,j);
                    end
                 end    
             end
         end
    end
end