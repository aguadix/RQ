clear; clc; 
// SEMI-2.sce 
// A + B => C
// Adiabático
// Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    V  = x(1)
    NA = x(2)
    NB = x(3)
    NC = x(4)
    VT = x(5)
    // Concentraciones y temperatura
    CA = NA/V
    CB = NB/V
    CC = NC/V
    T  = VT/V
    // Ecuación de Arrhenius
    k = 1E7*exp(-5000/T); // L/(mol*h)
    // Velocidad de reacción
    r = k*CA*CB
    // Caudal de alimentación    
    if t < tfin/2 then 
        F = FB;  // Semicontinuo
    else 
        F = 0;   // Discontinuo
    end
    // Balance de materia global
    // d(V*RHO) = F*RHO
    dVdt = F
    // Balance de materia para A
    dNAdt = -r*V
    // Balance de materia para B
    dNBdt = F*CB0 - r*V
    // Balance de materia para C
    dNCdt = r*V
    // Balance de energía
    // d(V*RHO*CP*T)dt = F*RHO*CP*TO - H*r*V
    dVTdt = F*T0 - H*r*V/(RHO*CP)
    // Derivadas
    dxdt(1) = dVdt
    dxdt(2) = dNAdt
    dxdt(3) = dNBdt
    dxdt(4) = dNCdt
    dxdt(5) = dVTdt
endfunction

// CONSTANTES
FB = 50; // L/h
CB0 = 1; // mol/L
T0 = 280; // K
RHO = 1000; // g/L
CP = 1; // cal/(g*K)
H = -8E4; // cal/mol

// CONDICIONES INICIALES
Vini = 500; // L
CAini = 1; // mol/L
NAini = Vini*CAini; NBini = 0; NCini = 0; // mol
Tini = 350; // K
xini = [Vini;NAini; NBini; NCini; Vini*Tini];

// TIEMPO
tfin = 20; dt = 0.01; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
V  = x(1,:); Vfin = V($)
NA = x(2,:); NAfin = NA($)
NB = x(3,:); NBfin = NB($)
NC = x(4,:); NCfin = NC($)
VT = x(5,:); T = VT./V; Tfin = T($)

// GRÁFICAS
scf(1); clf(1);
plot(t,V);
xgrid; xtitle('SEMI-2','t','V');

scf(2); clf(2);
plot(t,NA,t,NB,t,NC);
xgrid; xtitle('SEMI-2','t','NA(azul), NB(verde), NC(rojo)');

scf(3); clf(3);
plot(t,T,);
xgrid; xtitle('SEMI-2','t','T');

// Máximo y mínimo global
[Tmax,indexTmax] = max(T)
tTmax = t(indexTmax)
plot(tTmax,Tmax,'ro');
[Tmin,indexTmin] = min(T)
tTmin = t(indexTmin)
plot(tTmin,Tmin,'ro');

// Extremos
dT = diff(T);
indexTe = find(dT(1:$-1).*dT(2:$)<0) + 1;
tTe = t(indexTe)
Te = T(indexTe)
plot(tTe,Te,'rx');

// T0 => Tini-3 < T < Tini+3
T0interval = 273:0.1:300; // K

for i = 1:length(T0interval)
    T0 = T0interval(i);
    x = ode(xini,0,t,f);
    VT = x(5,:); T = VT./V; 
    Tmax(i) = max(T); Tmin(i) = min(T); 
end

scf(4); clf(4);
plot(T0interval,Tmax,'ro',T0interval,Tmin,'bo');
xgrid; xtitle('SEMI-2','T0','Tmax(rojo), Tmin(azul)');

DT = 3; // K
indexDT = find(Tmax < Tini+DT & Tmin > Tini-DT);
plot(T0interval(indexDT),Tmax(indexDT),'r.',T0interval(indexDT),Tmin(indexDT),'b.');
