function [dprime, criterion, aprime, bprime] = sdt_measures(hit_rate, falseAlarm_rate) 

% Calculates SDT measures given hit/false alarm rates
%   [dprime, criterion, aprime, bprime] = sdt_measures(h,fA) 
%   returns the d', C, A' and B'' 
%   for the hit rate h and false alarm rate fA

%   Based on Stanislaw & Todorov, 1999

%   Author : Juliana Sporrer
%   Date of creation : 31-Mars-2020 

%% Avoids inf 
nTarget = 1;

if hit_rate == 0 || hit_rate == 1
    hit_rate = .5/nTarget;
end
if falseAlarm_rate == 0 || falseAlarm_rate == 1
    falseAlarm_rate = 1-.5/nTarget;
end 

%% d', Parametric sensitivity index (Macmillan, 1993)
dprime              = norminv(hit_rate) - norminv(falseAlarm_rate);

%% C, Parametric response bias (Macmillan, 1993)
criterion           = -(norminv(hit_rate) + norminv(falseAlarm_rate))/2; 

%% A', Non-parametric measure of sensitivity (Pollack and Norman, 1964) 
    % Can range from .5, which indicates that signals cannot be distinguished from noise, 
    % to 1 which corresponds to perfect performance.
    
if hit_rate         >= falseAlarm_rate
    aprime          = .5 + ((hit_rate - falseAlarm_rate)*(1 + hit_rate - falseAlarm_rate)) ...
        /(4*hit_rate*(1-falseAlarm_rate));
elseif hit_rate     < falseAlarm_rate
    aprime          = .5 - ((falseAlarm_rate - hit_rate)*(1 + falseAlarm_rate - hit_rate)) ...
        /(4*falseAlarm_rate*(1-hit_rate));
end

%% B'', non-parametric measure of response bias (Grier, 1971) 
    % Can range from - 1 (bias in favour of "yes") to 1 (bias in favour of "no"). 
    % A value of 0 signifies no response bias.
    
bprime              = sign(hit_rate - falseAlarm_rate)* (hit_rate*(1-hit_rate)-falseAlarm_rate*(1-falseAlarm_rate) ... 
    / (hit_rate*(1-hit_rate)+ falseAlarm_rate*(1-falseAlarm_rate))); 

end 
