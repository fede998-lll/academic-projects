function [q] = QuaternionProduct(q1,q2)
% Computes the product between two quaternions q=q1?q2
%
% Quaternion convention q=[q_vector;q_scalar] (4x1 column vector)
% --- SCALAR PART LAST ---
%
% Inputs:
%   q1 -> quaternion
%   q2 -> quaternion
%
% Outputs:
%   q -> quaternion product q=q1?q2