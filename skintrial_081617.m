            
frame=imread('a11.jpg');
% gray=rgb2gray(frame);
% %             new=rgb2hsv(frame);
           colorTransform = makecform('srgb2lab');
            new = applycform(double(frame), colorTransform);
            BWfinal2=new(:,:,3);
%             a=numel(BWfinal2)
%             [r c p]=size(BWfinal2)
%              new_Image=zeros(r,c);
%             new_Image2=zeros(r,c);
%             for i=1:r;
%                 for j=1:c;
%                     if (BWfinal2(i,j)<0.1)
%                        
%                         new_Image(i,j)=255;
%                     elseif (BWfinal2(i,j)> 0.9)
%                         new_Image(i,j)=255;
%                          new_Image2(i,j)=255;
%                     end
%                 end
%             
%             
%             end
%             %Fill Interior Gaps
%             BWdfill =imfill(   new_Image,'holes');
%             BWdfill =imfill( BWdfill ,'holes');
%        
%             %Smoothen the Object
%             seD = strel('line',1,1);
%             BWfinal = imdilate(BWdfill,seD);
%             ROI=BWfinal ;
%             ROI(BWfinal==255)=1;
%             ROI(BWfinal~=255)=0;
%             skin_image=BWfinal2.*ROI;
            figure(2);imshow(new);