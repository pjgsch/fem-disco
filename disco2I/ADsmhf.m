i=0;
A = 10;
Go = 20;
m = 1;
k = 100;
Gor = sqrt(k/m);

a1 = 0;
a2 = -sqrt(m/k) * (A/m)/(Gor^2 - Go^2) * Go;

for t=0:0.01:2
i=i+1;

uh = a1*cos(Gor*t) + a2*sin(Gor*t);
up = (A/m)/(Gor^2 - Go^2) * sin(Go*t);
u  = uh+up;

Mu(i) = u;
Mt(i) = t;

end;

plot(Mt,Mu);
