function [ weights, cost, generalization_error ] = stochastic_gradient_descent( data_training, labels_training, data_test, labels_test, learning_rate, t_max)
    %STOCHASTIC_GRADIENT_DESCENT Summary of this function goes here
    %   INPUT
    %       DATA_q:           N X P matrix with P N-dimensional vectors.
    %       LABELS_q:         1 X P matrix with continous labels    
    %       LEARNING_RATE:  The learning rate
    %       T_MAX:          THe algorithm performs P * t_max training steps
    %   OUTPUT
    %       WEIGHTS         2 x N matrix with the first and second layer
    %       weights.
    
    P = size(data_training, 2);
    N = size(data_training, 1);
    
    weights = initialize_weights(N);
    
    cost = ones(t_max, 1);
    generalization_error = ones(t_max, 1);
    
    for t = 1:t_max
        for i = 1:P
            [pattern, idx] = datasample(data_training, 1, 2);
            tau = labels_training(idx);
            weights = update_weights(pattern, weights, tau, learning_rate);
        end
        cost(t) = compute_error(data_training, labels_training, weights);
        generalization_error(t) = compute_error(data_test, labels_test, weights);
    end
    
end

function [error] = compute_error(data, labels, weights)
    P = size(data, 2);
    sig = @(pattern) sigma(pattern, weights);
    sigmas = cell2mat(cellfun(sig, num2cell(data, 1), 'UniformOutput', false));
    error = sum((sigmas - labels).^2) * 0.5 * 1/P;
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

