classdef ISDIC
    %UNTITLED6 이 클래스의 요약 설명 위치
    %   자세한 설명 위치
    
    properties
        Tx
        Rx
        s
        v
    end
    
    methods
        function obj = ISDIC(Tx,Rx)
            %UNTITLED6 이 클래스의 인스턴스 생성
            %   자세한 설명 위치
            obj.Tx = Tx;
            obj.Rx = Rx;
            obj.s = zeros(Tx,1);
            obj.v = ones(Tx,1);
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 이 메서드의 요약 설명 위치
            %   자세한 설명 위치
            outputArg = obj.Property1 + inputArg;
        end
    end
end

