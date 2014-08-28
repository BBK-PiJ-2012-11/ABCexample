function [A bcells] = systemMatrix(dt,v,routesID,routeDistance)
%returns the system matrix A and the boundary cells for each route
 
routeDistance = routeDistance';
 %route_distance MUST be a column vector [x,x,x,...]
 %dt = Time step in minutes
 %v = Aircraft speed in knots

 %changing the speed to nautic miles per minute
 v = v/60;
%Matrix creation

%Cells per route. The +1 is for the initial cell. Multiplies the velocite
%per dt to know the size in miles of each cell
cellSize = v*dt;
cellsRoute = ceil(routeDistance/(cellSize)) + 1;

%initialize the system matrix A to 0s
A = zeros(sum(cellsRoute));
%initialize the boundaries cells matrix
bcells = zeros(size(routeDistance),2);


    %Create the system matrix A
    for i = 1:size(cellsRoute,2)

        %Creates a diagonal matrix of 1s that will append to the correspondent
        %part of the matrix 
        D = eye(cellsRoute(i)-1);
        size(D);


        %this loop will set the 1s for this route on its proper position at the
        %System matrix
        pos = 1;
        if(i~=1)
            for j = 1:(i-1)
               pos = pos + cellsRoute(j);
            end
        end
        bcells(i,:)=[pos pos+cellsRoute(i)-1];

        %Adds the 1 at the end of the matrix to accumulate the airplanes at the
        %destination
        A(pos+cellsRoute(i)-1,pos+cellsRoute(i)-1) = 1;
        %Puts the 1s matrix into its pertinent place inside the system matrix
        A(pos+1:pos+cellsRoute(i)-1,pos:pos+cellsRoute(i)-2) = D;

    end
bcells = [routesID bcells];
end