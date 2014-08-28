function [rID,rD] = routeDistance(filename)
    %Returns a matrix of the form [RouteID routeDistance]
    [ndata,text,routeList] = xlsread(filename);
    clearvars ndata text;
    %Position 4 of the list should be the TOTAL DISTANCE in nm
    rID = cell2mat(routeList(2:size(routeList,1),1));
    rD = cell2mat(routeList(2:size(routeList,1),4));
end