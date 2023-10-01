% function [quaternion_BA]=EulAxAngl2quaternion(EulerAxis, EulerAngle);

% OROLAB 2023
% (c) Dr. Marcello Romano: written on 2019-04-15
% Ref: 3815 Unit 2 Slides, Marcello Romano, 2019
%
% INPUTS
% EulerAxis = [3,1 matrix of real numbers] = COMPONENTS of the
% Euler axis unit vector of relative orientation of CCS B w.r.t. CCS A ALONG 
% either CCS A or CCS B (they are the same!)
% EulerAngle = [1 real number] = Euler angle in radians of the relative 
% orientation of CCS B w.r.t. CCS A  
% 
% 
% OUTPUTS
% quaternion_BA = [4,1 matrix of real numbers satifying constraint norm(Quaternion_BA)=1]
% with 4th element (scalar element) >=0, i.e. "short angle" quaternion
% among the two possible orientation quaternions corresponding to the same
% Orientation
%