i=2;
for ix=1:i
     kx=sprintf('bb%d.jpg',ix);
imagex=imread(kx);
new=rgb2gray(imagex);
value=new;
[gxx gyx]=imgradientxy(value);
[gdx grx]=imgradient(gxx,gyx);

 gdx_max=max(max(gdx));
 new_gdx=gdx./gdx_max;
 ax=reshape(new_gdx,[1 numel(new_gdx)]);
[countx(:,ix)  yx1(:,ix)]=hist(ax,16);
% % % gdxx=new_gdx;
% % % [count, nbin]=hist(gdx);
end
figure(2);imshow(new_gdx);