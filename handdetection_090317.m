function bbox=handdetection_090317(frame);
% tic;
% frame=imread('ren1.jpg');
%     load('rgb_distribution.mat');
%     facedetector=vision.CascadeObjectDetector('FrontalFaceCART');
% face_bbox=step(facedetector,  frame );
% if isempty(face_bbox)
% %                imshow(gray);
%                face_x=0:0;
%             face_y=0:0;
%            else
%
%             face_x1=ceil(face_bbox(1));
%             face_x2=round(face_x1+face_bbox(3));
%             face_y1=ceil(face_bbox(2));
%             face_y2=round(face_y1+face_bbox(4));
%             face_x=face_x1:1:face_x2;
%             face_y=face_y1:1:face_y2;
% end
% % gray=rgb2gray(frame);
new=rgb2hsv(frame);

BWfinal2=new(:,:,1);
a=numel(BWfinal2);
[r c p]=size(BWfinal2);
new_Image=zeros(r,c);
new_Image2=zeros(r,c);
for i=1:r;
    for j=1:c;
        if (BWfinal2(i,j)<0.1);
            
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

s = regionprops(BWfinal,new(:,:,3), 'Centroid','Area','BoundingBox','MeanIntensity','PixelValues');
bw_area=[s.Area];
threshold_area=sum(bw_area)/100;
bw_region=find([s.Area]>threshold_area);

sk=numel(bw_region);
%     rgb99_distribution=[];
load('handskincolor_distribution.mat','handskincolor_distribution')
for k=1:sk;
    %      load('rgb99_distribution.mat')
    %     center(k,:)=round(s(bw_region(k)).Centroid);
    %       detectedImg=insertObjectAnnotation( new(:,:,3),'rectangle',bbox,'Hand');
    %   figure(k);imshow( detectedImg);
    [count nbins]=imhist(s(bw_region(k)).PixelValues,8);
    sum_count=sum(count);
    rgb99_distribution(:,:,k)=count./sum_count;
    correl(k,:)=corr(handskincolor_distribution,rgb99_distribution(:,:,k));
    
end
%  member_x=ismember(center(:,1),face_x);
%        member_y=ismember(center(:,2),face_y);
%        member_xy=member_x.* member_y;
%        face_check=sum(member_xy);
%        if face_check>0
%            member_equal=vec2ind(compet( member_xy));
% % %  correl=corr(rgb99_distribution,rgb_distribution);
% max_value=mean(correl,2);
% max_value(member_equal)=0;
% % max_value=max_value1
%        else
max_value=mean(correl,2)
%        end
winner1=compet(max_value);
winner=vec2ind(winner1);
%  winner1=mode(winner1,2)
winner_value=correl(winner);
if winner_value<0.50;
    bbox=[0 0 0 0];
    %  detectedImg=insertObjectAnnotation( frame,'rectangle',bbox,'Hand');
else
    bbox=s( bw_region(winner)).BoundingBox;
    %   detectedImg=insertObjectAnnotation( frame,'rectangle',bbox,'Hand');
end


%toc;
end