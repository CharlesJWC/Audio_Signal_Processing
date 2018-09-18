function [] = nodeovrp(A, B, ovrp)

    if nargin < 3
        ovrp = 0.2;
    end

    Fs = 44100;
    len = min(length(A), length(B));    
    dis = round(len*(1-ovrp));
    out = zeros(len+dis,1);

    for k = 1:len+dis
        if k <= dis
            out(k) = A(k);
        elseif k <= len
            out(k) = A(k) + B(k-dis);
        else
            out(k) = B(k-dis);
        end
    end
    soundsc(out, Fs);
end