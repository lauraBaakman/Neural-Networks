function [] = minover(data, labels, P, n_max)
        %MINOVER algorithm to train a perceptron.
        %   INPUT
        %   DATA: D x N matrix with D vectors of dimension N.
        %   LABELS: D X 1 matrix with D labels, that are either 0 or 1.
        %   P: The number of times the weight vector should not change
        %   before terminating the algorithm.
        %   N_MAX: The number of 'sweeps' to perform, the total number of
        %   steps is N_MAX x P.
        
        