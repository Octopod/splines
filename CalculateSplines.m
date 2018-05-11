function  splines = CalculateSplines(z, u, x, nr_of_y_values)

w_matrix = [];
for i=1:nr_of_y_values
    y = z(:,i); 
    w = CalculateSpline(x,y,u);
    w_matrix = [w_matrix; w];
end

splines = w_matrix;