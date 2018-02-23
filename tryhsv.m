imagex=imread('a11.jpg');
new=rgb2hsv(imagex);
BWfinal2=new(:,:,1);
a=numel(BWfinal2)
[r c p]=size(BWfinal2)
new_Image=zeros(r,c);
for i=1:r;
    for j=1:c;
        if (BWfinal2(i,j)<0.1)
            %         if ( (BWfinal2(i,j)>0.9) && (BWfinal2(i,j)<0.1 ))
            new_Image(i,j)=255;
        elseif (BWfinal2(i,j)> 0.9)
            new_Image(i,j)=255;
        end
    end
end

% figure(1);imhist(BWfinal2);
% figure(2);imshow( new_Image);