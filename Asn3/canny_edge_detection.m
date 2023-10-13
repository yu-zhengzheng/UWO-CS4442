im=rgb2gray(imread("image1.jfif"));
edge_map=canny(im,5,0.1,0.2);
imshow(edge_map)
function bw=canny(im,sigma,th,tl)
    v=sigma^2;
    for x=[-2:1:2]
        for y=[2:-1:-2]
            kernel(x+3,y+3)=-x/v*exp(-(x^2+y^2)/(2*v^2));
        end
    end

    imx=filter2(kernel,im)/256;
    imy=filter2(kernel',im)/256;

    m=sqrt(imx.^2+imy.^2);
    [sizex,sizey]=size(m);

    %Hysterisis Thresholding
    mbw=m>th;
%     subplot(2,3,3)
%     imshow(mbw)
%     title('>T high')

    %NMS x dir
    for y=1:sizey
            if(imx(1,y)<imx(2,y)) mbw(1,y)=0;
            end
    end
    for x=2:sizex-1
        for y=1:sizey
            if(imx(x,y)<imx(x-1,y)||imx(x,y)<imx(x+1,y)) mbw(x,y)=0;
            end
        end
    end
    for y=1:sizey
            if(imx(sizex,y)<imx(sizex-1,y)) mbw(sizex,y)=0;
            end
    end

    %NMS y dir
    for x=1:sizex
            if(imx(x,1)<imx(x,2)) mbw(x,1)=0;
            end
    end
    for x=1:sizex
        for y=2:sizey-1
            if(imx(x,y)<imx(x,y-1)||imx(x,y)<imx(x,y+1)) mbw(x,y)=0;
            end
        end
    end
    for x=1:sizex
            if(imx(x,sizey)<imx(x,sizey-1)) mbw(x,sizey)=0;
            end
    end
    
%     subplot(2,3,4)
%     imshow(mbw)
%     title("after NMS")



    for x=1:sizex
        for y=1:sizey
            if(mbw(x,y))
                if (x-1>0&&m(x-1,y)>tl) mbw(x-1,y)=1;
                end
                if (x+1<=sizex&&m(x+1,y)>tl) mbw(x+1,y)=1;
                end
                if (y-1>0&&m(x,y-1)>tl) mbw(x,y-1)=1;
                end
                if (y+1<=sizey&&m(x,y+1)>tl) mbw(x,y+1)=1;
                end
            end
        end
    end

    
    edge_map=edge(im,"canny",0.15);



%     subplot(2,3,1)
%     imshow(im);
%     subplot(2,3,2)
%     imshow(m)
%     title("Gradient")
% 
%     subplot(2,3,5)
%     imshow(mbw)
%     title("after collection")
%     subplot(2,3,6)

    bw=mbw;
end