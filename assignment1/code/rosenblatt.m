function [ weights, n ] = rosenblatt( data, labels, n_max )
    %ROSENBLATT Rosenblat algorithm to train a perceptron
    %   INPUT
    %       data: P x N matrix with P vectors of dimension N.
    %       labels: P x 1 matrix with P labels, that are either -1 or 1.
    %       n_max: Maximum number of sweeps.
    %   OUTPUT
    %       weights: The computed sweeps.
    %       n: The number of exectuted sweeps.
    
    P = size(data, 1);
    N = size(data, 2);
    
    weights = zeros(1, N);
    n = 0;
    not_converged = 1;
    
    while not_converged && n < n_max
        not_converged = 0;
        for i = 1:P
            psi = data(i, :);
            label = labels(i);
            if E(weights, psi, label)
                not_converged = 1;
                weights = weights + 1/N * psi * label;
            end
        end
        n = n + 1;
    end
end

function [e] = E (w, p, l)
    e = dot(w, p) * l <= 0;
end

