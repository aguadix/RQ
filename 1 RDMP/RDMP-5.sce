clear; clc;
// RDMP-5.sce
// A + B <=> C
// Adiabático

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    CC = x(3)
    T  = x(4)
    // Ecuación de Arrhenius
    kd = kd0*exp(-E/(R*T))
    // Ecuación de Van't Hoff
    Keq = Keq0*exp(-H/(R*T))
    // Velocidad de reacción
    r = kd*(CA*CB - CC/Keq)
    // Balance de materia para A
    // d(V*CA)dt = -r*V
    dCAdt = -r
    // Balance de materia para B
    // d(V*CB)dt = -r*V
    dCBdt = -r
    // Balance de materia para C
    // d(V*CC)dt =  r*V
    dCCdt = r
    // Balance de energía
    // d(V*RHO*CP*T)dt = -H*r*V
    dTdt  = -H*r/(RHO*CP) // Balance de energía
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
    dxdt(3) = dCCdt
    dxdt(4) = dTdt
endfunction

// CONSTANTES
H = -136400; // J/mol
RHO = 1150; // g/L
CP = 3.8; // J/(g*K)
kd0 = 1.75E8; // L/(mol*h)
E = 62350; // J/mol
Keq0 = 8.25E-22; // L/mol
R = 8.314; // J/(mol*K)

// CONDICIONES INICIALES
CAini = 1; CBini = 2; CCini = 0; // mol/L
Tini = 300; // K
xini = [CAini; CBini; CCini; Tini];

// TIEMPO
dt= 0.1;
for tfin = 100:100:5000
    t = 0:dt:tfin; // h

    // RESOLVER
    x = ode(xini,0,t,f);
    xfin = x(:,$)
    dxdtfin = f(tfin,xfin)
    Equilibrio = abs(dxdtfin ./ xfin) < 1E-5
    if Equilibrio then
        break
    end
end

CA = x(1,:); CAeq = CA($)
CB = x(2,:); CBeq = CB($)
CC = x(3,:); CCeq = CC($)
T  = x(4,:); Teq  = T($)
XA = 1 - CA/CAini; XAeq = XA($)

XAobj = 0.5;
indexXAobj = find(XA>XAobj,1);
tXAobj = t(indexXAobj)

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA,t,CB,t,CC); 
xgrid; xtitle('RDMP-5','t','CA(azul), CB(verde), CC(rojo)');

scf(2); clf(2); 
plot(t,T);
xgrid; xtitle('RDMP-5','t','T');

scf(3);  
plot(Tini,XAeq,'ro');
xgrid; xtitle('RDMP-5','Tini','XAeq');

scf(4);  
if XAeq > XAobj then
    plot(Tini,tXAobj,'ro');
end
xgrid; xtitle('RDMP-5','Tini','tXAobj');
