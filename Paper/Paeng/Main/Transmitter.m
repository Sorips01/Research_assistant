classdef Transmitter
    %UNTITLED4 이 클래스의 요약 설명 위치
    %   자세한 설명 위치
    
    properties
        bit
        symbol
    end
    
    methods
        function obj = Transmitter(Tx, ~, symbolCount)
            %UNTITLED4 이 클래스의 인스턴스 생성
            %   자세한 설명 위치
            if (symbolCount == 2)
               
            elseif (symbolCount == 4)
                obj.bit = randi([0,1],Tx,2);
            end          
        end
        
        function obj = makeSymbol(obj)
            %METHOD1 이 메서드의 요약 설명 위치
            %   자세한 설명 위치
            obj.symbol = 2 * obj.bit - 1;
        end
    end
end

