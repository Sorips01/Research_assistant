classdef Receiver
    %UNTITLED5 이 클래스의 요약 설명 위치
    %   자세한 설명 위치
    
    properties
        Tx  % Tx 갯수
        Rx  % Rx 갯수
        h   % Rayleight Chanel
        noise  % 잡음
        N   % 잡음 전력 noise Power
        r   % 수신된 신호 Receive Signal
    end
    
    methods
        function obj = Receiver(Tx, Rx, ~, N)
            obj.Tx = Tx;
            obj.Rx = Rx;
            obj.N = N;
        end
        
        function obj = ReceiveData(obj, TxSymbol)
            obj = obj.makeRayleigh();
            obj = obj.makeNoise();
            obj.r = obj.h * TxSymbol + obj.noise;
        end
        
        function obj = makeRayleigh(obj)
            obj.h = (randn(obj.Rx,obj.Tx) + 1j * randn(obj.Rx, obj.Tx))/sqrt(2);
        end
        
        function obj = makeNoise(obj)
            obj.noise = (randn(obj.Rx,1) + 1j * randn(obj.Rx,1)) * sqrt(obj.N/2);
        end
    end
end

