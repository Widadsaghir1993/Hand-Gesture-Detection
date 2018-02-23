ix=1;
% kx=sprintf('feature_rgb_%s.jpg',ix);
imagex=imread('feature_rgb_a2.jpg');
[gxx gyx]=imgradientxy(imagex);
[gdx grx]=imgradient(gxx,gyx);
ax(ix,:)=reshape(grx,[1 numel(grx)]);
[countx(ix,:)  yx1(ix,:)]=hist(ax(ix,:),36);
for binx=1:36;
  weighted_anglex(ix,binx)=(countx(ix,binx))/sum(countx(ix,:));
end
% 
% end
for i=1:26
k=sprintf('feature_rgb_%d.jpg',i);
image=imread(k);
[gx gy]=imgradientxy(image);
[gd gr]=imgradient(gx,gy);
a(i,:)=reshape(gr,[1 numel(gr)]);
[count(i,:)  y1(i,:)]=hist(a(i,:),36);

for bin=1:36;
  weighted_angle(i,bin)=(count(i,bin))/sum(count(i,:));
end

end
for y_no=1:26;
   for x_no=1
y=count( y_no,:);
x1=countx(x_no,:);
distance=abs(y-x1);
weigthed_y=weighted_angle(y_no,:);
 weigthed_x=weighted_anglex(x_no,:);
EMD(y_no,x_no)=sum((weigthed_x.*distance)./weigthed_y);

    end
end
