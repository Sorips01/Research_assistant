txsignal = wifitransmitter('twosome place',5,30);
[recvMessage, recvMessageLength, ~] = wifireceiver(txsignal,5);

recvMessage
