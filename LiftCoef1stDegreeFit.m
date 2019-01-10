%calls vectors
[LiftCoefVec] = LiftCoefCalc();
[alphaUnique] = ForcesAndMomentCalc();

%deletes last 3 elements of LiftCoefVec, since those angles make the
%aircraft experience stall
LiftCoefVec = LiftCoefVec(1:end-3);
alphaUnique = alphaUnique(1:end-3);

%finds the polynomial coefficients and the nth-degree fit vector
LiftCoefPoly = polyfit(alphaUnique,LiftCoefVec,1);
LiftCoefFit = polyval(LiftCoefPoly,alphaUnique);
plot(alphaUnique,LiftCoefFit, alphaUnique, LiftCoefVec, '.');

%creates the plot of the vectors against one another
title('Lift Coefficient vs. Angle of Attack');
xlabel('Angle of Attack (alpha) [degrees]');
ylabel('Lift Coefficient');
legend('1st Degree Fit', 'Lift Coefficient Data');

