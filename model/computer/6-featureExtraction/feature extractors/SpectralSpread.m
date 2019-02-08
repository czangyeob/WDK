%returns the first component of the frequency representation of the signal
classdef SpectralSpread < Computer
    
    properties (Access = public)
        fourierTransform;
    end
    
    methods (Access = public)
        
        function obj = SpectralSpread()
            obj.name = 'SpectralSpread';
            obj.inputPort = ComputerPort(ComputerPortType.kSignal,ComputerSizeType.kN);
            obj.outputPort = ComputerPort(ComputerPortType.kFeature);
        end
        
        function result = compute(obj,data)
            
            localFourierTransform = obj.fourierTransform;
            
            %if isempty(localFourierTransform)
            %localFourierTransform = fft(signal);%this is probably wrong, should be tested
            %end
            
            fs = 100;
            
            N = length(data);
            windowFFT = abs(optimizedFFT(data,localFourierTransform)) / N;
            windowFFT = windowFFT(1:ceil(N/2));
            
            windowLength = length(windowFFT);
            m = ((fs/(2*windowLength))*(1:windowLength))';
            windowFFT = windowFFT / max(windowFFT);
            
            % compute the spectral spread
            C = sum(m.*windowFFT)/ (sum(windowFFT)+eps);
            result = sqrt(sum(((m-C).^2).*windowFFT)/ (sum(windowFFT)+eps));
            
            result = result / (fs/2);
        end
    end
end