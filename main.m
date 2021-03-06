%main
%Input data:

region = {'ZB' 'ZC' 'ZD'};
flightsFilename = 'FlightList.xlsx';
routesFilename = 'RouteList.xlsx';
[routesID routesDistance] = routeDistance(routesFilename);
%desired time step in minutes
dt = 5;

%1st obtain the classification of the flights

[internalFlights,enteringFlights,exitingFlights,transitingFlights,v] = ...
    flightsClassification(region,flightsFilename);

%2nd obtain the system matrix

%A = system matrix
%bcells = boundary cells for each route

[A bcells] = systemMatrix(dt,v,routesID,routesDistance);

cellSize = dt*v/60;



