function [ data, labels ] = generate_data(P, N )
    %GENERATE_DATA Generate P independent N-dimensional vectors with labels.
    %   INPUT    
    %       P:  Number of vectors to generate.
    %       N:  Dimensionality of the vectors.
    %   OUTPUT
    %       data:   P x N matrix with P N-dimensional feature vectos
    %       labels: P x 1 matrix with labels, each label is minus one or
    %       one with a chance of 0.5.

    data = normrnd(0, 1, P, N);
    labels = datasample([-1, 1], P)'; 
end

