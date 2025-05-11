function [x, y, z] = DK(yaw, roll1, roll2)
    %syms d3 d2 d1 db d4;
    db = 40.5;
    d1 = 43.3;
    d2 = 171.5;
    d3 = 125+115;
    d4 = 25; 
    
    rc = pi/180;
    %alpha = (180-DYN1angle)*rc; 
    %beta = (360-DYN2angle)*rc;
    %gama = DYN3angle*rc;
    %alpha = (180-yaw)*rc; 
    %beta = (360-roll1)*rc;
    %gama = roll2*rc;
    
    alpha =   yaw*rc;
    beta  = roll1*rc;
    gama  = roll2*rc;
    
    %alpha = -25*rc;
    %beta = 26*rc;
    %gama = 75*rc;

    
    % sample angles:
    % -25, 26, 75
    % those angles result in:
    % 281.6543, 131.3376, 167.1490
    
    TEF = [sin(beta+gama) 0 cos(beta+gama) d4*cos(beta+gama);
          0 1 0 0;
          -cos(beta+gama) 0 sin(beta+gama) d4*sin(beta+gama);
          0 0 0 1];
    
    T3E = [-cos(gama) 0 -sin(gama) d3*cos(gama);
          0 1 0 0;
          sin(gama) 0 -cos(gama) -d3*sin(gama);
          0 0 0 1];

    T23 = [-cos(beta) 0 -sin(beta) -d2*cos(beta);
          0 1 0 0;
          sin(beta) 0 -cos(beta) d2*sin(beta);
          0 0 0 1];

    T12 = [0 -sin(alpha) -cos(alpha) 0;
          1 0 0 -d1;
          0 -cos(alpha) sin(alpha) 0;
          0 0 0 1];

    TB1 = [-1 0 0 0;
          0 0 -1 0;
          0 -1 0 db;
          0 0 0 1];
    
    TBE = TB1*T12*T23*T3E*TEF;
    
    coords = [TBE(1, 4) TBE(2, 4) TBE(3, 4)];
    x = coords(1);
    y = coords(2);
    z = coords(3);
end