clear; clc;
// SCILAB-3.sce

// Gráficas

dt = 0.001; tfin = 10; t = 0:dt:tfin;
y = exp(-0.5*t).*sin(2*t);

scf(1); clf(1);
plot(t,y);
xgrid; xtitle('SCILAB-3','x','y');

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
plot(ty0,0,'bo');

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
