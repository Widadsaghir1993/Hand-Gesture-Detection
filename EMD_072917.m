 NumberOfBin=36;
NumberTraningImage=26;
 %Filename=imread('feature_rgb_e2.jpg');
for i=1:NumberTraningImage
    
 Filename=sprintf('feature_rgb_%d.jpg',i);

 weighted_feature(i,:)=GradientTrainingImage(Filename,NumberOfBin);
 save('emd.mat','weighted_feature');
end
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
                     save('emd.mat','alpha','weighted_feature');