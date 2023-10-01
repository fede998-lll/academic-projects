function plotBase(x_center, y_center, x_right, y_right)
    % PLOTBASE plots a base square for a manipulator.
    %   PLOTBASE generates a base square for a manipulator based on the input coordinates.
    %   The function takes the position of the center of the base and the position of the first link's vertex
    %   to generate the base square.
    %
    %   Inputs:
    %       - x_center, y_center: Coordinates of the center of the base square.
    %       - x_right, y_right: Coordinates of the vertex of the first link.
    %
    %   Outputs:
    %       None. The function plots the base square on the current figure.

    % Coordinates of the center of the square
    center = [x_center, y_center];

    % Coordinates of the vertex of the first link
    point_right = [x_right, y_right];

    % Length of the square side
    side_length = 0.9 * 1.33;

    % Calculation of the coordinates of the square vertices
    angle = atan2(point_right(2) - center(2), point_right(1) - center(1));
    vertex_angle = angle + pi/4; % 45-degree rotation angle

    vertex1 = center + side_length/2 * [cos(vertex_angle), sin(vertex_angle)];
    vertex2 = center + side_length/2 * [cos(vertex_angle + pi/2), sin(vertex_angle + pi/2)];
    vertex3 = center + side_length/2 * [cos(vertex_angle + pi), sin(vertex_angle + pi)];
    vertex4 = center + side_length/2 * [cos(vertex_angle + 3*pi/2), sin(vertex_angle + 3*pi/2)];

    % Fill the square with white color
    fill([vertex1(1), vertex2(1), vertex3(1), vertex4(1)], [vertex1(2), vertex2(2), vertex3(2), vertex4(2)], 'w');

end




