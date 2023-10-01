%function control_torque = state2ACtorque_quatfeedback(current_state, attitude_control_info)

% OROLAB
% (C) Dr. MARCELLO ROMANO 20230403
% Implemente quaternion feedback control: see slides
%
% Input: 
% current_state: [BomegaBN; qBN] at current time
% attitude_control_info
%   Structure containing  
%        attitude_control_info.QF_k: positive Real Number: quat feedback gain
%        attitude_control_info.QF_C: diagonal matrix of positive RNs: quat
%        feedback gain
%        attitude_control_info.norm_maxtorque: 3 by one matrix with max
%        norm of values of torque components in B
%        attitude_control_info.norm_maxtorque: 3 by one matrix with max
%        norm of values of torque components in B
%        attitude_control_info.qd: desired value of orientation quaternion
% Output: 
%       control_torque: 3 by 1 matrix of requested external control torque component in B
%        
