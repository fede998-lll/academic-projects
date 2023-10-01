clear all
clc
close all
colordef black
FFP6L5R_Robot_Description
FFP6L5R_Simulate
sysname='FFP_6L_5R';
t=t_out;
% There are three rotational DOFs because these are theta_0, theta_1 and
% theta_2
num_rotational_dof=6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_NSysCOM'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysCOM:\n'))
fprintf('Evolution in time of the coordinates of the system CoM on the N CCS\n') 
fprintf('each subplot is showing a gen. coordinate in darker line and the corresponding generalized velocity in lighter line.\n')
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
subplot(1,2,1)
plot(t,SCMt(:,1),'LineWidth', 2, 'color','w')
xlabel('t [s]')
ylabel('x_{SCM} on the N CCS')
subplot(1,2,2)
plot(t,SCMt(:,2),'LineWidth', 2, 'color','w')
grid minor
xlabel('t [s]')
ylabel('y_{SCM} on the N CCS')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_BirdView'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_BirdView:\n'))
fprintf('Evolution on plane of motion\n')
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
%-------------------------------------------------------------------------
plot(SCMt(:,1),SCMt(:,2),'LineWidth', 3, 'color','w','DisplayName','CoM')
hold on
txt = '\leftarrow C at t_0';
text(SCMt(1,1),SCMt(1,2),txt,'FontSize',14) 
%-------------------------------------------------------------------------
plot(C0_t(:,1),C0_t(:,2),'LineWidth', 2, 'color','w','DisplayName','C0')
txt = '\leftarrow C0 at t_0';
text(C0_t(1,1),C0_t(1,2),txt,'FontSize',14) 
%-------------------------------------------------------------------------
plot(C1_t(:,1),C1_t(:,2),'LineWidth', 2, 'color','w','DisplayName','C0')
txt = '\leftarrow C1 at t_0';
text(C1_t(1,1),C1_t(1,2),txt,'FontSize',14) 
plot(Oj1_t(:,1),Oj1_t(:,2),'LineWidth', 2, 'color','w','DisplayName','C0')
txt = '\leftarrow Oj1 at t_0';
text(Oj1_t(1,1),Oj1_t(1,2),txt,'FontSize',14) 
%-------------------------------------------------------------------------
plot(C2_t(:,1),C2_t(:,2),'LineWidth', 2, 'color','r','DisplayName','C0')
txt = '\leftarrow C2 at t_0';
text(C2_t(1,1),C2_t(1,2),txt,'FontSize',14,Color='r')
plot(Oj2_t(:,1),Oj2_t(:,2),'LineWidth', 2, 'color','r','DisplayName','C0')
txt = '\leftarrow Oj2 at t_0';
text(Oj2_t(1,1),Oj2_t(1,2),txt,'FontSize',14,Color='r')
%-------------------------------------------------------------------------
plot(C3_t(:,1),C3_t(:,2),'LineWidth', 2, 'color','c','DisplayName','C0')
txt = '\leftarrow C2 at t_0';
text(C3_t(1,1),C3_t(1,2),txt,'FontSize',14,Color='c')
plot(Oj3_t(:,1),Oj3_t(:,2),'LineWidth', 2, 'color','c','DisplayName','C0')
txt = '\leftarrow Oj2 at t_0';
text(Oj3_t(1,1),Oj3_t(1,2),txt,'FontSize',14,Color='c')
%-------------------------------------------------------------------------
plot(C4_t(:,1),C4_t(:,2),'LineWidth', 2, 'color','m','DisplayName','C0')
txt = '\leftarrow C2 at t_0';
text(C4_t(1,1),C4_t(1,2),txt,'FontSize',14,Color='m')
plot(Oj4_t(:,1),Oj4_t(:,2),'LineWidth', 2, 'color','m','DisplayName','C0')
txt = '\leftarrow Oj2 at t_0';
text(Oj4_t(1,1),Oj4_t(1,2),txt,'FontSize',14,Color='m')
%-------------------------------------------------------------------------
plot(C5_t(:,1),C5_t(:,2),'LineWidth', 2, 'color','y','DisplayName','C0')
txt = '\leftarrow C2 at t_0';
text(C5_t(1,1),C5_t(1,2),txt,'FontSize',14,Color='y')
plot(Oj5_t(:,1),Oj5_t(:,2),'LineWidth', 2, 'color','y','DisplayName','C0')
txt = '\leftarrow Oj2 at t_0';
text(Oj5_t(1,1),Oj5_t(1,2),txt,'FontSize',14,Color='y')
%-------------------------------------------------------------------------
plot(EE_t_5(:,1),EE_t_5(:,2),'LineWidth', 2, 'color','r','DisplayName','C0')
txt = '\leftarrow EE at t_0';
text(EE_t_5(1,1),EE_t_5(1,2),txt,'FontSize',14,Color='w')
%-------------------------------------------------------------------------
grid minor
xlabel('x')
ylabel('y')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_NSysMoMwrtC0'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysMoMwrtC0:\n'))
fprintf('Evolution in time of the Moment of Momentum w.r.t. C0 (CoM L0)\n') 
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
plot(t,MoMt_C0(:,3)-MoMt_C0(1,3)*ones(size(MoMt_C0)),'LineWidth', 2, 'color','w')
grid minor
xlabel('t [s]')
ylabel('MoM wrt C0 minus its Init. Value')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_NSysLinearMomwrtC0'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysLinearMomwrtC0:\n'))
fprintf('Evolution in time of the Linear Momentum w.r.t. C0 (CoM L0)\n') 
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
plot(t,Linear_Mom_CO(:,1)-Linear_Mom_CO(1,1)*ones(size(Linear_Mom_CO)),'LineWidth', 2, 'color','w')
grid minor
xlabel('t [s]')
ylabel('X Linear Momentum component wrt C0 minus its Init. Value')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_NSysLinearMomwrtC0'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysLinearMomwrtC0:\n'))
fprintf('Evolution in time of the Linear Momentum w.r.t. C0 (CoM L0)\n') 
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
plot(t,Linear_Mom_CO(:,2)-Linear_Mom_CO(1,2)*ones(size(Linear_Mom_CO)),'LineWidth', 2, 'color','w')
grid minor
xlabel('t [s]')
ylabel('Y Linear Momentum component wrt C0 minus its Init. Value')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_NSysMoMwrtOI'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysMoMwrtOI:\n'))
fprintf('Evolution in time of the Moment of Momentum w.r.t. OI (Origin of Inertially Fixed CCS)\n')
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
plot(t, MoMt_OI(:,3)-MoMt_OI(1,3)*ones(size(MoMt_OI)),'LineWidth', 2, 'color','w')
grid minor
xlabel('t [s]')
ylabel('MoM wrt OI minus its Init. Value')
legend('MoM wrt OI',Location='best')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_NSysMoMwrtC'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysMoMwrtC:\n'))
fprintf('Evolution in time of the Moment of Momentum w.r.t. C (system CoM)\n')
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
plot(t, MoMt_sysC(:,3)-MoMt_sysC(1,3)*ones(size(MoMt_sysC)),'LineWidth', 2, 'color','w')
grid minor
xlabel('t [s]')
ylabel('MoM wrt C minus its Init. Value')
legend('MoM wrt C',Location='best')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_NSysAngularMomentumwrtC'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_NSysAngularMomentumwrtC:\n'))
fprintf('Evolution in time of the Angular Momentum w.r.t. C (system CoM)\n')
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
plot(t, h(:,3)-h(1,3)*ones(size(h)),'LineWidth', 2, 'color','w')
grid minor
xlabel('t [s]')
ylabel('h wrt C minus its Init. Value')
legend('h wrt C',Location='best')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_NAxialMoMmwrtj_i'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_NAxialMoMmwrtj_i:\n'))
fprintf('Evolution in time of the Axial Moment of Momentum of the manipulator w.r.t. j1 (joint 1)\n')
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
plot(t, Axial_MoMm_j1(:,1),'LineWidth', 2, 'color','w')
hold on
plot(t, Axial_MoMm_j2(:,1),'LineWidth', 2, 'color','r')
hold on
plot(t, Axial_MoMm_j3(:,1),'LineWidth', 2, 'color','m')
hold on
plot(t, Axial_MoMm_j4(:,1),'LineWidth', 2, 'color','c')
hold on
plot(t, Axial_MoMm_j5(:,1),'LineWidth', 2, 'color','y')
grid minor
xlabel('t [s]')
ylabel('Axial Momenta')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name',strcat(sysname,'_thetas_dot_thetas'),'DefaultAxesFontSize',16)
fprintf('\n')
fprintf('\n')
fprintf('***********************\n')
fprintf(strcat('CAPTION OF Figure ', sysname,'_thetas_dot_thetas:\n'))
fprintf('Evolution in time of the theta coordinates (theta0, and theta1) and velocites \n') 
fprintf('each subplot is showing a theta coordinate in darker line and the corresponding generalized velocity in lighter line.\n')
fprintf('***********************\n')
fprintf('\n')
fprintf('\n')
for ii=1:num_rotational_dof
    subplot(num_rotational_dof,1,ii)
    plot(t,thetas(:,ii),'LineWidth', 2, 'color','w')
    hold on
    grid minor
    plot(t,dot_thetas(:,ii),'LineWidth', 0.5, 'color','r')
    %plot(t,Y(:,(2*ii-1):(2*ii)),'LineWidth', 2, 'color','k')
    %plot(t,Y(:,(2*ii-1):(2*ii)),'LineWidth', 2, 'color','k')
    xlabel('t [s]')
    ylabel(strcat('$\theta$',num2str(ii-1),', $\dot{\theta}$',num2str(ii-1)),'Interpreter','latex')
end









