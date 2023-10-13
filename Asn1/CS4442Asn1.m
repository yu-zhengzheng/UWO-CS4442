xtr = importdata("hw1xtr.dat",'\n',0);
ytr = importdata("hw1ytr.dat",'\n',0);
xte = importdata("hw1xte.dat",'\n',0);
yte = importdata("hw1yte.dat",'\n',0);


% subplot(1,2,1)
% scatter(xtr,ytr)
% title('Training Data')
% xlabel('x') 
% ylabel('y')
% axis([0 4 0 8])
% subplot(1,2,2)
% scatter(xte,yte)
% title('Test Data')
% xlabel('x') 
% ylabel('y')
% axis([0 4 0 8])

%NO two blocks of code below may be uncommented at the same or the code won't work

% %1st order
% xtr=[xtr,xtr./xtr]
% xte=[xte,xte./xte]
% w=((xtr'*xtr)^-1)*xtr'*ytr
% etr=xtr*w
% ete=xte*w
% subplot(1,2,1)
% hold on
% plot(xtr(:,1),etr)
% subplot(1,2,2)
% hold on
% plot(xte(:,1),ete)
% 
% sum((etr-ytr).^2)/size(etr,1)
% sum((ete-yte).^2)/size(ete,1)



% %2nd order
% xtr=[xtr,xtr.^2,xtr./xtr];
% xte=[xte,xte.^2,xte./xte];
% w=((xtr'*xtr)^-1)*xtr'*ytr
% 
% etr=xtr*w;
% ete=xte*w;
% sum((etr-ytr).^2)/size(etr,1)
% sum((ete-yte).^2)/size(ete,1)
% 
% xtr=sort(xtr);
% xte=sort(xte);
% etr=xtr*w;
% ete=xte*w;
% subplot(1,2,1)
% hold on
% plot(xtr(:,1),etr)
% subplot(1,2,2)
% hold on
% plot(xte(:,1),ete)



% %3rd order
% xtr=[xtr,xtr.^2,xtr.^3,xtr./xtr];
% xte=[xte,xte.^2,xte.^3,xte./xte];
% w=((xtr'*xtr)^-1)*xtr'*ytr
% 
% etr=xtr*w;
% ete=xte*w;
% sum((etr-ytr).^2)/size(etr,1)
% sum((ete-yte).^2)/size(ete,1)
% 
% xtr=sort(xtr);
% xte=sort(xte);
% etr=xtr*w;
% ete=xte*w;
% subplot(1,2,1)
% hold on
% plot(xtr(:,1),etr)
% subplot(1,2,2)
% hold on
% plot(xte(:,1),ete)



% %4th order
% xtr=[xtr,xtr.^2,xtr.^3,xtr.^4,xtr./xtr];
% xte=[xte,xte.^2,xte.^3,xte.^4,xte./xte];
% w=((xtr'*xtr)^-1)*xtr'*ytr
% 
% etr=xtr*w;
% ete=xte*w;
% sum((etr-ytr).^2)/size(etr,1)
% sum((ete-yte).^2)/size(ete,1)
% 
% xtr=sort(xtr);
% xte=sort(xte);
% etr=xtr*w;
% ete=xte*w;
% subplot(1,2,1)
% hold on
% plot(xtr(:,1),etr)
% subplot(1,2,2)
% hold on
% plot(xte(:,1),ete)



% %Regularization
% xtr=[xtr,xtr.^2,xtr.^3,xtr.^4,xtr./xtr];
% xte=[xte,xte.^2,xte.^3,xte.^4,xte./xte];
% 
% w=((xtr'*xtr+0.01.*eye(5))^-1)*xtr'*ytr;
% wm=w;
% etr=xtr*w;
% ete=xte*w;
% err(1,1)=sum((etr-ytr).^2)/size(etr,1);
% err(2,1)=sum((ete-yte).^2)/size(ete,1);
% 
% w=((xtr'*xtr+0.1.*eye(5))^-1)*xtr'*ytr;
% wm=[wm,w];
% etr=xtr*w;
% ete=xte*w;
% err(1,2)=sum((etr-ytr).^2)/size(etr,1);
% err(2,2)=sum((ete-yte).^2)/size(ete,1);
% 
% w=((xtr'*xtr+1.*eye(5))^-1)*xtr'*ytr;
% wm=[wm,w];
% etr=xtr*w;
% ete=xte*w;
% err(1,3)=sum((etr-ytr).^2)/size(etr,1);
% err(2,3)=sum((ete-yte).^2)/size(ete,1);
% 
% w=((xtr'*xtr+10.*eye(5))^-1)*xtr'*ytr;
% wm=[wm,w];
% etr=xtr*w;
% ete=xte*w;
% err(1,4)=sum((etr-ytr).^2)/size(etr,1);
% err(2,4)=sum((ete-yte).^2)/size(ete,1);
% 
% w=((xtr'*xtr+100.*eye(5))^-1)*xtr'*ytr;
% wm=[wm,w];
% etr=xtr*w;
% ete=xte*w;
% err(1,5)=sum((etr-ytr).^2)/size(etr,1);
% err(2,5)=sum((ete-yte).^2)/size(ete,1);
% 
% w=((xtr'*xtr+1000.*eye(5))^-1)*xtr'*ytr;
% wm=[wm,w];
% etr=xtr*w;
% ete=xte*w;
% err(1,6)=sum((etr-ytr).^2)/size(etr,1);
% err(2,6)=sum((ete-yte).^2)/size(ete,1);
% 
% 
% figure
% semilogx([0.01,0.1,1,10,100,1000],wm(5,:))
% hold on
% semilogx([0.01,0.1,1,10,100,1000],wm(1,:))
% hold on
% semilogx([0.01,0.1,1,10,100,1000],wm(2,:))
% hold on
% semilogx([0.01,0.1,1,10,100,1000],wm(3,:))
% hold on
% semilogx([0.01,0.1,1,10,100,1000],wm(4,:))
% legend("w0","w1","w2","w3","w4")
% 
% figure
% semilogx([0.01,0.1,1,10,100,1000],err(1,:),"Marker","o")
% hold on
% semilogx([0.01,0.1,1,10,100,1000],err(2,:),"Marker","o")
% legend("training error","test error")
% 
% figure
% scatter(xte(:,1),yte(:,1))
% title('Test Data')
% xlabel('x') 
% ylabel('y')
% axis([0 4 0 8])
% hold on
% xte=sort(xte);
% ete=xte*wm(:,1);
% plot(xte(:,1),ete)
% legend("test data","regression line")




