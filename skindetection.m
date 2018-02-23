function skin_image=skindetection(frame);        

            gray=rgb2gray(frame);
            new=rgb2hsv(frame);
          
            BWfinal2=new(:,:,1);
            a=numel(BWfinal2)
            [r c p]=size(BWfinal2)
            new_Image=zeros(r,c);
            new_Image2=zeros(r,c);
            for i=1:r;
                for j=1:c;
                    if (BWfinal2(i,j)<0.1)
                       
                        new_Image(i,j)=255;
                    elseif (BWfinal2(i,j)> 0.9)
                        new_Image(i,j)=255;
                         new_Image2(i,j)=255;
                    end
                end
            end
            
            %Fill Interior Gaps
            BWdfill =imfill(   new_Image,'holes');
            BWdfill =imfill( BWdfill ,'holes');
       
            %Smoothen the Object
            seD = strel('line',3,1);
            BWfinal = imerode(BWdfill,seD);
            ROI=BWfinal ;
            ROI(BWfinal==255)=1;
            ROI(BWfinal~=255)=0;
            skin_image=gray.*ROI;
end