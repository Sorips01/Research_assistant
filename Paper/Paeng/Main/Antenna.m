classdef Antenna < Transmitter & Receiver
    properties
%       T
%       R
    end
    
    methods
        function obj = Antenna(TxCount, RxCount, SymbolCount, N)
           obj = obj@Transmitter(TxCount, RxCount, SymbolCount);
           obj = obj@Receiver(TxCount, RxCount, SymbolCount, N);
           obj = obj.makeSymbol();
           obj = obj.ReceiveData(obj.symbol);
        end
    end
end

