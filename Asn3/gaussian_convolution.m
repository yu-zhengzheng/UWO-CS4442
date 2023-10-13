%Generatearbitary image
im=eye(16)*50;
im(2:15,2:15)=im(2:15,2:15)+[1:14]'*[1:14]
im=im/246;
% subplot(2,2,1)
% imshow(im)

hsize=5
sigma=5
%Generate 1-Dimensional Gaussian Filter
for x=[2:-1:-2]
        g1d(x+3)=exp(-x^2/(2*sigma^2))/(sigma*sqrt(2*pi));
end
gH=g1d/sum(g1d);
gV=gH';

%Generate 2-Dimensional Gaussian Filter
g2d=fspecial('gaussian',hsize,sigma)

%Compute convolution
%subplot(2,2,2)
im_sep_conv=filter2(gH,im)
%imshow(im_sep_conv)
%subplot(2,2,3)
im_sep_conv=filter2(gV,im_sep_conv)
%imshow(im_sep_conv)

%subplot(2,2,4)
im_conv=filter2(g2d,im)
%imshow(im_conv)

%Compare convlution
if(abs(im_conv-im_sep_conv)<exp(-30))
    disp("Gaussian convolution as a separable sequence of horizontal and vertical convolutions implemented correctly!")
end