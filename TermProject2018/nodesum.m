function out = nodesum(A, B, C)
% Audio Signal Processing Term Project
% 12131448 최중원
% 두 음 A와 B의 길이 비를 고려해 합쳐주는 함수

if nargin < 3 
    % 짧은 음이 서로 같은 음일 경우
    lenA = length(A);
    lenB = length(B);
    ratio = round(lenB / lenA);

    sumA = zeros(lenA*ratio, 1);
    for k = 1:ratio
        sumA((k-1)*lenA+1:k*lenA) = A;
    end
    out = sumA(1:min(lenB,lenA*ratio))+B(1:min(lenB,lenA*ratio));
    
else
    % 짧은 음이 서로 다른 음일 경우
    lenA = length(A);
    lenB = length(B);
    lenC = length(C);

    sumAB = [A;B];
    out = sumAB(1:min(lenC,lenA+lenB))+C(1:min(lenC,lenA+lenB));
end

end