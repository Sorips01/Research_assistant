txsignal = wifitransmitter('hello world',4);
[recvMessage, recvMessageLength, ~] = wifireceiver(txsignal,4);

recvMessage
