% Reference: https://www.linkedin.com/posts/lonny-thompson_fem-quiz7-2026-activity-7437517685124583424-YkhL?utm_source=social_share_send&utm_medium=member_desktop_web&rcm=ACoAACYE8AABwNkS39jz2fUJRqE0x1Fd4hIMdjo

% QUAD4 ELEMENT 2D FEA 

clear all;
clc;

syms xi eta real;

%-------------------------------------------------------------
% Step-1: Define Shape Functions (Nj)
%-------------------------------------------------------------

% 4-Node Lagrange Element
N1 = 0.25*(1-xi)*(1-eta);
N2 = 0.25*(1+xi)*(1-eta);
N3 = 0.25*(1+xi)*(1+eta);
N4 = 0.25*(1-xi)*(1+eta);

% N - matrix (2D)
N = [N1, 0, N2, 0, N3, 0, N4, 0;
      0,N1, 0, N2, 0, N3, 0, N4];

%-------------------------------------------------------------
% Step-2: Compute B matrix (B)
%-------------------------------------------------------------

% Node coordinates in GLOBAL CSYS
% xij - ith node (1,2,3,4), jth coordinate (1,2)

% General Distorted Element
syms x11 x12 x21 x22 x31 x32 x41 x42 real positive
x = [x11, x12;
     x21, x22;
     x31, x32;
     x41, x42;];

% % Square Element (UNDISTORTED)
% x = [-1, -1;
%      +1, -1;
%      +1, +1;
%      -1, +1;];

% Compute Jacobian for Bilinear Quadrilateral Element (QUAD4)
Je = [diff(N1,xi), diff(N2,xi), diff(N3,xi), diff(N4,xi);
      diff(N1,eta), diff(N2,eta), diff(N3,eta), diff(N4,eta)]*x;

% Inverse of Jacobian
invJe = inv(Je);

% B matrix computation

% 1. From Voigt Notation - Strain Definition
T = [1, 0, 0, 0;
     0, 0, 0, 1;
     0, 1, 1, 0];

% 2. Displacement Derivative Transform from Local to Global
G = [invJe(1,1), invJe(1,2), 0, 0;
    invJe(2,1), invJe(2,2), 0, 0;
    0, 0, invJe(1,1), invJe(1,2);
    0, 0, invJe(2,1), invJe(2,2)];

% 3. Displacement derivatives in local CSYS related with NODAL
% displacements

R = [diff(N1,xi), 0, diff(N2,xi), 0, diff(N3,xi), 0, diff(N4,xi), 0;
    diff(N1,eta), 0, diff(N2,eta), 0, diff(N3,eta), 0, diff(N4,eta), 0;
    0 , diff(N1,xi), 0, diff(N2,xi), 0, diff(N3,xi), 0, diff(N4,xi);
    0, diff(N1,eta), 0, diff(N2,eta), 0, diff(N3,eta), 0, diff(N4,eta)];

% Compute B Matrix 
B = T*G*R;


%-------------------------------------------------------------
% Step-3: Material Behavior (C) 
%-------------------------------------------------------------
syms E nu real positive

% Material Stiffness Matrix (Hooke's Law)
C =  (E/(1-nu^2))*[1, nu, 0; nu, 1, 0; 0, 0, 0.5*(1-nu)];


%-------------------------------------------------------------
% Step-4: Stiffness Matrix Integrand
%-------------------------------------------------------------

KI = (transpose(B)*C*B*det(Je));

%-------------------------------------------
% Case-1: Exact Integration
K1 = int(int(KI,xi,-1,1),eta,-1,1);

fprintf("Stiffness Matrix \n")
fprintf("==================================== \n")
fprintf("Case-1: Exact Integration (Analytic) \n")
disp(K1)
fprintf("------------------------------------ \n")

%-------------------------------------------
% Case-2: Full Integration (2 gauss points per direction)

weight = [1,1];
point  = [-sqrt(1/3), sqrt(1/3)];

K2 = zeros(8,8);

for i=1:length(weight)
    for j=1:length(weight)
        K2 = K2 + weight(i)*weight(j)*subs(subs(KI,xi,point(i)),eta,point(j));
    end
end

fprintf("Case-2: Full Integration (2 Gauss Points) \n")
disp(K2)
fprintf("------------------------------------ \n")


%-------------------------------------------
% Case-3: Reduced Order Integration (1 gauss point per direction)
% Ke3 = 2*subs(subs(I,xi,0),eta,0);

weight = [2];
point  = [0];

K3 = zeros(8,8);

for i=1:length(weight)
    for j=1:length(weight)
        K3 = K3 + weight(i)*weight(j)*subs(subs(KI,xi,point(i)),eta,point(j));
    end
end

fprintf("Case-3: Reduced Order Integration (1 Gauss Point) \n")
disp(K3)
fprintf("------------------------------------ \n")

%-------------------------------------------
% Case-4: Increased Order Integration (3 gauss points per direction)
K4 = zeros(8,8);

weight = [5/9, 8/9, 5/9];
point  = [-sqrt(0.6), 0, sqrt(0.6)];

for i=1:length(weight)
    for j=1:length(weight)
        K4 = K4 + weight(i)*weight(j)*subs(subs(KI,xi,point(i)),eta,point(j));
    end
end

fprintf("Case-4: Increased Order Integration (3 Gauss Points) \n")
disp(K4)
fprintf("------------------------------------ \n")

%% ==========================================================================
% Verification

% Square Element
x = [-1, -1;
     +1, -1;
     +1, +1;
     -1, +1;];

% Displacement Loading Condition
syms u real
de = [u, 0, -u, 0, u, 0, -u, 0]';

% Potential Energy
PE1 = simplify(0.5*transpose(de)*K1*de);
PE2 = simplify(0.5*transpose(de)*K2*de);
PE3 = simplify(0.5*transpose(de)*K3*de);
PE4 = simplify(0.5*transpose(de)*K4*de);

