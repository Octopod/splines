function  splines = CalculateSpline(x,y,u)
% cubic spline calculator 
% based on descriptions from "Numeriska metoder med Matlab" by Gerd Eriksson
% x and y are the 'original' coordinates
% u holds the interpolated points for x

nr_of_x_values = length(x);

% calculate h-values from input: h(i) = x(i+1)-x(i)
for i=1:nr_of_x_values-1
    h(i) = x(i+1)-x(i);
end

% create matrix diagonals:  sub_diagonal and super_diagonal
for i = 1:nr_of_x_values-2
    sub_diagonal(i) = h(i)/(h(i)+h(i+1));
    super_diagonal(i) = h(i+1)/(h(i)+h(i+1));
end
sub_diagonal = [sub_diagonal 1];
super_diagonal = [1 super_diagonal];


% find the differential values for y
dy(:,1) = y;
for i = 2:nr_of_x_values
 for j = 2:i
     if(j<=3)
     dy(i,j) = (dy(i,j-1)-dy(i-1,j-1))/(x(i)-x(i-j+1));
     end
 end
end

% create matrix b
% MISSING: scale according to h
b_1 = 6*dy(2,2);
b_end = -6*dy(end,2);
bm = 6*(dy(:,3));
bm([1 2]) = [];
b = [b_1 ; bm ; b_end];


% create matrix A (all diagonals)
a = ones(nr_of_x_values, 1)*2;
A = diag(a);

for i = 2:nr_of_x_values
   A(i,i-1) = sub_diagonal(i-1);  %subdiagonal
   A(i-1,i) = super_diagonal(i-1);  %supdiagonal
end

% k = A\b solves the system of linear equations A*k = b
k = A\b;


% calculate the splines
% MISSING: scale with h
for i = 1:length(u)
    logical_interval_counter = (x<u(i));
    t = sum(logical_interval_counter);
    
    if t==0
        t = 1;
    end
    
    if t==nr_of_x_values
        t = t-1;
    end
    
    first = k(t) * (x(t+1) - u(i))^3 / 6;
    second = k(t+1) * (u(i) - x(t))^3 / 6;
    third = (y(t)-k(t) / 6) * (x(t+1)-u(i));
    fourth = (y(t+1) - k(t+1) / 6) * (u(i) - x(t));

    splines(i) = first + second + third + fourth;   
end
end
        
    

    
