close all
clear all
clc
colordef black

X0 = [unifrnd(-600,600), unifrnd(-600,600), unifrnd(-600,600), 0,0,0]';  % Posizione iniziale del chaser rispetto al target

x_position = 100;   % Posizione x della finestra
y_position = 100;   % Posizione y della finestra
width = 1200;        % Larghezza della finestra
height = 800;       % Altezza della finestra

% Crea una nuova figura con la dimensione desiderata
figure('Position', [x_position, y_position, width, height], 'Color','black');
axis("equal")
view(3)
xlabel('X');
ylabel('Y');
zlabel('Z');


final = -1;
start=X0(1:3);
old_trajectory = cell(1,100);
i = 1;
dvs.x = 0;
dvs.y = 0;
dvs.z = 0;
time = 300;
duration = 0;
valore = 1;
tentativi = 0;
arrow = 0;


% Creazione dell'oggetto annotation per il testo
annotation_speed = annotation('textbox', [0.75, 0.85, 0.1, 0.1], 'Color', 'white', 'BackgroundColor', 'none', 'FitBoxToText', 'on', 'FontSize', 15, 'EdgeColor','none', 'Interpreter','latex');
annotation_position = annotation('textbox', [0.05, 0.85, 0.1, 0.1], 'Color', 'white', 'BackgroundColor', 'none', 'FitBoxToText', 'on', 'FontSize', 15, 'EdgeColor','none', 'Interpreter','latex');
annotation_dvs = annotation('textbox', [0.05, 0.45, 0.1, 0.1], 'Color', 'white', 'BackgroundColor', 'none', 'FitBoxToText', 'on', 'FontSize', 15, 'EdgeColor','none', 'Interpreter','latex');


while valore < 3

    if tentativi == 10
            
        messaggio = "Sorry, you've reached the maximum number of attempts. Better luck next time!";
        uiwait(msgbox(messaggio, 'modal'));
        valore = 3;
        close all
        return

    end

    if valore == 2
        messaggio = 'Congratulations! The chaser is now 100 m distant from his target. Press OK to initialize randezvous maneuver!';
        uiwait(msgbox(messaggio, 'modal'));

        X0 = [traj(1, end), traj(2, end), traj(3, end), traj(4, end), traj(5, end), traj(6,end)]';
        [traj, rho] = calculate_rdv(X0, time);
        arrow = 1;

    end

    if valore == 1

    [traj, rho, valore, deltaV_needed] = calculate_trajectory(X0,valore, time);
    
    end
    

    old_trajectory{i} = [traj(1,:);traj(2,:);traj(3,:);traj(4,:);traj(5,:);traj(6,:)];
    

    [valore, time] = print_fun2(traj, start, old_trajectory, time, annotation_speed, annotation_position,annotation_dvs, rho, valore, arrow);
  

if valore == 1

            input_valido = false;
            tentativi = tentativi + 1;

            while ~input_valido
                % Creazione della finestra di input
                prompt = {'Dx1:', 'Dy1:', 'Dz1:'};
                dlgtitle = 'Input DeltaVs';
                dims = [1 45];
                definput = {'', '', ''};
                
                answer = inputdlg(prompt, dlgtitle, dims, definput);
            
                % Controllo dei valori inseriti e aggiornamento delle variabili
                if ~isempty(answer)
                    dvs.x = str2double(answer{1});          
                    dvs.y = str2double(answer{2});
                    dvs.z = str2double(answer{3});
            
                    % Controllo se gli input sono numerici
                    if ~any(isnan([dvs.x, dvs.y, dvs.z]))
                        x = traj(1, time);
                        y = traj(2, time);
                        z = traj(3, time);
                        xd_new = traj(4, time) + dvs.x;
                        yd_new = traj(5, time) + dvs.y;
                        zd_new = traj(6, time) + dvs.z;
                        X0 = [x, y, z, xd_new, yd_new, zd_new]';
                        
                        input_valido = true; % I valori inseriti sono validi, usciamo dal ciclo while
                    else
                        % Gli input non sono numerici, richiedi l'inserimento nuovamente
                        errordlg('Please enter valid numerical values.', 'Errore');
                    end
                else
                    % L'utente ha premuto Cancel o ha chiuso la finestra di input, usciamo dal ciclo while
                    close all
                    return;
                end
            end        
end

    i = i+1;
  
end