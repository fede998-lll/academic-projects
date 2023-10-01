function plot_previous_trajectory(trajectory, nonEmptyCells,annotation_dvs)

for j = 1:length(nonEmptyCells)-1

    plot3(trajectory{j}(1,:),trajectory{j}(2,:), trajectory{j}(3,:),'color','white', 'LineWidth',1.5)
    
end


if length(nonEmptyCells)>1

    for k = 2:length(nonEmptyCells)
        x = trajectory{k}(1,1);  % Posizione x del punto
        y = trajectory{k}(2,1);  % Posizione y del punto
        z = trajectory{k}(3,1);  % Posizione z del punto
        u = trajectory{k}(4,1)-trajectory{k-1}(4,end);
        v = trajectory{k}(5,1)-trajectory{k-1}(5,end);
        w = trajectory{k}(6,1)-trajectory{k-1}(6,end);
        
        magnitude = sqrt(u^2+v^2+w^2);
        if magnitude > 1
            long = magnitude*8;
        else
            long = magnitude*180;
        end
        quiver3(x, y, z, u, v, w,'linewidth', 1.5 ,'AutoScaleFactor', long);
        annotation_dvs.String = sprintf('$\\Delta V_{%d}$: %.4f m/s', k-1, magnitude);
        
    end


end

end