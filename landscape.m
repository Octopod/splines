function  L=landscape(z)

[nr_of_x_values, nr_of_y_values] = size(z);
dt = 0.2;

% calculating splines in first direction
x = 1:1:nr_of_x_values;
u = 1:dt:nr_of_x_values;
w_matrix = CalculateSplines(z, u, x, nr_of_y_values);


% calculating splines in second direction
y = 1:1:nr_of_y_values;
u = 1:dt:nr_of_y_values;
[~, nr_of_y_values] = size(w_matrix);

w_matrix = CalculateSplines(w_matrix, u, y, nr_of_y_values);

L = w_matrix;