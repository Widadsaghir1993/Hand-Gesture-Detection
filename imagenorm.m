tic;
  ix=1
%   imagex=imread('feature_rgb_e2.jpg');
    imagex=imread('feature_rgb_e2.jpg');
    
%     Get the Gradient of Image%
    [gxx gyx]=imgradientxy(imagex);
    [gdx grx]=imgradient(gxx,gyx);% gd = gradient magnitude, gr = gradient angle
   
%     
%     Normalize the Gradient Magnitude%
    gd_maxx=max(max(gdx));
    gd_normx=gdx/(gd_maxx.*1.01);
    
   
    gr_signx=(abs(grx+.05))./(grx+.05);
    gradient_weightx=(gd_normx.*gr_signx)+grx;
    ax(ix,:)=reshape(gradient_weightx,[1 numel(gradient_weightx)]);% convert to column matrix
    [countx(ix,:)  y1x(ix,:)]=hist(ax(ix,:),36);
    gradient_valuex=abs(countx.*y1x);
    for binx=1:36;
        weighted_anglex(ix,binx)=( gradient_valuex(ix,binx))/sum( gradient_valuex(ix,:));
    end
    



for i=1:26
    k=sprintf('feature_rgb_%d.jpg',i);
    image=imread(k);
    
    %Get the Gradient of Image%
    [gx gy]=imgradientxy(image);
    [gd gr]=imgradient(gx,gy);% gd = gradient magnitude, gr = gradient angle
   
    
    %Normalize the Gradient Magnitude%
    gd_max=max(max(gd));
    gd_norm=gd/(gd_max.*1.01);
    
   
    gr_sign=(abs(gr+.05))./(gr+.05);
    gradient_weight=(gd_norm.*gr_sign)+gr;
    a(i,:)=reshape(gradient_weight,[1 numel(gradient_weight)]);% convert to column matrix
    [count(i,:)  y1(i,:)]=hist(a(i,:),36);
    gradient_value=abs(count.*y1);
    for bin=1:36;
        weighted_angle(i,bin)=( gradient_value(i,bin))/sum( gradient_value(i,:));
    end
    
end

for y_no=1:26;
    for x_no=1;
        y=gradient_value( y_no,:);
        x1=gradient_valuex(x_no,:);
        distance=abs(y-x1);
        weigthed_y=weighted_angle(y_no,:);
        weigthed_x=weighted_anglex(x_no,:);
        EMD(y_no,x_no)=(sum((weigthed_x.*distance)./weigthed_y))/1000;
        %
    end
end
toc;