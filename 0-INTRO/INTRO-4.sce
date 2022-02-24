clear; clc; 
// INTRO-4.sce
// CAMPO VECTORIAL DE UN SISTEMA DE ECUACIONES DIFERENCIALES DE 2 VARIABLES

function dxdt = f(t,x)
    dxdt(1) = -2*x(1) +   x(2)
    dxdt(2) =    x(1) - 4*x(2)
endfunction

// Intervalo de prueba
x1min = -10; x1max = 10; x1interval = x1min:x1max;
x2min = -10; x2max = 10; x2interval = x2min:x2max;

scf(1); clf(1);

// Líneas de pendiente nula
// dxdt(1) = -2*x(1) +   x(2) = 0
plot(x1interval,2*x1interval,'r-');
// dxdt(2) =    x(1) - 4*x(2) = 0
plot(x1interval,x1interval/4,'r--');
a1 = gca;
a1.x_location = 'origin';
a1.y_location = 'origin';
a1.isoview    = 'on';
a1.data_bounds = [x1min,x2min ; x1max,x2max];
a1.box = 'off';

// Punto de prueba
x = [5;5];
dxdt = f(0,x)
r = 0.025//0.025;
plot([x(1),x(1)+dxdt(1)*r],[x(2),x(2)+dxdt(2)*r]);
plot(x(1)+dxdt(1)*r,x(2)+dxdt(2)*r ,'o')

// Campo completo
for i = 1:length(x1interval)
  for j = 1:length(x2interval)
    x = [x1interval(i);x2interval(j)];
    dxdt = f(0,x);
    plot([x(1),x(1)+dxdt(1)*r],[x(2),x(2)+dxdt(2)*r],'k-');
    plot(x(1)+dxdt(1)*r,x(2)+dxdt(2)*r ,'ko')
  end
end  

// Trayectoria
tfin = 10; dt = 0.1; t = 0:dt:tfin;
xini = [10;10];
x = ode(xini,0,t,f);
plot(x(1,:),x(2,:),'o-');

// Función de Scilab: fchamp
fchamp(f, 0, x1interval, x2interval); 
