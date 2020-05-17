% creating variables for grid X and Y directions
initial_time=0;
pie=3.1415;
pie_2=2*pie;
ET=0.2; % end time in time(Y-axis)
Nx=5; %grid division in X-direction
Ny=5;  % grid division in Y-direction
h=1/Nx; % width in X-direction
k=ET/Ny; % width in Y-direction
L=1; % Bars length
C=1; % String constant
 
% Initializing grid entries
grid_y= [k:k:ET];
grid_x=[h:h:(1-h)]; % grid of valid entries for u(x,0)

% defining coefficient
s=((C*k)/h)^2; 

% initialization,declaration and defination of A Matrix
A=zeros(4,4);
I=2*(1-s)*eye(4,4); %
alphas_diag=[s s 0];
corner_diag=[s];
A=I+diag(alphas_diag,1)+diag(alphas_diag,-1)+diag(corner_diag,3)+diag(corner_diag,-3);


%initialisation, declaration and defination of B Vector
displacement_i=(grid_x.*(grid_x-2).*(grid_x-1))'; % valid displacement grid entries or "B" vector
initial_grid=displacement_i;
grid_points_n=zeros(4,5);
%ii=repmat(1,4,4);
 for i=1:Ny
     B=displacement_i;
     XX=A\B;
     displacement_i=XX;
 grid_points_n(:,i)=XX;
 end
grid_points_i=horzcat(initial_grid,grid_points_n);

boundries=zeros(Ny+1,1);
grid_points=flipud(grid_points_i');
V=horzcat(boundries,grid_points,boundries);
if(ET~=pie||ET~=pie_2||ET~=initial_time)
mesh(V);
zlabel('displacement'); 
end
if(ET==pie||ET==pie_2||ET==initial_time)
        plot(V);
end
    