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
image_database(:,:,image_sample)=image_resize;
imwrite(image_resize,filename);
%imshow(image_resize)
s = regionprops(image_resize,orig_image_resize, {'Centroid','WeightedCentroid','Area','BoundingBox','Orientation','Eccentricity'});
%  count=numel(bw_image.area)
%      count=count+1
      
bw_image.area(image_sample,1)=s.Area;   
bw_image.weightedarea(image_sample,1)=bw_image.area(image_sample,1)/96;

file='bw_image.mat'
save (file,'bw_image')
end
toc

% var_bw_image(1)=var(bw_image.WeightedCentroid(1).area,0,1)
% var_bw_image(1)=var(bw_image.WeightedCentroid(1).area,0,1)




