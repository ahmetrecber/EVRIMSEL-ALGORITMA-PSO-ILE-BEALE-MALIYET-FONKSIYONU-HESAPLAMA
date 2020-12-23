clear
clc
warning off
    
x1min=-4.5;
x1max=4.5;
x2min=-4.5;
x2max=4.5;
R=1500; 
x1=x1min:(x1max-x1min)/R:x1max;
x2=x2min:(x2max-x2min)/R:x2max;
    
for j=1:length(x1)
    
    for i=1:length(x2)
        f(i)=((1.5-x1(j)+x1(j)*x2(i)).^2)+((2.25-x1(j)+x1(j)*x2(i).^2).^2)+((2.625-x1(j)+x1(j)*(x2(i).^3)).^2);
    end
        
    f_tot(j,:)=f;

end

figure(1)
meshc(x1,x2,f_tot);colorbar;set(gca,'FontSize',12);
xlabel('x_2','FontName','Times','FontSize',20,'FontAngle','italic');
set(get(gca,'xlabel'),'rotation',25,'VerticalAlignment','bottom');
ylabel('x_1','FontName','Times','FontSize',20,'FontAngle','italic');
set(get(gca,'ylabel'),'rotation',-25,'VerticalAlignment','bottom');
zlabel('f(X)','FontName','Times','FontSize',20,'FontAngle','italic');
title('Beale Fonksiyonu','FontName','Times','FontSize',24,'FontWeight','bold');

