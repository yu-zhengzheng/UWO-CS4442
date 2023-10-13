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
net = alexnet
% See details of the architecture
net.Layers
%
alexclasses=net.Layers(25, 1).Classes;

%%
label=zeros(1,10000);
for i=1:10000
    % Read the image to classify
    im=squeeze(d1(i,:,:,:));
    im=imresize(im,[227,227]);
    %subplot(1,1,1);imshow(im)
    
    % Adjust size of the image
    %sz = net.Layers(1).InputSize
    %I = I(1:sz(1),1:sz(2),1:sz(3));
    % Classify the image using AlexNet
    label(i) = find(alexclasses==classify(net, im));
    % Show the image and the classification results
    % figure
    % imshow(I)
    % text(10,20,char(label),'Color','white')
end
