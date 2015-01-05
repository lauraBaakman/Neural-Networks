function [] = minover(data, labels, P, n_max)
    %MINOVER algorithm to train a perceptron.
    %   INPUT
    %   DATA: D x N matrix with D vectors of dimension N.
    %   LABELS: D X 1 matrix with D labels, that are either 0 or 1.
    %   P: The number of times the weight vector should not change
    %   before terminating the algorithm.
    %   N_MAX: The number of 'sweeps' to perform, the total number of
    %   steps is N_MAX x P.
    
    D = size(data, 1);
    N = size(data, 2);
    t_max = n_max * P;
    t = 0;
    p = 1;
    
    weights = ones(1, N);
    weight_storage = zeros(P, N);
    weight_storage(p, :) = weights;
    
    while not_converged(weight_storage) && t < t_max
        t = 1 + 1;
        mu = find_example_with_lowest_stability(data, labels, weights);
        current_pattern = data(mu, :);
        current_label = labels(mu, :);
        weights = weights + 1/n * current_pattern * current_label;
        p = mod(p, P + 1) + 1;
        weight_storage(p, :) = weights;
    end
end


function [idx] = find_example_with_lowest_stability(data, labels, weights)
    stabilities = ((weights * data') .* labels')./norm(weights);
    [~, idx] = min(stabilities);
end

function [ret] = not_converged(weight_storage)

end
