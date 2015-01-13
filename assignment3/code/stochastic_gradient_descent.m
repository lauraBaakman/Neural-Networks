function [ weights ] = stochastic_gradient_descent( data, labels, learning_rate, t_max)
    %STOCHASTIC_GRADIENT_DESCENT Summary of this function goes here
    %   INPUT
    %       DATA:           N X P matrix with P N-dimensional vectors.
    %       LABELS:         1 X P matrix with continous labels
    %       LEARNING_RATE:  The learning rate
    %       T_MAX:          THe algorithm performs P * t_max training steps
    %   OUTPUT
    %       WEIGHTS         2 x N matrix with the first and second layer
    %       weights.
    
    P = size(data, 2);
    N = size(data, 1);
    total_number_of_steps = P * t_max;
    t = 0;
    
    weights = initialize_weights(N);
    
    while t < total_number_of_steps
        [pattern, idx] = datasample(data, 1, 2);
        tau = labels(idx);
        weights = update_weights(pattern, weights, tau, learning_rate);
        t = t + 1;
    end
    
end

function [weights] = update_weights(pattern, weights, tau, learning_rate)
    sigma_min_tau = sigma(pattern, weights) - tau;
    c = contribution(sigma_min_tau);
    weights(1, :) = update_weight(weights(1, :), learning_rate, sigma_min_tau, c, pattern);
    weights(2, :) = update_weight(weights(2, :), learning_rate, sigma_min_tau, c, pattern);
end

function [w] = update_weight(weight, learning_rate, sigma_min_tau, c, pattern)
    w = weight - learning_rate * gradient(sigma_min_tau, weight, pattern) * c;
end
        

function [c] = contribution(sigma_min_tau)
    c = (sigma_min_tau^2)/2;
end

function [g] = gradient(sigma_min_tau, weight, pattern)
    g = sigma_min_tau * (1 - tanh(weight * pattern).^2) * pattern';
end

function [s] = sigma(pattern, weights)
   s = tanh(weights(1, :) * pattern) + tanh(weights(2, :) * pattern); 
end

function [weights] = initialize_weights(N)
    weights(1, :) = initialize_weight(N);
    weights(2, :) = initialize_weight(N);
end

function [weight] = initialize_weight(N)
   weight = rand(1, N);
   weight = sqrt((weight .^2) / sum(weight.^2));
end

