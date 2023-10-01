% function [branch,child,child_base]=ConnectivityMap(robot)
% Produces the connectivity map for a robot model.
%
% [branch,child,child_base]=ConnectivityMap(robot)
%
% :parameters:
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return:
%   * branch -- Branch connectivity map. This is a [nxn] lower triangular matrix. If the i,j element is 1 it means that the ith and jth link are on the same branch. 
%   * child -- A [nxn] matrix. If the i,j element is 1, then the ith link is a child of the jth link.
%   * child_base -- A [nx1] matrix. If the ith element is 1, the ith link is connected to the base-link.
%
% See also: :func:`src.robot_model.urdf2robot` and :func:`src.robot_model.DH_Serial2robot`.