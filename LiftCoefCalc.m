%function calculates the lift coefficients of the data
function [LiftCoefVec] = LiftCoefCalc()

%calls the 2 vectors from ForcesAndMomentCalc(
[alphaUnique, ForcesMatrix] = ForcesAndMomentCalc();

%defines constant values
density = 1.2; % kgm^-3
velocity = 60; % m/s
cordLength = 1;% m
LiftCoefVec = zeros(1,length(alphaUnique));

%loops through and calculates the lift from the ForcesMatrix.  The lift is
%used to calculate the drag coefficient at that angle of attack
counter = 1;
while counter <= length(alphaUnique)
    lift = (-ForcesMatrix(1,counter) * (sin(alphaUnique(counter) * ...
        pi/180))) + (ForcesMatrix(2,counter) * cos(alphaUnique(counter)*...
        pi/180));
    LiftCoef = lift/(0.5 * density * velocity^2 * cordLength);
    LiftCoefVec(counter) = LiftCoef; 
    counter = counter+1;
end

end