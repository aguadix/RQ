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
    if t < tfin/2 then F = FB;
       else F = 0;
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
    // Derivdas
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
NAini = 500; NBini = 0; NCini = 0; // mol
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
VT = x(5,:);
T = VT./V; Tfin = T($)

[Tmax,indexTmax] = max(T)
tTmax = t(indexTmax)

[Tmin,indexTmin] = min(T)
tTmin = t(indexTmin)

// GRÁFICAS
scf(1); clf(1);
plot(t,V);
xgrid; xtitle('SEMI-2','t','V');

scf(2); clf(2);
plot(t,NA,t,NB,t,NC);
xgrid; xtitle('SEMI-2','t','NA(azul), NB(verde), NC(rojo)');

scf(3); clf(3);
plot(t,T,tTmax,Tmax,'ro',tTmin,Tmin,'ro');
xgrid; xtitle('SEMI-2','t','T');

Tmaxtest = Tmax < Tini+3
Tmintest = Tmin > Tini-3

scf(4);
if Tmaxtest & Tmintest then
    plot([T0,T0],[Tmin,Tmax],'go-');
else
    plot([T0,T0],[Tmin,Tmax],'ro-');
end
xgrid; xtitle('SEMI-2','T0','Tmin-Tmax');
