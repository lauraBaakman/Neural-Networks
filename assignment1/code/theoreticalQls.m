function [ result ] = theoreticalQls( d, alphas )
    %UNTITLED2 Summary of this function goes here
    %   INPUT
    %   - D: dimensionality of the data
    
    result = zeros(size(alphas));
    for idx = 1:size(alphas,2)
        N = round(d * alphas(idx));
        result(idx) = theoretical(N, d);
    end
end


function [res] = theoretical(N, d)
    if( N <= d + 1)
        res = 1;
    else
        res = 0;
        for k = 1:d
            res = res + factorial(N - 1) / (factorial(k) * factorial(N - 1 - k));
        end
        res = res * 2/(2^N);
    end
end
