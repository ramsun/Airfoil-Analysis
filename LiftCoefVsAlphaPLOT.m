%calls vectors
[LiftCoefVec] = LiftCoefCalc();
[alphaUnique] = ForcesAndMomentCalc();

%creates plot with proper labels
plot(alphaUnique, LiftCoefVec , '.');
title('Lift Coefficient vs. Angle of Attack');
xlabel('Angle of Attack (alpha) [degrees]');
ylabel('Lift Coefficient');
