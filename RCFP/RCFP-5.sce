clear; clc;
// RCFP-5
// A + B => 2 B
// Isotermo
// Recirculación
// Estado estacionario

k = 1; // L/(mol*h)
F = 5; // L/h 
CA0 = 2.0; CB0 = 0.0; // mol/L
V = 10; //L
R = 0.1;

tautot = V/(F*(1+R)); dtau = 0.01; 
tau = 0:dtau:tautot;

function dxdtau = f(tau,x)
    // RDMP
    // dCA/dt = -CAini*dx/dt = -k*CA*CB =
    //        = -k*(CAini-CAini*x)*(CBini+CAini*x)
    // dx/dt = k*(1-x)*(CBini+CAini*x)
    dxdtau = k*(1-x)*(CB0+CA0*x)    
endfunction

// Sustitución sucesiva

XAsguess = 0.5;
itermax = 50;
tol = 1E-5;

for iter = 1:itermax
// F*CA0 + F*R*CAsguess = F*(1+R)*CAe
// 1 + R*CAsguess/CA0 = (1+R)*CAe/CA0
// 1 + R*(1-XAsguess) = (1+R)*(1-XAe)
// 1 + R - R*XAsguess = 1 - XAe + R - R*XAe
// -R*XAsguess = -XAe - R*XAe
    XAe = R*XAsguess/(1+R);
    XA = ode(XAe,0,tau,f);
    XAs = XA($)
    err = abs(XAs - XAsguess);
    if err < tol then 
        break
    else
        XAsguess = XAs;
    end
end

scf(1); clf(1);  
plot(tau,XA)
xgrid; xtitle('RCFP-5','tau','XA');

scf(2);  
plot(R,XAs,'ro')
xgrid; xtitle('RCFP-5','R','XAs');
