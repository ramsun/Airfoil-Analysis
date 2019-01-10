%plots the lift coeficcient vs drag coefficient vectors.  This graph is
%known as a drag-polar graph

%calls vectors from previous functions
[LiftCoefVec] = LiftCoefCalc();
[DragCoefVec] = DragCoefCalc();

%plots drag polar with proper axis
plot(DragCoefVec,LiftCoefVec, '.');
title('Lift Coefficient vs. Drag Coefficient (Drag Polar)');
xlabel('Drag Coefficient');
ylabel('Lift Coefficient');