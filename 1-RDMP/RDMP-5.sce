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
    // r = rd - ri = kd*CA*CB - ki*CC = kd*CA*CB - kd*CC/Keq
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
dt = 0.1; tfin = 500; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($)
CC = x(3,:); CCfin = CC($)
T  = x(4,:); Tfin  = T($)
XA = 1 - CA/CAini; XAfin = XA($)

dTdt = diff(T)/dt;
dTdteq = 1E-3; // K/h
indexTeq = find(abs(dTdt)<dTdteq,1);
tTeq = t(indexTeq)
Teq = T(indexTeq)

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA,t,CB,t,CC); 
xgrid; xlabel('t'); legend('CA','CB','CC',-2,%f);

scf(2); clf(2); 
plot(t,T,'r-',tTeq,Teq,'r.');
xgrid; xlabel('t'); legend('T',-2,%f);

XATeq = XA(indexTeq)
XAobj = 0.5;
indexXAobj = find(XA>XAobj,1);
tXAobj = t(indexXAobj)

scf(3); clf(3); 
plot(t,XA,'m-',tTeq,XATeq,'m.',tXAobj,XAobj,'mo');
xgrid; xlabel('t'); legend('XA',-2,%f);

scf(4);
plot(Tini,XATeq,'mo');
xgrid; xlabel('Tini'); ylabel('XATeq');

scf(5);
plot(Tini,tXAobj,'go');
xgrid; xlabel('Tini'); ylabel('tXAobj');
