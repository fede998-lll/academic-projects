close all
clc
format long
FFP6L5R_Robot_Description
r_earth = 6371e3;
h = 500e3;
mu=3.986e14;
k=sqrt(mu/(r_earth+h)^3);
tau=2*pi*sqrt((r_earth+h)^3/mu);
quarter_tau=tau/4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% USER INPUT: Set Initial Configuration of the MBS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t0.theta0=0;                        % Orientation of the base
t0.PV.pos.r0.N=[r_earth+h;0;0];             % Base (Link L0) CoM position
t0.qm1=45*(pi/180);                          % Displacement of the first joint
t0.qm2=0;                           % Displacement of the second joint
t0.qm3=0;                           % Displacement of the third joint
t0.qm4=0;                           % Displacement of the fourth joint
t0.qm5=0;                           % Displacement of the fifth joint
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% USER INPUT: Set Initial Velocity of the MBS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this case we have a number of DOFs equal to 2 and so we will take into
% attention 2 generilized Joints coordinates qm_i
t0.PV.Omega.L0.N.N=[0;0;k];      % Angular velocity of base
t0.PV.dotN.pos.r0.N=[0,sqrt(mu/(r_earth+h)),0]';     % Absolute linear velocity of base COM
t0.dot.qm1=0.02;                       % Speed of the first joint, generalized coordinate
t0.dot.qm2=0.02;                       % Speed of the second joint, generalized coordinate
t0.dot.qm3=0.02;                       % Speed of the third joint, generalized coordinate
t0.dot.qm4=0.02;                       % Speed of the fourth joint, generalized coordinate
t0.dot.qm5=0.02;                       % Speed of the fifth joint, generalized coordinate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% USER INPUT:  SET Control Actions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tau_control_B_Internal_Torque=zeros(3,1);
tau_control_B_External_Force=zeros(3,1);
tau_control_manipulator1=0; 
tau_control_manipulator2=0; 
tau_control_manipulator3=0; 
tau_control_manipulator4=0; 
tau_control_manipulator5=0; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% USER INPUT: Set numerical propagation parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set the fixed integration timestep to 1 second
timestep = 1;

% Calculate the number of desired time intervals
num_intervals = ceil(quarter_tau / timestep);

% Calculate the total propagation time
finaltime = num_intervals * timestep;
timesteps = 0:timestep:finaltime;
propagation_timespan = [0, finaltime];

