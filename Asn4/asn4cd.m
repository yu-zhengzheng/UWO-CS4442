d=[d1;d2;d3;d4;d5];

%%
%extract features
fc6ftr=zeros(40000,4096);
fc7ftr=zeros(40000,4096);
fc6fte=zeros(10000,4096);
fc7fte=zeros(10000,4096);
%training data
for i=1:40000
    im=squeeze(d(i,:,:,:));
    im=imresize(im,[227,227]);
    fc6ftr(i,:) = activations(net,im,'fc6','OutputAs','rows');
    fc7ftr(i,:) = activations(net,im,'fc7','OutputAs','rows');
end
%test data
for i=1:10000
    im=squeeze(d(40000+i,:,:,:));
    im=imresize(im,[227,227]);
    fc6fte(i,:) = activations(net,im,'fc6','OutputAs','rows');
    fc7fte(i,:) = activations(net,im,'fc7','OutputAs','rows');
end
%%
%linear clasifier