% function DCM = Angles321_DCM(Angles)
% Convert the Euler angles (321 sequence), x-phi, y-theta, z-psi to its DCM equivalent.
%
% DCM = Angles321_DCM(Angles)
%
% :parameters: 
%   * Angles -- Euler angles [x-phi, y-theta, z-psi] -- [3x1].
%
% :return: 
%   * DCM -- Direction Cosine Matrix -- [3x3].
%
% See also: :func:`src.attitude_transformations.Angles123_DCM` and :func:`src.attitude_transformations.DCM_Angles321`.
