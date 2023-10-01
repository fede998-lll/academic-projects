function plotLinks(N)
    % PLOTLINKS Plot a manipulator with 5 links.
    %   PLOTLINKS(N) plots a manipulator with 5 links connected to each other
    %   and to the base square. The structure N contains the following fields:
    %       - x_v1, y_v1: Coordinates of the first vertex of the first link.
    %       - x_v2, y_v2: Coordinates of the second vertex of the first link or the first vertex of the second link.
    %       - x_v3, y_v3: Coordinates of the second vertex of the second link or the first vertex of the third link.
    %       - x_v4, y_v4: Coordinates of the second vertex of the third link or the first vertex of the fourth link.
    %       - x_v5, y_v5: Coordinates of the second vertex of the fourth link or the first vertex of the fifth link.
    %       - x_v6, y_v6: Coordinates of the second vertex of the fifth link or the end-effector.
    %
    %   Inputs:
    %       - N: Structure containing the coordinates of the manipulator vertices.
    %
    %   Outputs:
    %       None. The function plots the manipulator on the current figure.

    % Plot the links
    line([N.x_v1, N.x_v2], [N.y_v1, N.y_v2], 'Color', 'w', 'LineWidth', 2);
    line([N.x_v2, N.x_v3], [N.y_v2, N.y_v3], 'Color', 'w', 'LineWidth', 2);
    line([N.x_v3, N.x_v4], [N.y_v3, N.y_v4], 'Color', 'w', 'LineWidth', 2);
    line([N.x_v4, N.x_v5], [N.y_v4, N.y_v5], 'Color', 'w', 'LineWidth', 2);
    line([N.x_v5, N.x_v6], [N.y_v5, N.y_v6], 'Color', 'w', 'LineWidth', 2);

    % Plot the joints
    plot(N.x_v1, N.y_v1, 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'yellow', 'MarkerFaceColor', 'yellow');
    plot(N.x_v2, N.y_v2, 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'yellow', 'MarkerFaceColor', 'yellow');
    plot(N.x_v3, N.y_v3, 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'yellow', 'MarkerFaceColor', 'yellow');
    plot(N.x_v4, N.y_v4, 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'yellow', 'MarkerFaceColor', 'yellow');
    plot(N.x_v5, N.y_v5, 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'yellow', 'MarkerFaceColor', 'yellow');
    plot(N.x_v6, N.y_v6, 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');

end
