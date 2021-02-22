clear; clc;
// SCILAB-1.sce

// Escalares
a = 2
b = 3

c1 = a+b
c2 = a*b
c3 = a^b
c4 = sqrt(2*a+7*b)
c5 = exp(2)
c6 = log(a)
c7 = log10(5*a)

// Vectores
v = [1 3 5 -1 1 -3 4 2 -2]

vt = v'
v2 = v(2)
vf = v($)
v24 = v(2:4)
vpar = v(2:2:$)
vrev = v($:-1:1)

vlength = length(v) 

vmax = max(v)
[vmax,indexvmax] = max(v)

vmin = min(v)
[vmin,indexvmin] = min(v)

index1 = find(v==1)
v1 = v(index1)

index2 = find(v<0)
v2 = v(index2)

index3 = find(v>0 & v<3)
v3 = v(index3)

vsum = sum(v)
vprod = prod(v)


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
[vmin,indexAmin] = min(A)

B = a*A+b
AB = A*B
AxB = A.*B
