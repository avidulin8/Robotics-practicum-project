function goNeutral(real_alpha, real_beta, real_gama)
    % povratak u "neutralnu" poziciju
    x = 100;
    y = 0;
    z = 60;
    [alpha, beta, gama] = IK(x,y,z);
    while abs(real_alpha - alpha) > 3 || abs(real_beta - beta) > 3 || abs(real_gama - gama) > 3
        pause(1);
    end
end