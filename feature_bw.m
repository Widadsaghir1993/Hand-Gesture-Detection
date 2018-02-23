tic;

for image_sample=1:26;
    
    load ('bw.mat','bw_image.area')
   
imagename=sprintf('feature_rgb_%d.jpg',image_sample);
image=imread(imagename);
% gray_image=rgb2gray(image);
gray_level=graythresh(image);       
bw_image1=im2bw(image,.65);
seg_image=imcomplement(bw_image1);
seg_image_holes=imfill(seg_image,'holes');
image_resize=imresize(seg_image_holes,[ 12 8]);
orig_image_resize=imresize(image,[ 12 8]);
filename=sprintf('feature_bw_%d.jpg',image_sample);

image_database(image_sample,:)=reshape(orig_image_resize,[1 96]);
 var_image=var(double(image_database),0,1)
  for a=1:96
      weighted_image(a)= var_image(a)/sum(var_image)
  end
% imwrite(image_resize,filename);
% %imshow(image_resize)
% s = regionprops(image_resize,orig_image_resize, {'Centroid','WeightedCentroid','Area','BoundingBox','Orientation','Eccentricity'});
% %  count=numel(bw_image.area)
% %      count=count+1
%       
% bw_image.area(image_sample,1)=s.Area;   
% bw_image.weightedarea(image_sample,1)=bw_image.area(image_sample,1)/96;
% bw_image.orientation(image_sample,1)=(s.Orientation+90)/180;
% bw_image.Eccentricity(image_sample,1)=s.Eccentricity/1;
% bw_image.WeightedCentroid(image_sample,1)=s.WeightedCentroid(1)/8;
% bw_image.WeightedCentroid(image_sample,2)=s.WeightedCentroid(2)/12;
% file='bw_image.mat'
% save (file,'bw_image','image_database')
end
toc
% 
% var_bw_image(1)=var(bw_image.weightedarea,0,1);
% var_bw_image(2)=var(bw_image.orientation,0,1);
% var_bw_image(3)=var(bw_image.Eccentricity,0,1);
% var_bw_image(4)=var(bw_image.WeightedCentroid(:,1),0,1);
% var_bw_image(5)=var(bw_image.WeightedCentroid(:,2),0,1);
% weighted(1)=var_bw_image(1)/sum(var_bw_image)
% weighted(2)=var_bw_image(2)/sum(var_bw_image)
% weighted(3)=var_bw_image(3)/sum(var_bw_image)
% weighted(4)=var_bw_image(4)/sum(var_bw_image)
% weighted(5)=var_bw_image(5)/sum(var_bw_image)
% 
% file='weighted.mat'
% save (file,'weighted')
% var_bw_image(1)=var(bw_image.WeightedCentroid(1).area,0,1)
% var_bw_image(1)=var(bw_image.WeightedCentroid(1).area,0,1)



toc
