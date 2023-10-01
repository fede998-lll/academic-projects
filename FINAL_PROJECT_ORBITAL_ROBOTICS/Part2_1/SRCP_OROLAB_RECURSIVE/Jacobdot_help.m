% function [J0dot, Jmdot]=Jacobdot(rp,tp,r0,t0,rL,tL,P0,pm,i,robot)
% Computes the geometric Jacobian time-derivative of a point `p`.
%
% [J0dot, Jmdot]=Jacobdot(rp,tp,r0,t0,rL,tL,P0,pm,i,robot)
%
% :parameters: 
%   * rp -- Position of the point of interest, projected in the inertial CCS -- [3x1].
%   * tp -- Twist of the point of interest [\omega,rdot], projected in the intertial CCS -- [6x1].
%   * r0 -- Position of the base-link center-of-mass with respect to the origin of the inertial frame, projected in the inertial CCS -- [3x1].
%   * t0 -- Base-link twist [\omega,rdot], projected in the inertial CCS -- as a [6x1] matrix.
%   * rL -- Positions of the links, projected in the inertial CCS -- as a [3xn] matrix.
%   * tL -- Manipulator twist [\omega,rdot], projected in the inertial CCS -- as a [6xn] matrix.
%   * P0 -- Base-link twist-propagation "vector" -- as a [6x6] matrix.
%   * pm -- Manipulator twist-propagation "vector" -- as a [6xn] matrix.
%   * i -- Link id where the point `p` is located -- int 0 to n.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   * J0dot -- Base-link Jacobian time-derivative -- as a [6x6] matrix.
%   * Jmdot -- Manipulator Jacobian time-derivative -- as a [6xn_q] matrix.
%
% Examples:
%
%   To compute the acceleration of a point ``p`` on the ith link:
%
% .. code-block:: matlab
%   
%   %Compute Jacobians
%   [J0, Jm]=Jacob(rp,r0,rL,P0,pm,i,robot);
%   Compute Jacobians time-derivatives
%   [J0dot, Jmdot]=Jacobdot(rp,tp,r0,t0,rL,tL,P0,pm,i,robot)
%   %Twist-rate of that point
%   tpdot=J0*u0dot+J0dot*u0+Jm*umdot+Jmdot*um;
%
% See also: :func:`src.kinematics_dynamics.Accelerations` and :func:`src.kinematics_dynamics.Jacob`. 