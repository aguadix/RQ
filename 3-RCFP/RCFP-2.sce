clear; clc; 
// RCFP-2.sce
// A + B => 2 B
// Isotermo
// Estado estacionario
// Recirculación 


// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdtau = f(tau,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    // Velocidad de reacción
    r = k*CA*CB
    // Balance de materia para A
    // RDMP: d(V*CA)dt = -r*V
    dCAdtau = -r
    // Balance de materia para B
    // RDMP: d(V*CB)dt = (-r + 2*r)*V
    dCBdtau = r   
    dxdtau(1) = dCAdtau
    dxdtau(2) = dCBdtau 
endfunction

// CONSTANTES
F =  5; // L/h
L =  12; // dm
D = 1; // dm
V = %pi/4*D^2*L // L
R = 0.1;
TAU = V/(F*(1+R))  // h
k = 1; // L/(mol·h)
CA0 = 2; // mol/L
CB0 = 0.01; // mol/L
x0 = [CA0;CB0];

// TIEMPO DE RESIDENCIA
N = 1000; tau = 0:TAU/N:TAU; // h
l = 0:L/N:L, // dm

// SOLUCIÓN SUPUESTA
CAsguess = 2; CBsguess = 0.01; // mol/L
xsguess = [CAsguess;CBsguess];

imax = 20;
tol = 1E-5;

for i = 1:imax
    
    i
    
    // Balance al mezclador
    // F*CA0 + F*R*CAsguess = F*(1+R)*CAe
    // F*CB0 + F*R*CBsguess = F*(1+R)*CBe
    // CAe = (CA0 + R*CAsguess)/(1+R)
    // CBe = (CB0 + R*CBsguess)/(1+R)
    xe = (x0 + R*xsguess)/(1+R);

    // RESOLVER
    x = ode(xe,0,tau,f);
    xs = x(:,$)
    
    err = abs(xs-xsguess);
    
    if err < tol then
        break
    else
        xsguess = xs;
    end

end

CA = x(1,:); CAs = xs(1)
CB = x(2,:); CBs = xs(2)

scf(1); clf(1);
plot(l,CA,l,CB);
xgrid; xlabel('l'); legend('CA','CB',-2,%f);

scf(2);
plot(R,CAs,'o');
xgrid; xlabel('R'); ylabel('CAs');
