function [ret] = generalization_error(a, b)
    %GENERALIZATION_ERROR computes the generalization error between a and
    %b.
    %   INPUT
    %   A: 1 x N vector 
    %   B: 1 x N vector
    %   OUTPUT
    %   RET: Generalization error between the vectors A and B.
    ret = 1 / pi * acos(a * b' / (norm(a) * norm(b)));
end