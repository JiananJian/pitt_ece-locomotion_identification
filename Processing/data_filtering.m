function y = data_filtering(x, fc)
%DATA_FILTERING Low-pass filtering
%   y is the original data
%   fc is the cut-off frequency
%   z is the smoothed data
%   Note that the first three sensors are off
    nSensors = 5;
    nSegments = size(x, 3);
    y = zeros(2 * fc - 1, nSensors, nSegments); 
    for sensor = 1 : nSensors
        for segment = 1 : nSegments
            s = x(:, 3 + sensor, segment); 
            S = fft(s);
            S(1 + fc : 1 + end - fc) = [];
            y(:, sensor, segment) = ifft(S);
        end
    end
end