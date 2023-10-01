
%function [cK] = VectProdMatrixForm(aK,bK)

% OROLAB 2023
% (c) Dr. Marcello Romano on 2021-10-05
%
% INPUT
% aK = [3,1 matrix of real numbers] = components of Euclidean vector a in a CCS K 
% bK = [3,1 matrix of real numbers] = components of Euclidean vector b in a CCS K
%
% OUTPUT
% cK = [3,1 matrix of real numbers] = components of Euclidean vector c in a CCS K, 
% where the vector c is the result of a vector cross product between vector a and vector b, i.e. c = a X b 
%
% This function is equivalent but numerically more efficient (involving less operations) than performing the same
% operation as ck= VectProdMatrix(aK)*bK

