function [valore, time] = print_fun2(new_traj, start, old_trajectory, time, annotation_text,annotation_position,annotation_dvs, rho, valore, arrow)

    puntatore = [new_traj(1,1), new_traj(2,1), new_traj(3,1)];
    nonEmptyCells = find(~cellfun(@isempty, old_trajectory));
    hold on

    if length(nonEmptyCells) > 1
        plot_previous_trajectory(old_trajectory, nonEmptyCells,annotation_dvs); % Traiettoria precedente
    end
    
    
    plot3(start(1), start(2), start(3), 'o','color', 'white' ,'MarkerSize', 5, 'MarkerFaceColor','white') % Punto iniziale
    text(start(1), start(2), start(3) + 1.5, 'Start position', 'Color', 'white', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Interpreter','latex', 'FontSize', 13);

    plot3(0,0,0, 'o','MarkerFaceColor','white', 'Color','white', 'MarkerSize',10) % Punto finale
    text(0, 0, 2, 'Target', 'Color', 'white', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','Interpreter','latex', 'FontSize', 13);
    
    h = plot3(puntatore(1), puntatore(2), puntatore(3), 'r*'); % Puntatore
 

    for i = 1:length(new_traj)
        
        delete(h);
        plot3(new_traj(1, 1:i), new_traj(2, 1:i), new_traj(3, 1:i), 'w--', 'LineWidth', 0.5); % Traiettoria attuale
        h = plot3(new_traj(1, i), new_traj(2, i), new_traj(3, i), 'o', 'Color','white', 'MarkerSize', 5); % Nuovo puntatore
        
        % Aggiornamento del testo
        annotation_text.String = sprintf('Actual velocites w.r.t Target:\n$V_{x}$: %.4f m/s\n$V_{y}$: %.4f m/s\n$V_{z}$: %.4f m/s\n', new_traj(4, i), new_traj(5, i), new_traj(6, i));
        annotation_position.String = sprintf('Actual position w.r.t Target:\n$x$: %.3f m\n$y$: %.3f m\n$z$: %.3f m\n$\\rho$: %.3f m', new_traj(1, i), new_traj(2, i), new_traj(3, i), rho(i));
        drawnow

    end

    if valore == 2 && arrow == 1
        
        x = 0;  % Posizione x del punto
        y = 0;  % Posizione y del punto
        z = 0;  % Posizione z del punto
        u = new_traj(4, end);
        v = new_traj(5,end);
        w = new_traj(6,end);
        
        magnitude = sqrt(u^2+v^2+w^2);
        quiver3(x, y, z, u, v, w,'linewidth', 1.5 ,'AutoScaleFactor', 150*magnitude);
        annotation_text.String = sprintf('Actual velocites w.r.t Target:\n$V_{x}$: %.4f m/s\n$V_{y}$: %.4f m/s\n$V_{z}$: %.4f m/s\n', 0,0,0);
        annotation_dvs.String = sprintf('$\\Delta V_{%d}$: %.4f m/s', length(nonEmptyCells), magnitude);
        valore = 3;

    end

    
    hold off

        if valore == 3
            
            messaggio = "Congratulations! You reached the target!";
            uiwait(msgbox(messaggio, 'modal'));
            
            
        end

    
end
