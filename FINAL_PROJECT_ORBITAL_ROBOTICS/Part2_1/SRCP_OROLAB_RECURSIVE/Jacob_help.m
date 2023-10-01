% function [J0, Jm]=Jacob(rp,r0,rL,P0,pm,i,robot)
% Computes the geometric Jacobian of a point `p`.
%
% [J0, Jm]=Jacob(rp,r0,rL,P0,pm,i,robot)
% 
% :parameters: 
%   * rp -- Position of the point of interest, projected in the inertial CCS -- [3x1].
%   * r0 -- Position of the base-link, projected in the inertial CCS -- [3x1].
%   * rL -- Positions of the links, projected in the inertial CCS -- as a [3xn] matrix.
%   * P0 -- Base-link twist-propagation "vector" -- as a [6x6] matrix.
%   * pm -- Manipulator twist-propagation "vector" -- as a [6xn] matrix.
%   * i -- Link id where the point `p` is located -- int 0 to n.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   * J0 -- Base-link geometric Jacobian -- [6x6].
%   * Jm -- Manipulator geometric Jacobian -- [6xn_q].
%
% Examples:
%
%   To compute the velocity of the point `p` on the ith link:
%
% .. code-block:: matlab
%   
%   %Compute Jacobians
%   [J0, Jm]=Jacob(rp,r0,rL,P0,pm,i,robot);
%   %Twist of that point
%   tp=J0*u0+Jm*um;
%
% See also: :func:`src.kinematics_dynamics.Kinematics`, :func:`src.kinematics_dynamics.DiffKinematics`