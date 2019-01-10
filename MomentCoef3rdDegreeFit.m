%calls vectors from fucntions
[MomentCoefVec] = LiftCoefCalc();
[alphaUnique] = ForcesAndMomentCalc();

%deletes moments that experience stall (last 3 elements)
MomentCoefVec = MomentCoefVec(1:end-3);
alphaUnique = alphaUnique(1:end-3);

%finds the coefficients and functions of the n-th degree polynomial fit
MomentCoefPoly = polyfit(alphaUnique,MomentCoefVec,3);
MomentCoefFit = polyval(MomentCoefPoly,alphaUnique);
plot(alphaUnique,MomentCoefFit, alphaUnique, MomentCoefVec, '.');

%plots vectors with proper labels
title('Moment Coefficient vs. Angle of Attack');
xlabel('Angle of Attack (alpha) [degrees]');
ylabel('Moment Coefficient');
legend('3rd Degree Fit', 'Moment Coefficient Data');
