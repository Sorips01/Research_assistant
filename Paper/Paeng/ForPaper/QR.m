function [returnQ] = QR(h_)
[Q, ~] = qr(h_);

returnQ = (conj(Q.'));
end

