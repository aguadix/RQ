clear; clc;
// INTRO-4.sce
// CAMPO VECTORIAL DE UN SISTEMA DE ECUACIONES DIFERENCIALES DE 2 VARIABLES

function dxdt = f(t,x)
    dxdt(1) = -2*x(1) +   x(2)
    dxdt(2) =    x(1) - 4*x(2)
endfunction


scf(1); clf(1);

x1min = -10; x1max = 10; x1interval = x1min:x1max;
x2min = -10; x2max = 10; x2interval = x2min:x2max;
r = 0.025;


x = [5;1];
dxdt = f(0,x)
plot([x(1),x(1)+dxdt(1)*r],[x(2),x(2)+dxdt(2)*r]);
plot(x(1)+dxdt(1)*r,x(2)+dxdt(2)*r ,'o')

a = gca();
a.x_location = "origin";
a.y_location = "origin";
a.isoview    = "on";
a.data_bounds = [x1min,x2min ; x1max,x2max];



for i = 1:length(x1interval)
  for j = 1:length(x2interval)
    x = [x1interval(i);x2interval(j)];
    dxdt = f(0,x);
    plot([x1interval(i),x1interval(i)+dxdt(1)*r],[x2interval(j),x2interval(j)+dxdt(2)*r],'k');
    plot(x1interval(i)+dxdt(1)*r,x2interval(j)+dxdt(2)*r,'ko')
  end
end  

scf(2); clf(2);
fchamp(f, 0, x1interval, x2interval);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
a.isoview    = "on";
a.data_bounds = [x1min,x2min ; x1max,x2max];


// TRAYECTORIA
tfin = 10; dt = 0.1; t = 0:dt:tfin;
xini = [10;10];
x = ode(xini,0,t,f);
scf(1); plot(x(1,:),x(2,:),'o-');
scf(2); plot(x(1,:),x(2,:),'o-');

