im=rgb2gray(imread("image1.jfif"));

%Compute gradient using sobel operator
sobel=fspecial('sobel');
Ix=filter2(-sobel',im)/256/8;
Iy=filter2(sobel,im)/256/8;

%Compute I
Ix2=Ix.^2;
Iy2=Iy.^2;
Ixy=Ix.*Iy;

%Smooth I
kernel=fspecial('gaussian',5,1); 
Ix2=filter2(kernel,Ix2);
Iy2=filter2(kernel,Iy2);
Ixy=filter2(kernel,Ixy);

%Compute Response
[sizex,sizey]=size(im);
for x=1:sizex
    for y=1:sizey
        M=[Ix2(x,y),Ixy(x,y);Ixy(x,y),Iy2(x,y)];
        response(x,y)=det(M)-0.06*(trace(M))^2;
    end
end

%Plotting
cnt=0;
for x=2:sizex-1
    for y=2:sizey-1
        if (response(x,y)>0.0001 && response(x,y)==max(max(response((x-1):(x+1),(y-1):(y+1)))))
            result(x,y)=1;
            cnt=cnt+1;
        end
    end
end
[x,y]=find(result==1);
imshow(im)
hold on
plot(y,x,'r.')