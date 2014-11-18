function [ q, convs ] = test( n_d, n_max, N, alpha )
    %Test Summary of this function goes here
    %   Input:
    %       n_d: Number of runs.
    %       n_max: Maximum number of sweeps per run.
    %       N: Dimensionality of the data.
    %       alpha: Relations between N and P
    %   Output:
    %       q: Quotient function
    %       convs: The number of sweeps it takes to converge per run.
    
    P = round(alpha * N);
    errors = zeros(1, n_d);
    convs = zeros(1, n_d);
    for i=1:n_d
        [data, labels] = generate_data(P, N);
        [weights, n_conv] = rosenblatt(data, labels, n_max);
        convs(i) = n_conv;
        errors(i) = error(data, labels, weights);
    end
    q = sum(errors)/n_d;
    convs = mean(convs);
end

function[errors] =  error(data, labels, weights)
    P = size(data, 1);
    errors = zeros(P,1);
    for p_idx = 1:P
        errors(p_idx) = dot(weights, data(p_idx, :)) * labels(p_idx) > 0;
    end
    errors = sum(errors) == P;
end
