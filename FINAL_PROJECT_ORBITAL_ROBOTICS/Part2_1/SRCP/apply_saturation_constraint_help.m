% function saturatedmatrix = apply_saturation_constraint(inputmatrix, saturationlevels)
%
% OROLAB
% (c) Dr. Marcello Romano: written on 2019-10-01
%
% Ouptut a saturated version of inputmatrix, that is saturated at levels given by saturationlevels
%
% INPUTS
% inputmatrix, (3,1) matrix of real numbers
% saturationlevels, (3,1) matrix of positive real numbers
% 
% OUTPUTS
% saturatedmatrix, (3,1) matrix of real numbers, whose elements are equal to the elements of inputmatrix, if they satisfy the saturation constraint,
% or to values on the boundary of the saturation constraints 
