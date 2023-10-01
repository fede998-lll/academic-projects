% function [C]=CIM_NOC(N,Ndot,t0,tL,I0,Im,robot)
% Computes the generalized Convective Inertia Matrix C of the multibody system.
%
% This function is LESS EFFICENT that the :func:`src.kinematics_dynamics.CIM` function, as it doesn't use the recursive algorithms. 
%
% [C]=CIM_NOC(N,Ndot,t0,tL,I0,Im,robot)
%
% :parameters: 
%   * N -- Natural Orthogonal Complement (NOC) matrix -- a [(6+6*n)x(6+n_q)] matrix.
%   * Ndot -- Natural Orthogonal Complement (NOC) matrix time-derivative -- as a [(6+6*n)x(6+n_q)] matrix.
%   * t0 -- Base-link twist [\omega,rdot], projected in the inertial CCS -- as a [6x1] matrix.
%   * tL -- Manipulator twist [\omega,rdot], projected in the inertial CCS -- as a [6xn] matrix.
%   * I0 -- Base-link inertia matrix, projected in the inertial CCS -- as a [3x3] matrix.
%   * Im -- Links inertia matrices, projected in the inertial CCS -- as a [3x3xn] matrix.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   C -> Generalized Convective Inertia Matrix -- as a [(6+n_q)x(6+n_q)] matrix.
%
%  See also: :func:`src.kinematics_dynamics.CIM_NOC`.
