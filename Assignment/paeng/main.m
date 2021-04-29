txsignal = wifitransmitter('hello world', 1);
[recvMessage, recvMessageLength, ~] = wifireceiver(txsignal, 1);

recvMessage
