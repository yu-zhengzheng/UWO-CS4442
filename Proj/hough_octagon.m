%import image
image=rgb2gray(imread("4.jpg"));
subplot(2,3,1)
imshow(image);title('Original Image');

%compute edge map
%using sobel kernel and a threshold of 0.12
edgemap=edge(image,'sobel',0.12,'nothinning');
subplot(2,3,2)
imshow(edgemap);title('Edge Map');

%hough transform
%using distance resolution of 1 and angle resoltion of 0.3deg, both are arbitarily chosen
[accumulator, thetaV, rhoV] = hough(edgemap,'rhoResolution', 1, 'thetaResolution', 0.3);






%THIS MARKS THE START OF OUR PROJECT
%----------------------------------------------------------------
%the angle that has stronger edges are more likely to be the angle of rotation of the octagon
%the sum of each column of the accumulator is the same (obviously) so squared values are used

%compute the sum of each column of the accumulator squared
sum_of_squared=zeros(1,600);
for i=1:600
    sum_of_squared(i)=sum(accumulator(:,i).*accumulator(:,i))/10000;%/10000 can be safely ignored
end
subplot(2,3,4)
plot(thetaV,sum_of_squared);title('Sum of Squares of Each \theta');xlabel('\theta');xlim([-90,90]);

%since the 4 sets of edges of an octagon differs by 45deg each, know the angle of 1 set gives the angle of the other 3 sets
%slice sum_of_squared into 4 slices and add them together
for i=1:150
   sum_of_squared(i)=sum_of_squared(i)+sum_of_squared(i+150)+sum_of_squared(i+300)+sum_of_squared(i+450);
end
subplot(2,3,5)
plot(thetaV(302:450),sum_of_squared(2:150));title('Stength of the Angle of Rotation');xlim([0,45])
%the theta of the max value is the most probable angle of rotation of the octagon
%important: due to rounding errorsin hough() there will be a spike at i=1
[~,angle]=max(sum_of_squared(2:150));
xlabel(join(["Most Probable Angle=",string(angle*0.3)]));

%finding peaks that's within +-10*0.3deg of angle
%this allows for detection of oactagons that are not normal to the camera in 3D-space
%the +-3deg threshold is arbitarily chosen
%first set of peaks
windowL=angle-10;
windowR=angle+10;
peak1=hough_portion_peaks(windowL,windowR,accumulator,thetaV,2);
%second set of peaks
windowL=windowL+150;%0.3deg*150=45deg
windowR=windowR+150;
peak2=hough_portion_peaks(windowL,windowR,accumulator,thetaV,2);
%third set of peaks
windowL=windowL+150;
windowR=windowR+150;
peak3=hough_portion_peaks(windowL,windowR,accumulator,thetaV,2);
%fourth set of peaks
windowL=windowL+150;
windowR=windowR+150;
peak4=hough_portion_peaks(windowL,windowR,accumulator,thetaV,2);

peaks=[peak1;peak2;peak3;peak4];

%finding noise that's misclassified as peaks
%the distance of the 2 peaks within each set should be similar 
%finding the distance of the 2 peaks within each set
distance(1)=abs(peak1(1,1)-peak1(2,1));
distance(2)=abs(peak2(1,1)-peak2(2,1));
distance(3)=abs(peak3(1,1)-peak3(2,1));
distance(4)=abs(peak4(1,1)-peak4(2,1));
%finding the anomaly
[value,set]=max(abs(distance-mean(distance)));

%the mean distance of the 3 sets excluding the anomaly will be used to find the 4th set
mean_distance=(sum(distance)-distance(set))/3;

windowL=angle-10+set*150-150;
windowR=angle+10+set*150-150;
%find 5 candidate peaks with similar theta to the anomaly set
peak_candidates=hough_portion_peaks(windowL,windowR,accumulator,thetaV,5);
%finding 2 peaks within the 5 candidates whose distance is closest to mean_distance
minimum_difference=mean_distance;
for i=1:4
    for j=i+1:5
        %compute the difference of the (distance of candidate i and j ) and mean_distance
        difference=abs(abs(peak_candidates(i,1)-peak_candidates(j,1))-mean_distance);
        %replace the anomaly set with i and j if the distance between i and j is closer to the mean_distance
        if  difference<minimum_difference 
            minimum_difference=difference;
            peaks(2*set-1,:)=peak_candidates(i,:);
            peaks(2*set,:)=peak_candidates(j,:);
        end 
    end
end
%----------------------------------------------------------------
%THIS MARKS THE START OF OUR PROJECT





%display the accumulator
subplot(2,3,3)
imshow(imadjust(mat2gray(accumulator)), 'XData', thetaV,'YData', rhoV);title('Accumulator and Peaks');daspect('auto');xlabel('\theta');ylabel('\rho');
%display the peaks on accumulator
hold on;plot(round(thetaV(peaks(:,2))), rhoV(peaks(:,1)), 's', 'color', 'red');hold off

%plotting the result
subplot(2,3,6)
imshow(image);title('Detected Octagon Edges');
%finding the lines corresponding to peaks
%FillGap is arbitarily chosen, not in the scope of this project
lines = houghlines(edgemap, thetaV, rhoV, peaks, 'FillGap', 10);
%draw the detected edges
hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1), xy(:,2), 'linewidth', 3, 'color', 'y')
end
hold off



%function that returns num peaks from a specific portion of the accumulator 
%L is the left theta index inclusive
%R is the right theta index inclusive
%H is the accumulator
function peaks=hough_portion_peaks(L,R,H,thetaV,num)
    accumulator=H;
    if L>=1&&R<=600
        accumulator(:,L:R)=accumulator(:,L:R)*10;
        %find peaks using houghpeaks function
        %Threshold is arbitarily chosen small number that can be safely ignored
        %NHoodsize is chosen by trial and error, and depends on the rho and theta resolution that can be ignored
        peaks = houghpeaks(accumulator,num,'Threshold',0.2*max(accumulator(:)),'NHoodsize',[51 71],'Theta',thetaV);
    end   
    %wrap around if the left side exceeds minimum
    if L<1
        L=L+600;
        accumulator(:,1:R)=accumulator(:,1:R)*10;
        accumulator(:,L:600)=accumulator(:,L:600)*10;
        peaks = houghpeaks(accumulator,num,'Threshold',0.2*max(accumulator(:)),'NHoodsize',[51 71],'Theta',thetaV);
    end 
    %wrap around if the right side exceeds maximum
    if R>600
        R=R-600;
        accumulator(:,1:R)=accumulator(:,1:R)*10;
        accumulator(:,L:600)=accumulator(:,L:600)*10;
        peaks = houghpeaks(accumulator,num,'Threshold',0.2*max(accumulator(:)),'NHoodsize',[51 71],'Theta',thetaV);
    end
end