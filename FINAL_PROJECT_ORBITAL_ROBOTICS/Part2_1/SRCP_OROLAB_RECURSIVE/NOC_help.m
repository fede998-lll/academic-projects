% function [N] = NOC(r0,rL,P0,pm,robot)
% Computes the Natural Orthogonal Complement (NOC) matrix (generalized Jacobian).
%
% [N] = NOC(r0,rL,P0,pm,robot)
%
% :parameters: 
%   * r0 -- Position of the base-link, projected in the inertial CCS -- [3x1].
%   * rL -- Positions of the links, projected in the inertial CCS -- as a [3xn] matrix.
%   * P0 -- Base-link twist-propagation "vector" -- as a [6x6] matrix.
%   * pm -- Manipulator twist-propagation "vector" -- as a [6xn] matrix.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   * N -- Natural Orthogonal Complement (NOC) matrix -- a [(6+6*n)x(6+n_q)] matrix.
%
% Examples:
%
%   To compute the velocities of all links:
%
% .. code-block:: matlab
%	
%   %Compute NOC.
%   [N] = NOC(r0,rL,P0,pm,robot)
%   %Generalized twist (concatenation of the twist of all links).
%   t=N*[u0;um];
%   %Twist of the base-link
%   t0=t(1:6,1);
%   %Twist of the ith link
%   i=2;
%   ti=t(6*i:6+6*i,1);
%
% See also: :func:`src.kinematics_dynamics.Jacob` and :func:`src.kinematics_dynamics.NOCdot`. 