mytol=1e-15; % relative and absolute tolerance of the propagator
ODEoptions=odeset('RelTol',mytol,'AbsTol',mytol,'Stats','on','NormControl','on');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t0.DCM.L0.N=EulAxAngl2DCM([0;0;1],t0.theta0);  
q_BI_0=DCM2quaternion(t0.DCM.L0.N);   
q_IB_0=quaternion2inversequat(q_BI_0);
Q_B_0=[q_IB_0;t0.PV.pos.r0.N];   
Q_0=[Q_B_0;t0.qm1;t0.qm2;t0.qm3;t0.qm4;t0.qm5];    % [7+n]  elements, with n=5            
uB_0=[t0.PV.Omega.L0.N.N;t0.PV.dotN.pos.r0.N];  
u_0=[uB_0;t0.dot.qm1;t0.dot.qm2;t0.dot.qm3;t0.dot.qm4;t0.dot.qm5];
% Concatenate all previous terms into the initial system state, [23x1] matrix
initial_state=[Q_0;u_0];
JointControlActions=[tau_control_B_Internal_Torque;tau_control_B_External_Force;tau_control_manipulator1;tau_control_manipulator2;tau_control_manipulator3;tau_control_manipulator4;tau_control_manipulator5];
[t_out, state_out] = ode113(@FFP6L5R_odefun_state2dotstate, timesteps, initial_state, ODEoptions, JointControlActions, robot, k, data);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MBB=robot.base_link.mass;
MLL_1=robot.links(1).mass;
MLL_2=robot.links(2).mass;
MLL_3=robot.links(3).mass;
MLL_4=robot.links(4).mass;
MLL_5=robot.links(5).mass;
com=zeros(size(state_out,1),3);
SCMt=zeros(size(state_out,1),2);
C0_t=zeros(size(state_out,1),2);
C1_t=zeros(size(state_out,1),2);
C2_t=zeros(size(state_out,1),2);
C3_t=zeros(size(state_out,1),2);
C4_t=zeros(size(state_out,1),2);
C5_t=zeros(size(state_out,1),2);
Oj1_t=zeros(size(state_out,1),2);
Oj2_t=zeros(size(state_out,1),2);
Oj3_t=zeros(size(state_out,1),2);
Oj4_t=zeros(size(state_out,1),2);
Oj5_t=zeros(size(state_out,1),2);
EE_t_5=zeros(size(state_out,1),2);
MoMt_C0=zeros(size(state_out,1),3);
Linear_Mom_CO=zeros(size(state_out,1),3);
MoMt_OI=zeros(size(state_out,1),3);
h=zeros(size(state_out,1),3);
MoMt_sysC=zeros(size(state_out,1),3);
Axial_MoMm_j1=zeros(size(state_out,1),1);
Axial_MoMm_j2=zeros(size(state_out,1),1);
Axial_MoMm_j3=zeros(size(state_out,1),1);
Axial_MoMm_j4=zeros(size(state_out,1),1);
Axial_MoMm_j5=zeros(size(state_out,1),1);
thetas=zeros(size(state_out,1),6);
dot_thetas=zeros(size(state_out,1),6);
for i=1:length(t_out)
    t=t_out(i);
    state=state_out(i,:)';
    C0_t(i,:)=state(5:6);
    q_IB=state(1:4)/norm(state(1:4)); 
    C_IB=Quaternion2DCM(q_IB);
    [EulerAxis,theta0]=DCM2EulAxAngl_V2(C_IB');
    I_r_B=state(5:7);
    qm=state(8:12);
    thetas(i,:)=[theta0,qm'];
    dot_thetas(i,:)=[state(15),state(19),state(20),state(21),state(22),state(23)];
    uB=state(13:18);
    um=state(19:23);
    [RJ,RL,rJ,rL,e,g]=Kinematics(C_IB,I_r_B,qm,robot);
    C1_t(i,:)=rL(1:2,1)';
    C2_t(i,:)=rL(1:2,2)';
    C3_t(i,:)=rL(1:2,3)';
    C4_t(i,:)=rL(1:2,4)';
    C5_t(i,:)=rL(1:2,5)';
    Oj1_t(i,:)=rJ(1:2,1)';
    Oj2_t(i,:)=rJ(1:2,2)';
    Oj3_t(i,:)=rJ(1:2,3)';
    Oj4_t(i,:)=rJ(1:2,4)';  
    Oj5_t(i,:)=rJ(1:2,5)'; 
    posEEwrt=(RL(:,:,5)*[l5;0;0])';
    EE_t_5(i,:)=C5_t(i,:)+posEEwrt(1:2);
    [Bij,Bi0,P0,pm]=DiffKinematics(C_IB,I_r_B,rL,e,g,robot);
    [tB,tm]=Velocities(Bij,Bi0,P0,pm,uB,um,robot);
    r_com=Center_of_Mass(I_r_B,rL,robot);
    SCMt(i,:)=r_com(1:2)';
    dot_r_com=Center_of_Mass(tB(4:6),tm(4:6,:),robot);
    [I0,Im]=I_I(C_IB,RL,robot);
    [M0_tilde,Mm_tilde]=MCB(I0,Im,Bij,Bi0,robot);
    [H0,H0m,Hm]=GIM(M0_tilde,Mm_tilde,Bij,Bi0,P0,pm,robot);
    Hall=[H0,H0m;H0m',Hm];
    MM_1=(H0*uB+H0m*um)';
    MoMt_C0(i,:)=MM_1(1:3);
    Linear_Mom_CO(i,:)=MM_1(4:6);
    MoMt_OI(i,:)=MoMt_C0(i,:)+((MBB+MLL_1+MLL_2+MLL_3+MLL_4+MLL_5)*SkewSym(I_r_B)*dot_r_com)';
    OC=r_com;
    OC0=I_r_B;
    CC0=OC0-OC;
    h(i,:)=cross(r_com,(MBB+MLL_1+MLL_2+MLL_3+MLL_4+MLL_5)*dot_r_com);
    MoMt_sysC(i,:)=MoMt_C0(i,:)+((MBB+MLL_1+MLL_2+MLL_3+MLL_4+MLL_5)*SkewSym(CC0)*dot_r_com)';
    MM_2=(H0m'*uB+Hm*um)';
    Axial_MoMm_j1(i,:)=MM_2(1);
    Axial_MoMm_j2(i,:)=MM_2(2);
    Axial_MoMm_j3(i,:)=MM_2(3);
    Axial_MoMm_j4(i,:)=MM_2(4);
    Axial_MoMm_j5(i,:)=MM_2(5);
end









