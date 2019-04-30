clear; clc;
// RCFP-5.sce
// A + B => 2 B
// Isotermo
// Recirculación
// Estado estacionario

CA0 = 2.0; CB0 = 0.0; // mol/L
x0 = [CA0;CB0]; 

k = 1; // L/(mol*h)
F = 5; // L/h 
Vtot = 10; //L
R = 0.1;

tautot = Vtot/(F*(1+R)); dtau = 0.01; 
tau = 0:dtau:tautot;

function dxdtau = f(tau,x)
    r = k*x(1)*x(2)
    dxdtau(1) = -r
    dxdtau(2) =  r
endfunction

// Sustitución sucesiva

itermax = 50;
tol = 1E-5;

CAsguess = 1; CBsguess = 1;
xsguess = [CAsguess;CBsguess];

for iter = 1:itermax

    iter

    // F*CA0 + F*R*CAsguess = F*(1+R)*CAe
    // F*CB0 + F*R*CBsguess = F*(1+R)*CBe
    xe = (x0+R*xsguess)/(1+R);

    x = ode(xe,0,tau,f);
    xs = x(:,$);

    err = abs(xs - xsguess)

    if err < tol then 
        break
    else
        xsguess = xs
    end

end

CA = x(1,:); CAs = CA($)
CB = x(2,:); CBs = CB($)

scf(1); clf(1);  
plot(tau,CA,tau,CB);
xgrid; xtitle('RCFP-5','tau','CA (azul), CB (verde)');

scf(2);  
plot(R,CAs,'ro');
xgrid; xtitle('RCFP-5','R','CAs');
