%function calculates the moment coefficients of the data about the
%quartered cord
function [MomentCoefVec] = MomentCoefCalc()

%calls the 3 vectors from ForcesAndMomentCalc(
[alphaUnique, ForcesMatrix, MomentVec] = ForcesAndMomentCalc();

%constant values are defined
density = 1.2; % kgm^-3
velocity = 60; % m/s
cordLength = 1;% m
MomentCoefVec = zeros(1,length(alphaUnique));

%loops through and calculates the Moments from the MomentVec. The moment is
%used to calculate the moment coefficient at that angle of attack
counter = 1;
while counter <= length(alphaUnique)
    MomentCoef = MomentVec(counter)/(0.5 * density * velocity^2 *...
        cordLength^2);
    MomentCoefVec(counter) = MomentCoef; 
    counter = counter+1;
end

end