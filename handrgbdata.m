
frame=imread('ren3.jpg');
gray=rgb2gray(frame);

new=rgb2hsv(frame);
BWfinal2=new(:,:,1);
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
   
   s = regionprops(BWfinal,new(:,:,3), 'Centroid','Area','BoundingBox','MeanIntensity','PixelValues');
    bw_area=[s.Area]
    threshold_area=sum(bw_area)/13
    bw_region=find([s.Area]>threshold_area)
    sk=numel(bw_region)
%     rgb99_distribution=[];
    for k=1:sk;
%      load('rgb99_distribution.mat')  
%      bbox=s(bw_region).BoundingBox
%       detectedImg=insertObjectAnnotation( new(:,:,3),'rectangle',bbox,'Hand');
%   figure(k);imshow( detectedImg);
[count nbins]=imhist(s(bw_region(k)).PixelValues,16);
sum_count=sum(count);
rgb1_distribution(:,k)=count./sum_count;

    end
 load('rgb_distribution.mat','rgb_distribution')
 save('rgb1_distribution.mat','rgb1_distribution')
 correl=corr(rgb99_distribution,rgb_distribution)

 winner1=compet(correl)
 winner=vec2ind(winner1)
 winner_value=correl(winner)
 if winner_value<0.65
     bbox=[0 0 0 0]
      detectedImg=insertObjectAnnotation( frame,'rectangle',bbox,'Hand');
 else
 bbox=s( bw_region(winner)).BoundingBox
        detectedImg=insertObjectAnnotation( frame,'rectangle',bbox,'Hand');
 end
%   figure(k);imshow( detectedImg);
               figure(2);imshow(detectedImg);
