function [ weights_all] = minover(data, labels, n_max, error)
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
    
    weights = rand(1, N);
    weight_differences = zeros(t_max, 1);
    weight_differences(1) = 1;
    
    while t < P || (not_converged(weight_differences(t - P + 1: t), error) && t < t_max)
        t = t + 1;
        mu = find_example_with_lowest_stability(data, labels, weights);
        current_pattern = data(mu, :);
        current_label = labels(mu, :);        
        weights_all(t, :) = weights;
        weights = weights + 1/N * current_pattern * current_label;
        weight_differences(t) = generalization_error(weights, weights_all(t, :));
    end
    weights_all(t + 1, :) = weights;
end


function [idx] = find_example_with_lowest_stability(data, labels, weights)
    stabilities = ((weights * data') .* labels')./norm(weights);
    [~, idx] = min(stabilities);
end

function [ret] = not_converged(generalization_errors, error)
   difference = abs(generalization_errors - repmat(generalization_errors(end), size(generalization_errors, 1), 1));
   ret = sum(sum(difference > error));
end