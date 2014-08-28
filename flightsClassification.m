function [internalFlights,enteringFlights,exitingFlights,transitingFlights,v] = flightsClassification(region,filename)
    %Introduce the Center included in our model. 
    %region as {'ZB' 'ZC' 'ZD'}
    %filename as 'Flight list.xlsx')
    %RETURNS: internal, entering, exiting and transiting Flights, and the
    %average speed of all the flights. 

   
    %Reads the info of the flights and the Airport - Center pairing

    [ndata,text,rawFlights] = xlsread(filename);
    clearvars ndata text;

    %Initializing classification of flights

    internalFlights = [];
    enteringFlights = [];
    exitingFlights = [];
    transitingFlights = [];
  %  v = 0;
    
    %classify flights on Internal, Entering, Exiting and Transiting
    for i=2:size(rawFlights)
        originIn = false;
        destinationIn = false;
        transitionIn = false;
        
        for j=1:size(region,2)
            if strcmp(rawFlights(i,5),region(j))

                originIn = true;
                break;
            end
        end
        for j=1:size(region,2)
            if strcmp(rawFlights(i,6),region(j))
                destinationIn = true;
                break;
            end    
        end
    %TODO this must be improved to allow more than one transition center
        for j=1:size(region,2)
            if strcmp(rawFlights(i,7),region(j))
                transitionIn = true;
                break;
            end        
        end 


        if originIn & destinationIn   
            internalFlights = [internalFlights;rawFlights(i,:)];
        elseif originIn
           exitingFlights = [exitingFlights;rawFlights(i,:)];
        elseif destinationIn
           enteringFlights = [enteringFlights;rawFlights(i,:)];
        elseif transitionIn==true
           transitionFlights = [transitionFlights;rawFlights(i,:)];
        end
    %v = v + int(rawFlights(i,4));   
    end
    %v = v/(size(rawFlights,1)-1);
    
    v=mean(cell2mat(rawFlights(2:size(rawFlights,1),4)));
end


           
        