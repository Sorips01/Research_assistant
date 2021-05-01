txsignal = wifitransmitter('hello world',5,30);
[recvMessage, recvMessageLength, ~] = wifireceiver(txsignal,5);

recvMessage
