function [ weights, generalization_errors ] = minover(data, labels, n_max, w_star, error)
    %MINOVER algorithm to train a perceptron.
    %   INPUT
    %   DATA: P x N matrix with P vectors of dimension N.
    %   LABELS: P X 1 matrix with P labels, that are either 0 or 1.
    %   N_MAX: The number of 'sweeps' to perform, the total number of
    %   steps is N_MAX x P.
    %   W_STAR: The teacher weights
    %   ERROR: The acceptable difference between weights when testing for
    %   convergence.
    
    P = size(data, 1);
    N = size(data, 2);
    t_max = n_max * P;
    t = 0;
    p = 1;
    
    weights = zeros(1, N);
    weight_storage = ones(P, N);
    weight_storage(p, :) = weights;
    
    generalization_errors = zeros(t_max, 1);
    
    while not_converged(weight_storage, P, error) && t < t_max
        t = t + 1;
        mu = find_example_with_lowest_stability(data, labels, weights);
        current_pattern = data(mu, :);
        current_label = labels(mu, :);        
        weights = weights + 1/N * current_pattern * current_label;
        generalization_errors(t) = generalization_error(weights, w_star);
        p = mod(p, P) + 1;
        weight_storage(p, :) = weights; 
    end
end


function [idx] = find_example_with_lowest_stability(data, labels, weights)
    stabilities = ((weights * data') .* labels')./norm(weights);
    [~, idx] = min(stabilities);
end

function [ret] = not_converged(weight_storage, P, error)
   difference = abs(weight_storage - repmat(weight_storage(1, :), P, 1));
   ret = sum(sum(difference > error));
end

function [ret] = generalization_error(w, w_star)
    ret = 1 / pi * acos(w * w_star' / (norm(w) * norm(w_star)));
end