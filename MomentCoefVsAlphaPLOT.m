%calls correct vectos from other functions
[MomentCoefVec] = MomentCoefCalc();
[alphaUnique] = ForcesAndMomentCalc();

%plots vectors against one another and adds labels
plot(alphaUnique, MomentCoefVec,'.');
title('Moment Coefficient About Quartered Cord vs. Angle of Attack');
xlabel('Angle of Attack (alpha) [degrees]');
ylabel('Moment Coefficient About Quartered Cord');
