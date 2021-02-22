clear; clc;
// SCILAB-3.sce

// Gráficas

t = 0:0.01:10;
y = exp(-0.5*t).*sin(2*t);

scf(1); clf(1);
plot(t,y);
xgrid; xtitle('SCILAB-3','x','y');

[ymax,indexymax] = max(y)
tymax = t(indexymax)
plot(tymax,ymax,'go');

[ymin,indexymin] = min(y)
tymin = t(indexymin)
plot(tymin,ymin,'ro');

yobj = 0.5;
indexyobj = find(y>yobj,1);
tyobj = t(indexyobj)
yyobj = y(indexyobj) 
plot(tyobj,yyobj,'bo');

ya = 0.1; yb = 0.2;
indexyayb = find(y>ya & y<yb);
tyayb = t(indexyayb);
yyayb = y(indexyayb); 
plot(tyayb,yyayb,'b.');
