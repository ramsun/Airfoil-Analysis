%function calculates the drag coefficients of the data
function [DragCoefVec] = DragCoefCalc()

%calls the 2 vectors from ForcesAndMomentCalc(
[alphaUnique, ForcesMatrix] = ForcesAndMomentCalc();

%constant values are defined
density = 1.2; % kgm^-3
velocity = 60; % m/s
cordLength = 1;% m
DragCoefVec = zeros(1,length(alphaUnique));

%loops through and calculates the drag from the ForcesMatrix.  The drag is
%used to calculate the drag coefficient at that angle of attack
counter = 1;
while counter <= length(alphaUnique)
    drag = (ForcesMatrix(1,counter) * (cos(alphaUnique(counter) * ...
        pi/180))) + (ForcesMatrix(2,counter) * sin(alphaUnique(counter)*...
        pi/180));
    LiftCoef = drag/(0.5 * density * velocity^2 * cordLength);
    DragCoefVec(counter) = LiftCoef; 
    counter = counter+1;
end

end

