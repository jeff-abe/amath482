function data = specwavelet(signal,Fs)
    clips = size(signal,2);
    data = [];
    for k = 1:clips 
        s = signal(:,k)';
        spec = cwt(s,Fs,'FrequencyLimits',[40 6000]);
        data = [data abs(reshape(spec,[],1))];
    end
end