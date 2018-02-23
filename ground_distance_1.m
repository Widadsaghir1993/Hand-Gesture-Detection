
for image_sample=1;
    
%     load ('bw.mat','bw_image.area')
   
imagename=sprintf('feature_rgb_%d.jpg',image_sample);
image=imread(imagename);

a=imhist(image,1)
% weight=count/sum(count)

end