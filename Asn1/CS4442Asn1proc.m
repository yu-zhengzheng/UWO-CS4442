xtr_raw = importdata("hw1xtr.dat",'\n',0);
ytr_raw = importdata("hw1ytr.dat",'\n',0);


xtr1=xtr_raw(1:8);
xtr2=xtr_raw(9:16);
xtr3=xtr_raw(17:24);
xtr4=xtr_raw(25:32);
xtr5=xtr_raw(33:40);

ytr1=ytr_raw(1:8);
ytr2=ytr_raw(9:16);
ytr3=ytr_raw(17:24);
ytr4=ytr_raw(25:32);
ytr5=ytr_raw(33:40);

J=[0,0,0,0,0,0];

for i=[-2:3]
    lambda=10.^i;
    
    xtr=[xtr1;xtr2;xtr3;xtr4];
    xte=xtr5;
    ytr=[ytr1;ytr2;ytr3;ytr4];
    yte=ytr5;
    xtr=[xtr,xtr.^2,xtr.^3,xtr.^4,xtr./xtr];
    xte=[xte,xte.^2,xte.^3,xte.^4,xte./xte];
    w=((xtr'*xtr+lambda.*eye(5))^-1)*xtr'*ytr;
    wm=w;
    ete=xte*w;
    err(1)=sum((ete-yte).^2)/size(ete,1);
    
    xtr=[xtr1;xtr2;xtr3;xtr5];
    xte=xtr4;
    ytr=[ytr1;ytr2;ytr3;ytr5];
    yte=ytr4;
    xtr=[xtr,xtr.^2,xtr.^3,xtr.^4,xtr./xtr];
    xte=[xte,xte.^2,xte.^3,xte.^4,xte./xte];
    w=((xtr'*xtr+lambda.*eye(5))^-1)*xtr'*ytr;
    wm=w;
    ete=xte*w;
    err(2)=sum((ete-yte).^2)/size(ete,1);
    
    xtr=[xtr1;xtr2;xtr4;xtr5];
    xte=xtr3;
    ytr=[ytr1;ytr2;ytr4;ytr5];
    yte=ytr3;
    xtr=[xtr,xtr.^2,xtr.^3,xtr.^4,xtr./xtr];
    xte=[xte,xte.^2,xte.^3,xte.^4,xte./xte];
    w=((xtr'*xtr+lambda.*eye(5))^-1)*xtr'*ytr;
    wm=w;
    ete=xte*w;
    err(3)=sum((ete-yte).^2)/size(ete,1);
    
    xtr=[xtr1;xtr3;xtr4;xtr5];
    xte=xtr2;
    ytr=[ytr1;ytr3;ytr4;ytr5];
    yte=ytr2;
    xtr=[xtr,xtr.^2,xtr.^3,xtr.^4,xtr./xtr];
    xte=[xte,xte.^2,xte.^3,xte.^4,xte./xte];
    w=((xtr'*xtr+lambda.*eye(5))^-1)*xtr'*ytr;
    wm=w;
    ete=xte*w;
    err(4)=sum((ete-yte).^2)/size(ete,1);
    
    xtr=[xtr2;xtr3;xtr4;xtr5];
    xte=xtr1;
    ytr=[ytr2;ytr3;ytr4;ytr5];
    yte=ytr1;
    xtr=[xtr,xtr.^2,xtr.^3,xtr.^4,xtr./xtr];
    xte=[xte,xte.^2,xte.^3,xte.^4,xte./xte];
    w=((xtr'*xtr+lambda.*eye(5))^-1)*xtr'*ytr;
    wm=w;
    ete=xte*w;
    err(5)=sum((ete-yte).^2)/size(ete,1);

    J(i+3)=sum(err)/5;
end

semilogx([0.01,0.1,1,10,100,1000],J,"Marker","o")