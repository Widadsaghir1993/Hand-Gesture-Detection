% function [f, fval] = test(varargin)
tic;
for image_sample=1:26;
 imagename=sprintf('feature_rgb_%d.jpg',image_sample);
% Images
% if nargin == 0
    A = imread(imagename);
%     A=rgb2gray(A);
    B = imread('feature_rgb_a2.jpg');
%     B=rgb2gray(B);
% elseif nargin == 2
%     A = varargin{1};
%     B = varargin{2};
%     if ischar(A)
%         A = imread(A);
%     end;
%     if ischar(B)
%         B = imread(B);
%     end;
% end;

% Histograms
nbins = 10;
[ca ha] = imhist(A, nbins);
[cb hb] = imhist(B, nbins);

% Features
f1 = ha;
f2 = hb;

% Weights
w1 = ca / sum(ca);
w2 = cb / sum(cb);

% Earth Mover's Distance
[f, fval(image_sample)] = emd(f1, f2, w1, w2, @gdf);
end
toc
% % Results
% wtext = sprintf('fval = %f', fval);
% figure('Name', wtext);
% subplot(121);imshow(A);title('first image');
% subplot(122);imshow(B);title('second image');

% end