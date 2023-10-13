%%
%load data
load data_batch_1.mat
d1=permute(reshape(data,[10000,32,32,3]),[1,3,2,4]);
l1=labels;
load data_batch_2.mat
d2=permute(reshape(data,[10000,32,32,3]),[1,3,2,4]);
l2=labels;
load data_batch_3.mat
d3=permute(reshape(data,[10000,32,32,3]),[1,3,2,4]);
l3=labels;
load data_batch_4.mat
d4=permute(reshape(data,[10000,32,32,3]),[1,3,2,4]);
l4=labels;
load data_batch_5.mat
d5=permute(reshape(data,[10000,32,32,3]),[1,3,2,4]);
l5=labels;
load test_batch.mat
dt=permute(reshape(data,[10000,32,32,3]),[1,3,2,4]);
lt=labels;

clear data;clear labels;clear batch_label;

%%
% Access the trained model
net = alexnet;
alex_classes=net.Layers(25, 1).Classes;

%%
%classify the images
label1=zeros(10000,1);
for i=1:10000
    im=squeeze(d1(i,:,:,:));
    im=imresize(im,[227,227]);
    label1(i) = find(alex_classes==classify(net, im));
end
label2=zeros(10000,1);
for i=1:10000
    im=squeeze(d2(i,:,:,:));
    im=imresize(im,[227,227]);
    label2(i) = find(alex_classes==classify(net, im));
end
label3=zeros(10000,1);
for i=1:10000
    im=squeeze(d3(i,:,:,:));
    im=imresize(im,[227,227]);
    label3(i) = find(alex_classes==classify(net, im));
end
label4=zeros(10000,1);
for i=1:10000
    im=squeeze(d4(i,:,:,:));
    im=imresize(im,[227,227]);
    label4(i) = find(alex_classes==classify(net, im));
end
label5=zeros(10000,1);
for i=1:10000
    im=squeeze(d5(i,:,:,:));
    im=imresize(im,[227,227]);
    label5(i) = find(alex_classes==classify(net, im));
end
%conbine the labels
predicted_labels=[label1;label2;label3;label4;label5];
truth_labels=[l1;l2;l3;l4;l5];

%%
%find out the 10 most frequent labels
for i=1:1000
    frequency(i)=sum(predicted_labels==i);
end
for i=1:10
    [maxfreq(i),maxlabel(i)]=max(frequency);
    frequency(maxlabel(i))=frequency(maxlabel(i))-10000;
end


%%
%construct confusion matrix
confusion=zeros(10);
for i=1:10
    %index of images with predicted label 
    real_label_of_class=truth_labels(find(predicted_labels==maxlabel(i)));
    for j=1:10
        confusion(i,j)=sum(real_label_of_class==j-1);
    end
end

%normalize the confusion matrix
summation=sum(confusion);
for j=1:10
        confusion(:,j)=confusion(:,j)/summation(j);
end

%plot the confusion matrix
for i=1:10
    for j=1:10
        matrix((i-1)*10+1:i*10,(j-1)*10+1:j*10)=confusion(i,j);
    end
end
imshow(matrix)
colorbar
ten_class=["airplane" "automobile" "bird" "cat" "deer" "dog" "frog" "horse" "ship" "truck"];
for i=1:10
    text(-20,10*i-5,string(alex_classes(maxlabel(i))),'Color','red')
    text(10*i-8,105+mod(i,2)*5,string(ten_class(i)),'Color','red')
end