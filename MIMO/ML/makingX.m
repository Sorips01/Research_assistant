function [result] = makingX(Tx)
t = 1:2^Tx;
a = nchoosek(t,Tx);
b = bitget(a,1);
c = unique(b,'rows');
d = 2*c-1;
result = d.';
end
