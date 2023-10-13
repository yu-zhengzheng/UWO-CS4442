%import data
raw_data = importdata("faces.dat",' ',0);

%transform data into 64*64*400 double image array
for i=[1:400]
    for j=[1:64]
        faces(:,j,i)=raw_data(i,(64*j-63):(64*j));
    end
end

%normalize and display the 200th image
figure
imshow((faces(:,:,200))/256)

%normalize and display the 100th image
figure
imshow(( (faces(:,:,100)-sum(faces,3)/400+256)/512 ))

raw_data=raw_data';%warning
%compute the mean
average=mean(raw_data,2);
%mean centering
mean_data=raw_data-average;
%compute covariance matrix
cov_mat=mean_data'*mean_data;
%eigen decomposition
[V,D]=eig((cov_mat)/400);
stem([1:400],flip(sum(D)))


PC=V*raw_data';
%transform data into 64*64*6 double image array
for i=[1:400]
    for j=[1:64]
        PCface(:,j,i)=PC(i,(64*j-63):(64*j));
    end
end
for i=[395:400] 
    %show eigenvector
    figure
    imshow((mean(mean(PCface(:,:,i)))-PCface(:,:,i))/512+0.5)
    title(i)
end


%reconstruct data into 64*64 double image
reconstructed=0;
for i=[1:10]
    reconstructed=reconstructed+V(:,i)*(V(:,i)'*raw_data');
end
for i=[1:64]
    reconstructed_image(:,i)=reconstructed(100,(64*i-63):(64*i));
end
figure
imshow(reconstructed_image/256)

reconstructed=0;
for i=[1:100]
    reconstructed=reconstructed+V(:,i)*(V(:,i)'*raw_data');
end
for i=[1:64]
    reconstructed_image(:,i)=reconstructed(100,(64*i-63):(64*i));
end
figure
imshow(reconstructed_image/256)

reconstructed=0;
for i=[1:200]
    reconstructed=reconstructed+V(:,i)*(V(:,i)'*raw_data');
end
for i=[1:64]
    reconstructed_image(:,i)=reconstructed(100,(64*i-63):(64*i));
end
figure
imshow(reconstructed_image/256)

reconstructed=0;
for i=[1:399]
    reconstructed=reconstructed+V(:,i)*(V(:,i)'*raw_data');
end
for i=[1:64]
    reconstructed_image(:,i)=reconstructed(100,(64*i-63):(64*i));
end
figure
imshow(reconstructed_image/256)