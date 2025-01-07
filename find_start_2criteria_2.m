signal_size=size(signal,1);
signal_max=max(signal);
[signal_min,I_min]=min(signal);
for z=I_min:signal_size
    if signal(z)>=0.8*(signal_max-signal_min)+signal_min
        location = z;
        break
    end
end

threshold = (signal_max - signal_min)/(location-I_min)*1;
high_threshold=signal(1)+(signal_max - signal(1))*0.6;
for z = I_min:signal_size-5
    p = polyfit(z+0:z+4,signal(z+0:z+4),1)
    if p(1)>threshold
        p(1);
        result_start = z
        break
    end
end

for z = result_start:signal_size-3
    if z<=3
        z = 4;
    end
    if (signal(z) >= mean(signal(z-2:z-1))) && (signal(z) >= mean(signal(z+1:z+3))) && signal(z)>=high_threshold
        result_peak = z
        break
    end

end

plot(signal);
hold on
plot(result_start,signal(result_start),'ro');
plot(result_peak,signal(result_peak),'ro')
hold off