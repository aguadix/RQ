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
    dCAdt = -r
    // Balance de materia para B
    // RDMP: d(V*CB)dt = (-r + 2*r)*V
    dCBdt =  r
    // Derivadas
    dxdtau(1) = dCAdt
    dxdtau(2) = dCBdt
endfunction

// CONSTANTES
k = 1; // L/(mol*h)
F = 5; // L/h 
L = 12; // dm
D = 1; // dm
V = %pi/4*D^2*L //L
R = 0.1;
TAU = V/(F*(1+R)) // h
CA0 = 2; CB0 = 0.01; x0 = [CA0;CB0]; // mol/L

// TIEMPO DE RESIDENCIA
tau = 0:TAU/1000:TAU; // h
l = 0:L/1000:L; // dm

// Método del punto fijo

// SOLUCIÓN SUPUESTA
CAsguess = 2; CBsguess = 0.01; xsguess = [CAsguess;CBsguess]; // mol/l

imax = 50;
tol = 1E-5;

for i = 1:imax
    
    i
    
    // ENTRADA
    // F*CA0 + F*R*CAsguess = F*(1+R)*CAe
    // F*CB0 + F*R*CBsguess = F*(1+R)*CBe
    // CAe = (CA0 + R*CAsguess)/(1+R)
    // CBe = (CB0 + R*CBsguess)/(1+R)
    xe = (x0 + R*xsguess)/(1+R);
    
    // RESOLVER
    x = ode(xe,0,tau,f);
    xs = x(:,$)

    err = abs(xs - xsguess);

    if err < tol then 
        break
    else
        xsguess = xs;
    end

end

i
CAs = xs(1)    
CBs = xs(2)    
    
scf(1);  
plot(R,CAs,'ro');
xgrid; xtitle('RCFP-2','R','CAs');
