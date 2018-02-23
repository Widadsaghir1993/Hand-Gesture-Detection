function  weighted_feature=GradientTrainingImage(Filename,NumberOfBin)
    %  for i=1:NumberTraningImage
%     for i=1:26
%     filename=Filename    
%     k=sprintf('feature_rgb_%d.jpg',i);
    image=imread(Filename);
    
    %Get the Gradient of Image%
    [gx gy]=imgradientxy( image);
    [gd gr]=imgradient(gx,gy);% gd = gradient magnitude, gr = gradient angle
   
    
    %Normalize the Gradient Magnitude%
    gd_max=max(max(gd));
    gd_norm=gd/(gd_max.*1.01);
    
   
    gr_sign=(abs(gr+.05))./(gr+.05);
    gradient_weight=(gd_norm.*gr_sign)+gr;
    a=reshape(gradient_weight,[1 numel(gradient_weight)]);% convert to column matrix
    [count  y1]=hist(a,36);
    gradient_feature=abs(count.*y1);
    gradient_feature2=sum( gradient_feature)
    for bin=1:NumberOfBin;
        weighted_feature(:,bin)= gradient_feature(:,bin);
    
    end
      end


% end