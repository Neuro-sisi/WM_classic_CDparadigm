function [positionscale] = T368_CHANGE2POSITION(deg,cir_width,center)
deg_jit(:,1) = randsample([-3:-1 1:3],4);
deg_jit(:,2) = randsample([-3:-1 1:3],4);
deg_jit(:,3) = randsample([-3:-1 1:3],4);
for m = 1:length(cir_width);
    for n = 1:length(deg);
        if deg(n,m)+deg_jit(n,m) < 90
            positionscale(n+4*(m-1),:) = [center(1)+sind(deg(n,m)+deg_jit(n,m))*cir_width(m),center(2)-cosd(deg(n,m)+deg_jit(n,m))*cir_width(m)];
        else if deg(n,m)+deg_jit(n,m) >= 90 && deg(n,m)+deg_jit(n,m) < 180
                positionscale(n+4*(m-1),:) = [center(1)+sind(180 - (deg(n,m)+deg_jit(n,m)))*cir_width(m),center(2)+cosd(180 - (deg(n,m)+deg_jit(n,m)))*cir_width(m)];
            else if deg(n,m)+deg_jit(n,m) >=180 && deg(n,m)+deg_jit(n,m) < 270
                    positionscale(n+4*(m-1),:) = [center(1)-sind(deg(n,m)+deg_jit(n,m) - 180)*cir_width(m),center(2)+cosd(deg(n,m)+deg_jit(n,m) - 180)*cir_width(m)];
                else if deg(n,m)+deg_jit(n,m) >= 270
                        positionscale(n+4*(m-1),:) = [center(1)-sind(360 - (deg(n,m)+deg_jit(n,m)))*cir_width(m),center(2)-cosd(360 - (deg(n,m)+deg_jit(n,m)))*cir_width(m)];
                    end
                end
            end
        end
    end
end
end