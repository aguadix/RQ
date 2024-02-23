clear; clc;
// SCILAB-2.sce

// Constantes

A = 1; alpha = 0.5; omega = 2;

// Funciones

function y = f(t)
    y = A*exp(-alpha*t).*sin(omega*t);
endfunction

dt = 0.001; tfin = 10; t = 0:dt:tfin;
y = f(t);

// Gráficas
scf(1); clf(1);
plot(t,y);
xgrid; xlabel('t'); ylabel('y');

// Objetivos
yobj = 0.5;
indexyobj = find(y>yobj,1);
tyobj = t(indexyobj)
plot(tyobj,yobj,'b.');

ya = 0.1; yb = 0.2;
indexyayb = find(y>ya & y<yb);
tyayb = t(indexyayb);
yyayb = y(indexyayb); 
plot(tyayb,yyayb,'b.');

// Máximo y mínimo global
[ymax,indexymax] = max(y)
tymax = t(indexymax)
plot(tymax,ymax,'ro');

[ymin,indexymin] = min(y)
tymin = t(indexymin)
plot(tymin,ymin,'ro');

// Ceros
indexy0 = find(y(1:$-1).*y(2:$)<0) + 1;
ty0 = t(indexy0)
y0 = y(indexy0)
plot(ty0,y0,'bo');

// Extremos
dy = diff(y);
indexye = find(dy(1:$-1).*dy(2:$)<0) + 1;
tye = t(indexye)
ye = y(indexye)
plot(tye,ye,'rx');

// Puntos de inflexión
d2y = diff(y,2);
indexyi = find(d2y(1:$-1).*d2y(2:$)<0) + 1;
tyi = t(indexyi)
yi = y(indexyi)
plot(tyi,yi,'gx');

// Integral
ta = 0.5; indexta = find(t==ta);
tb = 2.5; indextb = find(t==tb);
indexI = indexta:indextb;
tI = t(indexI);
yI = y(indexI);
I = inttrap(tI,yI)

rectspos = [tI; yI;                  dt*ones(1,length(tI));  yI];
rectsneg = [tI; zeros(1,length(tI)); dt*ones(1,length(tI)); -yI];
fill = 10*ones(1,length(tI));
xrects(rectspos,fill);
xrects(rectsneg,fill);

// Derivada
t0 = 3;
y0 = y(t==t0)
plot(t0,y0,'m.')
dydt = dy/dt;
dydt0 = dydt(t==t0)
yt = y0 + dydt0*(t-t0);
plot(t,yt,'m--')

// Ejes
a1 = gca;
tlo = 0; tup = tfin; ylo = -1; yup = 1;
a1.data_bounds = [tlo,ylo;tup,yup];
