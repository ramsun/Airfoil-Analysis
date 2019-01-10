%calls vectors
[LiftCoefVec] = LiftCoefCalc();
[DragCoefVec] = DragCoefCalc();

%deletes last 3 elements of LiftCoefVec, since those angles make the
%aircraft experience stall
LiftCoefVec = LiftCoefVec(1:end-3);
DragCoefVec = DragCoefVec(1:end-3);

%performs a quadratic fit.
DragPolarPoly = polyfit(DragCoefVec,LiftCoefVec,2);
DragPolarFit = polyval(DragPolarPoly,DragCoefVec);
plot(DragCoefVec,DragPolarFit, DragCoefVec, LiftCoefVec, '.');

%provides proper labels and legend
title('Lift Coefficient vs. Drag Coefficient');
xlabel('Drag Coefficient');
ylabel('Lift Coefficient');
legend('2nd Degree Fit', 'Drag Polar Data');
