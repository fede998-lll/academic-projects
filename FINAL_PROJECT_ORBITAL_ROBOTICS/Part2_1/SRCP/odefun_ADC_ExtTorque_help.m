%function [dot_state] = odefun_ADC_ExtTorque(current_time, current_state, AC_controllaw, inertia_matrix, attitude_control_info)

% OROLAB
% (c) Dr. Marcello Romano: written on 2019-10-07
% function implementing the attitude dynamics (Euler's Equations Governing the Rotational
% Dynamics of a Rigid Body) and attitude kinematics (differential kinematics
% equation for quaternions)
%
% INPUT:
% current_time, SET and PROVIDED BY ODE 45 internally
%
% current_state = [BOmegaBN; qBN] solution at current time, PROVIDED BY
% ODE45 internally 
% (from help ode45
% Function ODEFUN(T,Y) must return a column vector
% corresponding to f(t,y). Each row in the solution array Y corresponds to
% a time returned in the column vector T. To obtain solutions at specific
% times T0,T1,...,TFINAL (all increasing or all decreasing), use 
% TSPAN = [T0 T1 ... TFINAL])    
%

% AC_controllaw = pointer to a function that compute the attitude control
% torque takin as input the current state and the structure attitude_control_info
%
% inertia_matrix: Spacecraft central inertia matrix in CVB B
%
% attitude_control_info: structure passed to BexternalControltorque
% function
%
% OUTPUT
% dot_state=[dot_BomegaBN;dot_qBN]
%   dBomegaBN_dt =  (3,1) matrix of time derivative of angular velocity 
%   dot_qBN = (4,1) matrix of time derivative of qBN
%
%
% NOTE: ode45 output a matrix (N, 8), where N is the number of integrator's
% time step, column 1 contains the current time at each integrator's time
% step, column 2 to 4 contain for each row, the value of BomegaBN at the time in
% first column on that row, colum 5 to 8 contain for earch row, the value
% of qBN at the time in first column on that row
%
% (c) Dr. Marcello Romano, May 2019, April 2023