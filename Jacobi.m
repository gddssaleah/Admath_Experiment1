%ORZAME_Expt1B (I had to change the file name in order to be compatible to
%the function name)

function [x,k] = Jacobi (A,b,epsilon)

%Checking if array is diagonally dominant
isdom = true;
for r = 1:size(A,1)
    rowdom = 2 * abs(A(r,r)) > sum(abs(A(r,:)));
    isdom = isdom && rowdom;
end

if isdom == 0
    while isdom==0
        A = A(randperm(size(A, 1)), :); % Randomly swaps rows
        isdom = true;
        for r = 1:size(A,1)
            rowdom = 2 * abs(A(r,r)) > sum(abs(A(r,:)));
            isdom = isdom && rowdom;
        end
    end
end

x1=0;x2=0;x3=0;k=0;x1e=inf;x2e=inf;x3e=inf;
for q = 1:100
    x1(q+1) = (1/A(1,1))*(b(1) - (A(1,2)*x2(q)) - (A(1,3)*x3(q)));
    x2(q+1) = (1/A(2,2))*(b(2) - (A(2,1)*x1(q)) - (A(2,3)*x3(q)));
    x3(q+1) = (1/A(3,3))*(b(3) - (A(3,1)*x1(q)) - (A(3,2)*x2(q)));
    
    while x1e >= epsilon && x2e >= epsilon && x3e >= epsilon
        x1e = abs(x1(q+1)- x1(q));
        x2e = abs(x2(q+1)- x2(q));
        x3e = abs(x3(q+1)- x3(q));
        k = k+1;
        break
    end
end 

x = [x1(q+1),x2(q+1),x3(q+1)];
