function winner_letter=test_emd(bw_image1);
% load('bw_image.mat')
%    
% 
% load('weighted.mat')
% tic;
% %    
% % imagename=sprintf('feature_rgb_%d.jpg',a2);
% image=imread('feature_rgb_2.jpg');
% % gray_image=rgb2gray(image);
% gray_level=graythresh(image);       
bw_image1=im2bw(image,.65);
seg_image=imcomplement(bw_image1);
seg_image_holes=imfill(seg_image,'holes');
orig_image_resize=imresize(image,[ 12 8]);
image_resize=imresize(seg_image_holes,[ 12 8]);
 input_image=reshape(image_resize,[96 1]);
% count=numel(image_database)/96
s1 = regionprops(image_resize,orig_image_resize, {'Centroid'});
s2 = regionprops(image_resize,orig_image_resize, {'WeightedCentroid'});
s3 = regionprops(image_resize,orig_image_resize, {'Area'});
s4 = regionprops(image_resize,orig_image_resize, {'BoundingBox'});
s5 = regionprops(image_resize,orig_image_resize, {'Orientation',});
s6 = regionprops(image_resize,orig_image_resize, {'Eccentricity'});

%  count=numel(bw_image.area)
%      count=count+1
      
input_image_Area = s3.Area ;   
input_image_weightedarea=input_image_Area/96;
input_image_orientation=(s.Orientation+90)/180;
input_image_Eccentricity=s.Eccentricity/1;
input_image_WeightedCentroid(1)=s.WeightedCentroid(1)/8;
input_image_WeightedCentroid(2)=s.WeightedCentroid(2)/8;
     
%      ground_dis_area=-(negdist(bw_image.area,input_image_Area))
     ground_dis_weightedarea=-(negdist(bw_image.weightedarea,input_image_weightedarea));
     ground_dis_orientation=-(negdist(bw_image.orientation,input_image_orientation));
      ground_dis_Eccentricity=-(negdist(bw_image.Eccentricity,input_image_Eccentricity));
      wx=bw_image.WeightedCentroid(:,1);
      ground_dis_WeightedCentroidx=-(negdist( wx,input_image_WeightedCentroid(1)));
       wy=bw_image.WeightedCentroid(:,2);
      ground_dis_WeightedCentroidy=-(negdist( wy,input_image_WeightedCentroid(2)));
     for a=1:26 
     emd(a)=weighted(1).* ground_dis_weightedarea(a) + weighted(2).*ground_dis_orientation(a) + weighted(3).*ground_dis_Eccentricity(a)+ weighted(4).*ground_dis_WeightedCentroidy(a)+ weighted(5).*ground_dis_WeightedCentroidx(a);
     end
      win=transpose(emd);
                    winner1=compet(win)
                    winner=vec2ind(winner1);
                    alpha(1,1)='a';
                    alpha(2,1)='b';
                    alpha(3,1)='c';
                    alpha(4,1)='d';
                    alpha(5,1)='e';
                    alpha(6,1)='f';
                    alpha(7,1)='g';
                    alpha(8,1)='h';
                    alpha(9,1)='i';
                    alpha(10,1)='j';
                    alpha(11,1)='k';
                    alpha(12,1)='l';
                    alpha(13,1)='m';
                    alpha(14,1)='n';
                    alpha(15,1)='o';
                    alpha(16,1)='p';
                    alpha(17,1)='q';
                    alpha(18,1)='r';
                    alpha(19,1)='s';
                    alpha(20,1)='t';
                    alpha(21,1)='u';
                     alpha(22,1)='v';
                    alpha(23,1)='w';
                    alpha(24,1)='x';
                    alpha(25,1)='y';
                    alpha(26,1)='z';
                    winner_letter=alpha(winner);
end


% imshow(image_resize)