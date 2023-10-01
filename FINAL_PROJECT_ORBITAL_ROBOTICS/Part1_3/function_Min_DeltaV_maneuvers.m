function [deltaV_first_Impulse,deltaV_second_Impulse]=function_Min_DeltaV_maneuvers(x,y,z,x_dot,y_dot,z_dot,height,m_Deputy)
    R_T=6371*10^3;
    G=6.67259*10^-11;
    M=5.97*10^24;
    mu=G*(M+m_Deputy);
    r=R_T+height;
    T=2*pi*sqrt(r^3/mu);
    T_max=T/2;
    omega=sqrt(mu/r^3);
    A=[
        0 0 0 1 0 0;
        0 0 0 0 1 0;
        0 0 0 0 0 1;
        3*omega^2 0 0 0 2*omega 0;
        0 0 0 -2*omega 0 0;
        0 0 -omega^2 0 0 0;
        ];
    
    X0=[x y z x_dot y_dot z_dot]';
    phi=@(t) expm(A*t);
    X=@(t,X0) phi(t)*X0;
    t=linspace(1,T_max,1000);
    %-----------------------------------------------------------------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %% DELTA_V MINIMUM OPTIMIZATION %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    deltaV_i_sec=zeros(length(t),1);
    deltaV_project_1_final=zeros(length(t),1);
    deltaV_tot=zeros(length(t),1);
    for i=1:length(t)
        X0_new=X(t(i),X0);
        position0=X0_new(1:3);
        velocity0=X0_new(4:6);
        phi_i_sec=phi(t(i));
        Velocity_needed_i_sec=phi_i_sec(1:3,4:6)\([0 0 0]'-phi_i_sec(1:3,1:3)*position0);
        deltaV_i=Velocity_needed_i_sec-velocity0;
        deltaV_i_sec(i)=sqrt(deltaV_i(1)^2 + deltaV_i(2)^2 + deltaV_i(3)^2);
        X0_rdv_project_1=[position0;Velocity_needed_i_sec];
        X_t_rdv_project=zeros(length(X0),length(t));
        for j=1:length(t)
            X_t_rdv_project(:,j)=X(t(j),X0_rdv_project_1);
        end
        deltaV_project_1_final(i)=sqrt(X_t_rdv_project(4,end)^2 + X_t_rdv_project(5,end)^2 + X_t_rdv_project(6,end)^2);
        deltaV_tot(i)=deltaV_i_sec(i)+deltaV_project_1_final(i);
        if i>1 && deltaV_tot(i)<deltaV_tot(i-1)
            index=i;
        end
    end
    phi_project=phi(t(index));
    Velocity_needed_project=phi_project(1:3,4:6)\([0 0 0]'-phi_project(1:3,1:3)*position0);
    X0_rdv_project=[position0;Velocity_needed_project];
    X_t_rdv_project=zeros(length(X0),length(t));
    for i=1:index
        X_t_rdv_project(:,i)=X(t(i),X0_rdv_project);
    end
    XF_rdv_project=X(t(index),X0_rdv_project);
    disp('Optimized First impulse for the starting point')
    deltaV_first_Impulse=deltaV_i_sec(index);
    disp('Optimized Second impulse for the Approaching point')
    deltaV_second_Impulse=deltaV_project_1_final(index);
    Time_project=t(index);
    %------------------------------------------------------------------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         %% SIMULATION FOR 1000 S %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    phi_1000sec=phi(1000);
    Velocity_needed_1000sec=phi_1000sec(1:3,4:6)\([0 0 0]'-phi_1000sec(1:3,1:3)*position0);
    X0_rdv_1000sec=[position0;Velocity_needed_1000sec];
    t=linspace(0,1000,1000);
    X_t_rdv1000sec=zeros(length(X0),length(t));
    for i=1:length(t)
        X_t_rdv1000sec(:,i)=X(t(i),X0_rdv_1000sec);
    end
    %------------------------------------------------------------------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %% SIMULATION FOR 2000 S %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    phi_2000sec=phi(2000);
    Velocity_needed_2000sec=phi_2000sec(1:3,4:6)\([0 0 0]'-phi_2000sec(1:3,1:3)*position0);
    X0_rdv_2000sec=[position0;Velocity_needed_2000sec];
    t=linspace(0,2000,1000);
    X_t_rdv2000sec=zeros(length(X0),length(t));
    for i=1:length(t)
        X_t_rdv2000sec(:,i)=X(t(i),X0_rdv_2000sec);
    end
    %------------------------------------------------------------------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %% SIMULATION FOR 2700 S %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    phi_2700sec=phi(2700);
    Velocity_needed_2700sec=phi_2700sec(1:3,4:6)\([0 0 0]'-phi_2700sec(1:3,1:3)*position0);
    X0_rdv_2700sec=[position0;Velocity_needed_2700sec];
    t=linspace(0,2700,1000);
    X_t_rdv2700sec=zeros(length(X0),length(t));
    for i=1:length(t)
        X_t_rdv2700sec(:,i)=X(t(i),X0_rdv_2700sec);
    end
    %------------------------------------------------------------------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %% SIMULATION FOR 2800 S %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    phi_2800sec=phi(2800);
    Velocity_needed_2800sec=phi_2800sec(1:3,4:6)\([0 0 0]'-phi_2800sec(1:3,1:3)*position0);
    X0_rdv_2800sec=[position0;Velocity_needed_2800sec];
    t=linspace(0,2800,1000);
    X_t_rdv2800sec=zeros(length(X0),length(t));
    for i=1:length(t)
        X_t_rdv2800sec(:,i)=X(t(i),X0_rdv_2800sec);
    end
    %------------------------------------------------------------------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %% FINAL RESULTS %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(1)
    plot3(X_t_rdv1000sec(1,:),X_t_rdv1000sec(2,:),X_t_rdv1000sec(3,:),'g-',LineWidth=1)
    hold on
    plot3(X_t_rdv2000sec(1,:),X_t_rdv2000sec(2,:),X_t_rdv2000sec(3,:),'w-',LineWidth=1)
    hold on
    plot3(X_t_rdv_project(1,:),X_t_rdv_project(2,:),X_t_rdv_project(3,:),'m-',LineWidth=4)
    hold on
    plot3(X_t_rdv2700sec(1,:),X_t_rdv2700sec(2,:),X_t_rdv2700sec(3,:),'c-',LineWidth=1)
    hold on
    plot3(X_t_rdv2800sec(1,:),X_t_rdv2800sec(2,:),X_t_rdv2800sec(3,:),'b-',LineWidth=1)
    hold on
    plot3(position0(1),position0(2),position0(3),'*',LineWidth=2,Color='y')
    hold on
    plot3(XF_rdv_project(1),XF_rdv_project(2),XF_rdv_project(3),'*',LineWidth=2,Color='r')
    grid minor
    xlabel('X [m]','Interpreter','latex')
    ylabel('Y [m]','Interpreter','latex')
    zlabel('Z [m]','Interpreter','latex')
    title(sprintf('3D Rendez-vous maneuvers\nFirst Impulse: %0.3f $m/s$\nSecond Impulse: %0.3f $m/s$',deltaV_first_Impulse,deltaV_second_Impulse),'Interpreter','latex','Color','[0.9290 0.6940 0.1250]','FontSize',12);
    legend('Simulation of 1000 s','Simulation of 2000 s',sprintf('Optimized simulation of %0.3f s',Time_project),'Simulation of 2700 s','Simulation of 2800 s','Interpreter','latex',Location='best')
    text(position0(1),position0(2),position0(3),'\leftarrow Starting point',LineWidth=2,Color='y',FontSize=13)
    text(XF_rdv_project(1),XF_rdv_project(2),XF_rdv_project(3),'\leftarrow Approaching point',LineWidth=2,Color='r',FontSize=13)
end



