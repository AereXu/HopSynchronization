% Initialize data 
    L = 16; M = 16; numSymb = 100; snrdB = 30;
    R = 25; rollOff = 0.75; filtDelay = 3; g = 0.07; delay = 6.6498;

% Create System objects
    hMod = comm.RectangularQAMModulator(M, ...
        'NormalizationMethod', 'Average power');
    hTxFilter = comm.RaisedCosineTransmitFilter(...
        'RolloffFactor', rollOff, ...
        'FilterSpanInSymbols', 2*filtDelay, ...
        'OutputSamplesPerSymbol', L);
    hDelay = dsp.VariableFractionalDelay('MaximumDelay', L);
    hChan = comm.AWGNChannel('NoiseMethod',  ...
        'Signal to noise ratio (SNR)', 'SNR', snrdB, ...
        'SignalPower', 1/L);
    hRxFilter = comm.RaisedCosineReceiveFilter(...
        'RolloffFactor', rollOff, ...
        'FilterSpanInSymbols', 2*filtDelay, ...
        'InputSamplesPerSymbol', L, ...
        'DecimationFactor', 1);
    hSync = comm.EarlyLateGateTimingSynchronizer(...
        'SamplesPerSymbol', L, ...
        'ErrorUpdateGain', g);

% Generate random data
    data = randi([0 M-1], numSymb, 1);

% Modulate and filter transmitter data
    modData = step(hMod, data);
    filterData = step(hTxFilter, modData);

% Introduce a random delay and add noise
    delayedData = step(hDelay, filterData, delay);
    chData = step(hChan, delayedData);

% Filter receiver data
    rxData = step(hRxFilter, chData);

% Estimate the delay from the received signal
    [~, phase] = step(hSync, rxData);
    fprintf(1, 'Actual Timing Delay: %f\n', delay);
    fprintf(1, 'Estimated Timing Delay: %f\n', phase(end));