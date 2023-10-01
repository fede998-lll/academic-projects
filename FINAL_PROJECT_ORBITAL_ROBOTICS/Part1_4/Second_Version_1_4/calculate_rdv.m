function [target_trajectory, rho] = calculate_rdv(X0, time)

h = 500e3;
R_T = 6371e3;
G = 6.67259e-11;
M_earth = 5.972e24;
m_Deputy = 200;
mu = G*(M_earth+m_Deputy);
r = R_T + h;
omega = sqrt(mu / r^3);
    
    
    A = [0 0 0 1 0 0;
         0 0 0 0 1 0;
         0 0 0 0 0 1;
         3*omega^2 0 0 0 2*omega 0;
         0 0 0 -2*omega 0 0;
         0 0 -omega^2 0 0 0];
    
    phi = @(t) expm(A * t);
    X = @(t, X0) phi(t) * X0;
    t = linspace(1, time, time);
    
    position0 = X0(1:3);
    velocity0 = X0(4:6);


    phi_i = phi(time);

    velocity_needed = phi_i(1:3,4:6)\([0 0 0]' - phi_i(1:3,1:3)*position0);
    

    X0 = [position0;velocity_needed];

    target_trajectory = zeros(length(X0), length(t));
    rho = zeros(length(t),1); 

    for i = 1:length(t)
    
        target_trajectory(:,i) = X(t(i), X0);
        diff = target_trajectory(1:3,i)-[0,0,0]';
        rho(i) = sqrt(diff(1)^2+diff(2)^2+diff(3)^2);

    end

    

end