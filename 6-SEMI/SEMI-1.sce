clear; clc; 
// SEMI-1.sce 
// 1) A + B => P*
// 2) A + B => Q
// Isotermo
// Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    V  = x(1)
    NA = x(2)
    NB = x(3)
    NP = x(4)
    NQ = x(5)
    // Concentraciones
    CA = NA/V
    CB = NB/V
    CP = NP/V
    CQ = NQ/V
    // Velocidades de reacción    
    r1 = k1*CA*CB
    r2 = k2*CA*CB^2
    // Caudal de alimentación
    if t < tB then 
        F = FB;  // Semicontinuo
    else 
        F = 0;   // Discontinuo
    end
    // Balance de materia global
    // d(V*RHO) = F*RHO
    dVdt = F
    // Balance de materia para A    
    dNAdt = (-r1-r2)*V
    // Balance de materia para B    
    dNBdt= F*CB0 + (-r1-r2)*V
    // Balance de materia para P    
    dNPdt = r1*V
    // Balance de materia para Q    
    dNQdt = r2*V
    // Derivadas
    dxdt(1) = dVdt
    dxdt(2) = dNAdt
    dxdt(3) = dNBdt
    dxdt(4) = dNPdt
    dxdt(5) = dNQdt
endfunction

// CONSTANTES
k1 = 1; // L/(mol*min)
k2 = 2; // L2/(mol2*min)
VB = 1; // L
CB0 = 1; // mol/L

// CONDICIONES INICIALES
Vini = 0.5; // L
CAini = 2; // mol/L
NAini = Vini*CAini; NBini = 0; NPini = 0; NQini = 0; // mol
xini = [Vini;NAini; NBini; NPini; NQini];

// TIEMPO
tfin = 50; dt = 0.01; t = 0:dt:tfin; // min

// OPTIMIZAR tB para MAXIMIZAR NPfin
tBinterval = 0.5:0.5:50; // min

for i = 1:length(tBinterval)
    tB = tBinterval(i);
    FB = VB/tB; // L/min
    // RESOLVER
    x = ode(xini,0,t,f);
    NPfin(i) = x(4,$);
end

[NPfinmax,indexNPfinmax] = max(NPfin)
tBopt = tBinterval(indexNPfinmax)

// GRÁFICAS
scf(1); clf(1);
plot(tBinterval,NPfin,'ro');
plot(tBopt,NPfinmax,'x');
xgrid; xtitle('SEMI-1','tB','NPfin');

// DINÁMICA PARA tBopt
tB = tBopt;
FB = VB/tB;

// RESOLVER
x = ode(xini,0,t,f);
V =  x(1,:); Vfin = V($)
NA = x(2,:); NAfin = NA($)
NB = x(3,:); NBfin = NB($)
NP = x(4,:); NPfin = NP($)
NQ = x(5,:); NQfin = NQ($)

// GRÁFICAS
scf(2); clf(2);
plot(t,V);
xgrid; xtitle('SEMI-1','t','V');

scf(3); clf(3);
plot(t,NA,t,NB,t,NP,t,NQ);
xgrid; xtitle('SEMI-1','t','NA(azul), NB(verde), NP(rojo), NQ(cian)');
