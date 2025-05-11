function [yaw, roll1, roll2] = IK(x, y, z)    
    %syms d4 d3 d2 d1 db;
    %syms alpha beta gama;
    %syms w1 w2 w3;
    rc = 180/pi;
    
    db = 40.5;
    d1 = 43.3;
    d2 = 171.5;
    d3 = 125+115;
    d4 = 25; 
    
    w1 = x;    % desired X coordinate
    w2 = y;    % desired Y coordinate
    w3 = z;    % desired Z coordinate
    % w4=0; w5=0; w6=-1;
    % sample xyz coords:
    % 281.6543, 131.3376, 167.1490
    % --> results in -25, 26, 75
    
    
    
    alpha = atan2(-w2,w1);
    
    h1 = w1*cos(alpha)-w2*sin(alpha);
    h2 = w3 - d1 - db + d4;
    
    gama = acos((h1*h1+h2*h2-d2*d2-d3*d3)/(2*d2*d3)); %zelimo da bude uvijek pozitivna
    
    brojnik = ((d2+d3*cos(gama))*h1 -d3*sin(gama)*h2)/(h1*h1+h2*h2);
    nazivnik = ((d2+d3*cos(gama))*h2 +d3*sin(gama)*h1)/(h1*h1+h2*h2);
    
    if isreal(brojnik) && isreal(nazivnik)
        %disp(brojnik + " / " + nazivnik)
        beta = atan2(brojnik, nazivnik);
        
        alphaP = alpha*rc;
        betaP = beta*rc;
        gamaP = gama*rc;
        
        %{
        if (aplhaP>=-90)&&(aplhaP<=50)
            DYN1angle = 180 - alphaP;
        end
        if (betaP>=0)&&(betaP<=90)
            DYN2angle = 360-betaP;
        end
        if (gamaP>=0)&&(gama<=150)
            DYN3angle = gamaP;
        end
        %}
    
        yaw = alphaP;
        roll1 = betaP;
        roll2 = gamaP;
    else
        yaw = 0;
        roll1 = 0;
        roll2 = 0;
    end

end