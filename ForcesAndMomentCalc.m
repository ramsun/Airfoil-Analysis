%this function, while not directly taking inputs, gets values from
%sensors.txt and data.txt.  It then calculates 
function [alphaUnique, ForcesMatrix, MomentsVec] = ForcesAndMomentCalc()

%loads in data files
SensorLocationsMatrix = load('sensors.txt');
DataMatrix = load('data.txt'); 

%initialization of size of respective matrices
%corresponding sensor number is simply the index
AngleVec = DataMatrix(:,2);
PressureVec = DataMatrix(:,3);
ShearStressVec = DataMatrix(:,4);
xLocationVec = SensorLocationsMatrix(:,2);
yLocationVec = SensorLocationsMatrix(:,3);

%finds the total number of sensors, the unique angle types, total
%calculations to perform, and initializes moment and force totals to 0
NumSensors = length(xLocationVec);
alphaUnique = unique(AngleVec);
alphaUnique = alphaUnique.';
TotalCalcs = length(PressureVec);
MomentArmLocation = [0.25, 0];
Ftotal = 0;
Mtotal = 0;

%initializes force and moment matrices
ForcesMatrix = zeros(2,length(alphaUnique));
MomentsVec = zeros(1,length(alphaUnique));

%counters for matrix indexes 
LocationCount = 1;
TotalCount = 1;
ForcesMatrixCounter = 1;
%loops through the rest of the vectors and calculates the total force
while (TotalCount <= TotalCalcs)
    %calculates the force on the first sensor.  Done because its previous 
    %reference point is the trailing edge, which is not in the data file
    if LocationCount == 1
        %calculates the force and other corresponding values for sensor 1
        %We put the trailing edge at the point (1,0)
        xA = 0.5*(xLocationVec(1) + 1);
        xB = 0.5*(xLocationVec(1) + xLocationVec(2));
        yA = 0.5*(yLocationVec(1) + 0);
        yB = 0.5*(yLocationVec(1) + yLocationVec(2));
        
        %finds the length of the sensor
        delS = sqrt((xB - xA)^2 + (yB - yA)^2); 
        
        %calculation of each component of the tangent vector
        tix = (xB - xA)/delS;
        tiy = (yB - yA)/delS;
        tiVec = [tix  tiy];
        tiVec = tiVec.';
        
        %calculation of each component of the normal vector
        nix = tiy;
        niy = -tix;
        niVec = [nix niy];
        niVec = niVec.';
        
        %calculaion of force
        Fi = (PressureVec(TotalCount) * niVec + ShearStressVec(TotalCount) * tiVec)...
        * delS;
   
        %calculation of the moment at particular sensor.  Sensor location
        %is first put into a vector
        SensorLocation = [xLocationVec(LocationCount), yLocationVec(LocationCount)];
        %MATLAB can easily do a crossproduct in 3 dimensions, but making 
        %our vectors 3 dimensional(with the 3rd dimension being 0) is
        %unnecessary.  Instead, we will use the determinent equation:
        %Ux*Vy-Uy*Vx
        %U will be the sensor location minus the moment arm location and
        %V will be the force vector divided by dels at the sensor
        U = (SensorLocation-MomentArmLocation);
        V = (PressureVec(TotalCount) * niVec + ShearStressVec(TotalCount) * tiVec);
        CrossProduct = U(1) * V(2) - U(2) * V(1);
        Mi = abs(CrossProduct) * delS;
        
        %increments index to the next sensor
        LocationCount = LocationCount + 1;
    
    elseif LocationCount > 1 && LocationCount < NumSensors
        xA = 0.5*(xLocationVec(LocationCount) + xLocationVec(LocationCount-1));
        xB = 0.5*(xLocationVec(LocationCount) + xLocationVec(LocationCount+1));
        yA = 0.5*(yLocationVec(LocationCount) + yLocationVec(LocationCount-1));
        yB = 0.5*(yLocationVec(LocationCount) + yLocationVec(LocationCount+1));        
        delS = sqrt((xB - xA)^2 + (yB - yA)^2);
        
        tix = (xB - xA)/delS;
        tiy = (yB - yA)/delS;
        tiVec = [tix  tiy];
        tiVec = tiVec.';
        
        nix = tiy;
        niy = -tix;
        niVec = [nix niy];
        niVec = niVec.';
        
        Fi =(PressureVec(TotalCount) * niVec + ShearStressVec(TotalCount)... 
        * tiVec) * delS;
       
        SensorLocation = [xLocationVec(LocationCount), yLocationVec(LocationCount)];
        U = (SensorLocation-MomentArmLocation);
        V = (PressureVec(TotalCount) * niVec + ShearStressVec(TotalCount) * tiVec);
        CrossProduct = U(1) * V(2) - U(2) * V(1);
        Mi = abs(CrossProduct) * delS;
        
        LocationCount = LocationCount + 1;
    %calculates the force on the last sensor right before the
    %trailing edge
    elseif  LocationCount == NumSensors
        xA = 0.5*(xLocationVec(end) + xLocationVec(end-1));
        xB = 0.5*(xLocationVec(end) + 1);
        yA = 0.5*(yLocationVec(end) + yLocationVec(end));
        yB = 0.5*(yLocationVec(end-1) + 0);
        delS = sqrt((xB - xA)^2 + (yB - yA)^2);
        
        tix = (xB - xA)/delS;
        tiy = (yB - yA)/delS;
        tiVec = [tix  tiy];
        tiVec = tiVec.';
        
        nix = tiy;
        niy = -tix;
        niVec = [nix niy];
        niVec = niVec.';
        
        Fi =(PressureVec(end) * niVec + ShearStressVec(end) * tiVec)...
        * delS;
    
        SensorLocation = [xLocationVec(LocationCount), yLocationVec(LocationCount)];
        U = (SensorLocation-MomentArmLocation);
        V = (PressureVec(TotalCount) * niVec + ShearStressVec(TotalCount) * tiVec);
        CrossProduct = U(1) * V(2) - U(2) * V(1);
        Mi = abs(CrossProduct) * delS;
        
        Ftotal = Ftotal + Fi;
        Mtotal = Mtotal + Mi;
        %appends to the force vector
        ForcesMatrix(1:2,ForcesMatrixCounter) = Ftotal;
        %appends to moments vector
        MomentsVec(ForcesMatrixCounter) = Mtotal;
        %resets total forces for said angle and increases force matrix index
        ForcesMatrixCounter = ForcesMatrixCounter + 1;
        Ftotal = [0;0];
        Mtotal = 0;
        Fi = 0;
        Mi = 0;
        LocationCount = 1;
    end
    %increments the totalcount and adds to m and f total
    TotalCount = TotalCount + 1;
    Ftotal = Ftotal + Fi;
    Mtotal = Mtotal + Mi;
end

end



