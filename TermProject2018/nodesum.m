function out = nodesum(A, B, C)
% Audio Signal Processing Term Project
% 12131448 ���߿�
% �� �� A�� B�� ���� �� ����� �����ִ� �Լ�

if nargin < 3 
    % ª�� ���� ���� ���� ���� ���
    lenA = length(A);
    lenB = length(B);
    ratio = round(lenB / lenA);

    sumA = zeros(lenA*ratio, 1);
    for k = 1:ratio
        sumA((k-1)*lenA+1:k*lenA) = A;
    end
    out = sumA(1:min(lenB,lenA*ratio))+B(1:min(lenB,lenA*ratio));
    
else
    % ª�� ���� ���� �ٸ� ���� ���
    lenA = length(A);
    lenB = length(B);
    lenC = length(C);

    sumAB = [A;B];
    out = sumAB(1:min(lenC,lenA+lenB))+C(1:min(lenC,lenA+lenB));
end

end