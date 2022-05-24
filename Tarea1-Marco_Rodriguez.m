% Sistema original
A = [0 1;-5 6];
B = [0; 1];
C = [4 0];
D = 0;
T = 0.01;
planta = ss(A,B,C,D);
% Vector de polos para REI
Ps = [-4+3i, -4-3i, -10];

%Se calculan las matrices aumentadas del sistema en tiempo continuo
Asc = [A, zeros(2,1); -C, 0];
Bsc = [B; 0];

%Se calculan la matriz de ganancias en tiempo continuo
Ksc = acker(Asc, Bsc,Ps);

%Separandolo en las ganancias
Kic = -Ksc(3);
Kc = Ksc (1:2);

%Ahora, se discretiza el sistema y el vector de polos
SysD = c2d(planta, T, 'zoh');
SysD;
Ad = SysD.A;
Bd = SysD.B;
Cd = SysD.C;
Dd = SysD.D;
Pz = [exp(Ps(1)*T), exp(Ps(2)*T), exp(Ps(3)*T)];

%Se calculan las matrices aumentadas del sistema
Asd = [Ad, zeros(2,1); -Cd, 1];
Bsd = [Bd; 0];

%Se utiliza el método acker para calcular la matriz Ks de ganancias
Ksd = acker(Asd, Bsd, Pz);
Kid = -Ksd(3);
Kd = Ksd (1:2);

