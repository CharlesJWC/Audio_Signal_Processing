function [output] = impulsefunc(input)

sig_num = length(input);

output = zeros(1,sig_num);

 for k = 1:sig_num
     
     if input(k) == 0
         output(k)  = 1;
     else 
         output(k)  = 0;
     end
end