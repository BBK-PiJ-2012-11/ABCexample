function A = systemMatrix(dt,v,route_distance)

 %dt = Time step in minutes
 %v = Aircraft speed in miles/minute
 
%Matrix creation

%Cells per route. The +1 is for the initial cell
cells_route = ceil(route_distance/v) + 1;

%initialize the system matrix A to 0s
A = zeros(sum(cells_route));

%Create the system matrix A
for i = 1:size(cells_route,2)
    i
    %Creates a diagonal matrix of 1s that will append to the correspondent
    %part of the matrix 
    D = eye(cells_route(i)-1);
    size(D);

    
    %this loop will set the 1s for this route on its proper position at the
    %System matrix
    pos = 1;
    if(i~=1)
        for j = 1:(i-1)
           pos = pos + cells_route(j)
        end
    end
    %Adds the 1 at the end of the matrix to accumulate the airplanes at the
    %destination
    A(pos+cells_route(i)-1,pos+cells_route(i)-1) = 1;
    %Puts the 1s matrix into its pertinent place inside the system matrix
    A(pos+1:pos+cells_route(i)-1,pos:pos+cells_route(i)-2) = D;
    
end
