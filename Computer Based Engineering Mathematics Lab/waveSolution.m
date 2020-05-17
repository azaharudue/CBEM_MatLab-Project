% This Matlab code will create a function which has as parameters a
% displacement function of spring, number of step with given lenght and
% number of steps with given END TIME

function [U] = waveSolution(f,h,k,ET);
L=1; % Bars length
C=1; % String constant

dx=(L/h)-1; % number of steps in X-direction with valid entries M-1 (Note: grid entries are without boundries)
dy=round(ET/k);    % number of steps in y-direction till given END POINT
 
% Initializing valid grid entries
grid_x=[h:h:(1-h)]'; % grid of valid entries for u(x,0)

% defining coefficient
s=((C*k)/h)^2;       % calculating the constant from differential equation

% initialization,declaration and defination of A Matrix
A=zeros(dx,dx);                % memory allocation with M-1 and N-1 entries
I=2*(1-s)*eye(dx,dx);          % initializing and defining main diagonal with 2*(1-s) (M * times)
diag_1=repmat([s; s; 0],dx,1); % initializing and defining diagonal with repeting s s 0 (M * times)
diag_2= repmat(s,dx,1);        % initializing and defining diagonal with all s (M * times)

% definition of A matrix depending on the M entries
if (dx==1)
A=I;
else if (dx==2)
last_diag= diag_1(1:dx-1,1);
A=I+diag(last_diag,+1)+diag(last_diag,-1);
    else
            last_diag= diag_1(1:dx-1,1);
            last_diag_all_s=diag_2(1:dx-3,1);
            A=I+diag(last_diag,+1)+diag(last_diag,-1)+diag(last_diag_all_s,+3)+diag(last_diag_all_s,-3);
    end
end

% %initialisation, declaration and defination of B Vector
displacement_i=f(grid_x);     % valid displacement grid entries or "B" vector
initial_grid=displacement_i;  
grid_points_n=zeros(dx,dy); % memory allocation for grid entries without boundires for loop


 for i=1:dy
     B=displacement_i;
     XX=A\B;
     displacement_i=XX;
 grid_points_n(:,i)=XX;       % definition and declaration of grid entries without boundries
 end
 
grid_points_i=horzcat(initial_grid,grid_points_n); % complete grid with initial displacement entries

boundries=zeros(dy+1,1);      % N-1 times zeros for start and end point fixed boundries
grid_points=flipud(grid_points_i'); 
V=horzcat(boundries,grid_points,boundries); % complete grid of [U]=((M-1)*h,(N-1)*k)
mesh(V);
zlabel('displacement'); 
display(grid_points);
 end