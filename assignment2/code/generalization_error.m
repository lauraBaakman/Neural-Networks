function [ret] = generalization_error(teacher, weights)
    %GENERALIZATION_ERROR computes the generalization error between a and
    %b.
    %   INPUT
    %   A: 1 x N vector 
    %   B: M x N matrix
    %   OUTPUT
    %   RET: Generalization error between the vectors A and B.
    
    M = size(weights, 1);
    norm2 = @(x) sqrt(sum(x.^2,2));
    a_repeated = repmat(teacher, M, 1);
    
    ret = 1 / pi * acos(bsxfun(@rdivide, dot(a_repeated,weights,2), (norm2(a_repeated) .* norm2(weights))));
end