clear; clc;
// SCILAB-1.sce

// Escalares
a = 2
b = 3;

c = a+b
c = a*b, c = a^b
c = sqrt(2*a+7*b), c = exp(2), c = log(a), c = log10(5*a)

// Vectores
v = [1; 3; 5; -1; 1; -3; 4; 2; -2]
v = [1, 3, 5, -1, 1, -3, 4, 2, -2]
v = [1 3 5 -1 1 -3 4 2 -2]

vt = v'
v2 = v(2)
v(3) = 6
vf = v($)
v24 = v(2:4)
vpar = v(2:2:$)
v($+1) = 1
vi = 0; index = 7; v = [v(1:index-1),vi,v(index:$)]
vrev = v($:-1:1)

vlength = length(v) 

vmax = max(v)
[vmax,indexvmax] = max(v)

vmin = min(v)
[vmin,indexvmin] = min(v)

index1 = find(v==1)
v1 = v(index1)

indexneg = find(v<0)
vneg = v(indexneg)

index03 = find(v>0 & v<3)
v03 = v(index03)

vsum = sum(v)
vprod = prod(v)

dv = diff(v)
d2v = diff(v,2)

// Matrices
A = [4 -2  6 
     1  8 -1 
     0 -3  5]

At = A'
A22 = A(2,2)
Af1 = A($,1)
A2 = A(2,:)
A1223 = A(1:2,2:3) 

Asize = size(A) 

Amax = max(A)
[Amax,indexAmax] = max(A)

Amin = min(A)
[Amin,indexAmin] = min(A)

B = a*A+b
AB = A*B
AxB = A.*B
