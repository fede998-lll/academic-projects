%function DCM_BA = elementaryrot2DCM(sharedaxis, angle)

% OROLAB, 2023
%(c) Marcello Romano, 2019-04-23
%
% INPUT: sharedaxis = 1, 2 or 3
%        angle = scalar [rad]
%
% OUTPUT THE DCM_BA corresponding to an elementary rotation of a given angle, 
% i.e. to the DCM_BA describing the orientation of a CCS B obtained
% from an initial situation of B0 coincident with A, 
% by rotating of an amount equal to the given angle about one of the three axes 