% function [q_otimes_Mat_Left]=Matrix_QuatProd_Left(q)
% Computes the matrix form of the quaternion product q?p=[q]p
%
% Quaternion convention q=[q_vector;q_scalar] (4x1 column vector)
% --- SCALAR PART LAST ---
%
% Inputs:
%   q -> Quaternion
%
% Outputs:
%   q_otimes_Mat -> Matricial form of the quaternion product q?p=[q]p
