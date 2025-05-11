%% -- Algoritam -- plavi, zeleni, zuti %%
function [] = Algoritam(broj)

cam = webcam("Logi C270 HD WebCam");
 % preview video object
    %preview(cam);
    %waitforbuttonpress;
    %stoppreview(cam);
    % start to enable grab
    %start(video_obj);
    img = snapshot(cam);
    %img = img(:, :, (1:3));
    imwrite(img, "real_deal.png")
   % stop(video_obj);

% Poziv funkcije za ekstrakciju centroida svih kocaka koje ona sprema u dva
% arraya x_c i y_c.
% Prvi index (1) u arrayima predstavlja lokaciju za plavu boju, index (2)
% zelena boja, a index (3) predstavlja žutu boju
brick_and_dropzone_processing 

% ovisno o odabiru redoslijeda algoritam ovdje shuffla pozicije centroida
if (broj == 1)
    array_x=[x_c(1) x_c(2) x_c(3)];
    array_y=[y_c(1) y_c(2) y_c(3)];
elseif (broj == 2)
    array_x=[x_c(1) x_c(3) x_c(2)];
    array_y=[y_c(1) y_c(3) y_c(2)];
elseif (broj == 3)
    array_x=[x_c(2) x_c(1) x_c(3)];
    array_y=[y_c(2) y_c(1) y_c(3)];
elseif (broj == 4)
    array_x=[x_c(2) x_c(3) x_c(1)];
    array_y=[y_c(2) y_c(3) y_c(1)];
elseif (broj == 5)
    array_x=[x_c(3) x_c(1) x_c(2)];
    array_y=[y_c(3) y_c(1) y_c(2)];
elseif (broj == 6)
    array_x=[x_c(3) x_c(2) x_c(1)];
    array_y=[y_c(3) y_c(2) y_c(1)];
end

for index=1:3

    u = array_x(index);
    v = array_y(index);
    
    % display position of the object in frame {R}
    [x, y, ~] = pointsToWorld(cameraParams.Intrinsics, R, t, [u v]);
    z = 25;
    [alpha, beta, gama] = IK(x, y, z);
    
    while abs(real_alpha - alpha) > 3 || abs(real_beta - beta) > 3 || abs(real_gama - gama) > 3
        pause(1);
    end
    pause(5);
    
    % prvo odlazak u "neutralnu" poziciju
    x = 100;
    y = 0;
    z = 60;
    [alpha, beta, gama] = IK(x, y, z);
    while abs(real_alpha - alpha) > 3 || abs(real_beta - beta) > 3 || abs(real_gama - gama) > 3
        pause(1);
    end
    
    % lokacija dropoff zone koja se nalazi na indexu (4)
    u = x_c(4);
    v = y_c(4);
    [x, y, ~] = pointsToWorld(cameraParams.Intrinsics, R, t, [u v]);
    z=25;
    [alpha, beta, gama] = IK(x, y, z);
    while abs(real_alpha - alpha) > 3 || abs(real_beta - beta) > 3 || abs(real_gama - gama) > 3
        pause(1);
    end
    pause(10);
    
    % povratak u "neutralnu" poziciju
    x = 100;
    y = 0;
    z = 60;
    [alpha, beta, gama] = IK(x, y, z);
    while abs(real_alpha - alpha) > 3 || abs(real_beta - beta) > 3 || abs(real_gama - gama) > 3
        pause(1);
    end

end

pause(2);