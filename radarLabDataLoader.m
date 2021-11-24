function dataMatrix = radarLabDataLoader(filePath,mode)
    
    [data,~] = audioread(filePath);
    waveform = data(:,1);
    clock = data(:,2);
    
    rowIndex = 0;
    tempVector = 0;
    counter = 0;
    signalCells = {};
    for k = 1:length(waveform)
       if clock(k) > 0 
           tempVector = [tempVector,waveform(k)];
           counter = 0;
       else
           counter = counter + 1;
       end

       if counter == 1
           rowIndex = rowIndex + 1;
           signalCells(rowIndex) = {tempVector};
           tempVector = 0;
       end
    end
    
    nRow = length(signalCells);
    lenVect = zeros(1,nRow-1);
    for k = 2:nRow
        lenVect(k-1) = length(signalCells{k});
    end
    
    switch mode
        case 'trunc'
            nCol = min(lenVect) - 5;
            dataMatrix = zeros(nRow-1,nCol);
            for k = 2:nRow
                signal = signalCells{k};
                dataMatrix(k-1,:) = signal(3:3+nCol-1);
            end
        case 'resample'
            nCol = 2^ceil(log2(max(lenVect)));
            dataMatrix = zeros(nRow-1,nCol);
            for k = 2:nRow
                signal = signalCells{k};
                dataMatrix(k-1,:) = resample(signal(3:end-3),nCol,lenVect(k-1)-5);
            end
    end
    
    dataMatrix = dataMatrix(2:end-1,:);
    
end

