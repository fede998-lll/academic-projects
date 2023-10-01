% function [H]=GIM_NOC(N,I0,Im,robot)
% Computes the Generalized Inertia Matrix (GIM) H of the multibody vehicle.
%
% This function is LESS EFFICENT that the :func:`src.kinematics_dynamics.GIM` function, as it doesn't use the recursive algorithms. 
%
% [H]=GIM_NOC(N,I0,Im,robot)
%
% :parameters: 
%   * N -- Natural Orthogonal Complement (NOC) matrix -- a [(6+6*n)x(6+n_q)] matrix.
%   * I0 -- Base-link inertia matrix, projected in the inertial CCS -- as a [3x3] matrix.
%   * Im -- Links inertia matrices, projected in the inertial CCS -- as a [3x3xn] matrix.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%
%   * H -- Generalized Inertia Matrix -- as a [(6+n_q)x(6+n_q)] matrix.
%
% See also: :func:`src.kinematics_dynamics.GIM_NOC`.
