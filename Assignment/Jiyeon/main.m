txsignal = wifitransmitter('hello world',3);
[recvMessage, recvMessageLength, ~] = wifireceiver(txsignal,3);

recvMessage
