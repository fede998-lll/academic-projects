function [target_trajectory, rho, valore, deltaV_needed] = calculate_trajectory(X0, valore, time)
    
    h = 500e3;
    R_T = 6371e3;
    G = 6.67259e-11;
    M_earth = 5.972e24;
    m_Deputy = 200;
    mu = G*(M_earth+m_Deputy);
    r = R_T + h; 
    T_max = time;
    omega = sqrt(mu / r^3);
    intervals = 800;
    
    
    A = [0 0 0 1 0 0;
         0 0 0 0 1 0;
         0 0 0 0 0 1;
         3*omega^2 0 0 0 2*omega 0;
         0 0 0 -2*omega 0 0;
         0 0 -omega^2 0 0 0];
    
    phi = @(t) expm(A * t);
    X = @(t, X0) phi(t) * X0;
    t = linspace(1, T_max, intervals);
    iter = time;

%---------------------------------------------------------------------------------

    position0 = X0(1:3);
    velocity0 = X0(4:6);
    deltaV_needed = zeros(length(t),1);
    velocity_needed = zeros(3,length(t));

for k = 1:length(t)

    phi_i = phi(t(k));
    velocity_needed(:,k) = phi_i(1:3,4:6)\([57.73 57.73 57.73]' - phi_i(1:3,1:3)*position0);
    deltaV_needed(k) = norm(velocity_needed(:,k) - velocity0);

end


    [~, min_deltaV] = min(deltaV_needed);
    X0 = [position0;velocity_needed(:,min_deltaV)];
    


%----------------------------------------------------------------------------------    
    
    target_trajectory = zeros(length(X0), length(iter));
    rho = zeros(length(iter),1); 

    for i = 1:iter
    
        target_trajectory(:,i) = X(t(i), X0);
        diff = target_trajectory(1:3,i)-[0,0,0]';
        rho(i) = sqrt(diff(1)^2+diff(2)^2+diff(3)^2);

        if rho(i) <= 100

            valore = 2;
            dim = i;
            target_trajectory = target_trajectory(:, 1:dim);
            break

        end

    end

       

end
