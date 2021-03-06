%returns the first component of the frequency representation of the signal
classdef SpectralFlatness < Algorithm
   
    methods (Access = public)
        
        function obj = SpectralFlatness()
            obj.name = 'SpectralFlatness';
            obj.inputPort = DataType.kSignal;
            obj.outputPort = DataType.kFeature;
        end
        
        %receives a fourier transform
        function result = compute(~,Y)
            pxx = periodogram(Y);
            num = geomean(pxx);
            den = mean(pxx);
            result = num / den;
        end
        
        function metrics = computeMetrics(~,input)
            n = size(input,1);
            flops = 68 * n;
            memory = n;
            outputSize = Constants.kFeatureBytes;
            metrics = Metric(flops,memory,outputSize);
        end
    end
end
