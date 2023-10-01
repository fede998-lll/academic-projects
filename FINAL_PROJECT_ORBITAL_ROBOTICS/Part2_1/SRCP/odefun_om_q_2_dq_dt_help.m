%function [dq_dt] = odefun_om_q_2_dq_dt(current_time, q_at_current_time, FUNHANDLE_omega_at_current_time, additionalstructure)

% OROLAB
% (c) Dr. Marcello Romano: written on 2019-04-30
%
%function giving the derivative of the orientation quaternion at the current_time
%reference: Dr. Marcello Romano's Slides
%
% INPUT:
% current_time, SET and PROVIDED BY ODE 45 internally
%
% q_at_current_time, (1,4) matrix, solution at current time, PROVIDED BY
% ODE45 internally 
% (from help ode45
% Function ODEFUN(T,Y) must return a column vector
% corresponding to f(t,y). Each row in the solution array Y corresponds to
% a time returned in the column vector T. To obtain solutions at specific
% times T0,T1,...,TFINAL (all increasing or all decreasing), use 
% TSPAN = [T0 T1 ... TFINAL])    
%
% FUNHANDLE_omega_at_current_time =handle to the function giving omega at
% current time
%
% OPTIONAL INPUT:
% additionalstructure: structure containting values of varbiables possibly
% needed for the computation of the omegas
%
% OUTPUT
% dq_dt = (4,1) matrix of time derivative of quaternion q
% NOTE: ode45 output a matrix (N, 5), where N is the number of integrator's
% time step, column 1 contains the current time at each integrator's time
% step, column 2 to 5 contain for each row, the value of the quaternion at the time in
% first column on that row
%
% (c) Dr. Marcello Romano, April 2019 