clear; clc;
// RDMP-6.sce
// A <=> P
// Progresión óptima de temperatura

kd0 = 1.94E15; ki0 = 6.26E19; // h-1
Ed = 44500; Ei = 59500; // cal/mol
R = 1.987; // cal/(mol*K)

Tmin = 500; dT = 0.01; Tmax = 650; // K
T = Tmin:dT:Tmax;

kd = kd0*exp(-Ed./(R*T));
ki = ki0*exp(-Ei./(R*T));

CAini = 1; CPini = 0; IToptini = 0;
xini = [CAini; CPini; IToptini];

tfin = 10; dt = 1E-3; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
    r = kd*x(1) - ki*x(2)
    [rmax,index] = max(r)
    Topt = T(index)
    dxdt(1) = -rmax
    dxdt(2) =  rmax
    dxdt(3) = Topt
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CP = x(2,:); CPfin = CP($)

ITopt = x(3,:);
i = 1:length(t)-1; 
Topt(i) = (ITopt(i+1)-ITopt(i))/dt; 
Toptfin = Topt($)

XA = 1 - CA/CAini; XAfin = XA($)

XAobj = 0.85;
index1 = find(XA>XAobj,1);
tobj = t(index1)
Toptobj = Topt(index1)

index2 = find(Topt<Tmax-1E-6,1);
tTmax = t(index2)
XATmax = XA(index2)

scf(1); clf(1); 
plot(t,XA,tobj,XAobj,'ro',tTmax,XATmax,'ro');
xgrid; xtitle('RDMP-6','t','XA');

scf(2); clf(2); 
plot(t(1:$-1),Topt,tobj,Toptobj,'ro',tTmax,Tmax,'ro');
xgrid; xtitle('RDMP-6','t','Topt');