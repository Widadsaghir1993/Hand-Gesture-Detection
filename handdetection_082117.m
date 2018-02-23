  function detectedImg=handdetection_082117(frame);  
% tic; 
% frame=imread('ren1.jpg');
gray=rgb2gray(frame);
new=rgb2hsv(frame);

BWfinal2=new(:,:,1);
            facedetector=vision.CascadeObjectDetector('FrontalFaceCART');
            face_bbox=step(facedetector,  frame );
           if isempty(face_bbox)
%                imshow(gray); 
               detectedImg=[];
           else
            
            face_x1=ceil(face_bbox(1));
            face_x2=round(face_x1+face_bbox(3));
            face_y1=ceil(face_bbox(2));
            face_y2=round(face_y1+face_bbox(4));
            face_x=face_x1:1:face_x2;
            face_y=face_y1:1:face_y2;
a=numel(BWfinal2);
            [r c p]=size(BWfinal2);
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
            BWdfill =imfill(  im2bw(new_Image),'holes');
            BWdfill =imfill( BWdfill ,'holes');
       
            %Smoothen the Object
            seD = strel('disk',1);
            BWfinal = imerode(BWdfill,seD);
             s = regionprops(BWfinal,gray, 'Centroid','Area','BoundingBox','MeanIntensity');
         bw_area=[s.Area];
          bw_region=find([s.Area]>1000);
           k=numel(bw_region);
          for i=1:k; 
        
          
         center(i,:)=round(s(bw_region(i)).Centroid);
        
         
         
          end
           member_x=ismember(center(:,1),face_x);
       member_y=ismember(center(:,2),face_y);
       member_xy=member_x.* member_y;
           member_equal=vec2ind(compet( member_xy));
%         face_region=bw_region(2);
        
        bbox=s(bw_region(member_equal)).BoundingBox;
        face_meanvalue=s(bw_region(member_equal)).MeanIntensity;
          bw_meanvalue=[s(bw_region).MeanIntensity];
          bw_meanvalue(member_equal)=255;
          hand_meanvalue=negdist(face_meanvalue,bw_meanvalue);
          winner=vec2ind(compet(transpose(hand_meanvalue)));
         hand_bbox=s(bw_region( winner)).BoundingBox;
          
%           
   detectedImg=insertObjectAnnotation( gray,'rectangle', hand_bbox,'Hand');
%             x1=ceil(bbox(1));
%             x2=round(x1+bbox(3));
%             y1=ceil(bbox(2));
%             y2=round(y1+bbox(4));
%           BWfinal(y1:y2,x1:x2)=0;
%           ROI=uint8(BWfinal);
% %             ROI(BWfinal==255)=1;
% %             ROI(BWfinal~=255)=0;
%             hand_image=gray.*ROI;
%            figure(1);imshow(BWfinal2);
%            figure(2);imshow(detectedImg);
           end
          %toc;
end