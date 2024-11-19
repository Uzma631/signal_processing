% Generate a dummy blood pressure dataset (systolic and diastolic)
fs = 100; 
time = 0:1/fs:300; 
% Systolic and diastolic pressures with some noise
systolic = 120 + 10 * sin(0.2 * time) + 5 * randn(size(time)); 
diastolic = 80 + 8 * cos(0.2 * time) + 4 * randn(size(time)); 
bp_signal = systolic + diastolic; % Combine both example

% Plot raw data
figure;
plot(time, bp_signal);
title('Raw Blood Pressure Signal');
xlabel('Time (s)');
ylabel('Pressure (mmHg)');

% low-pass filter
fc = 2;   % Cut-off
[b, a] = butter(4, fc / (fs / 2), 'low');
bp_filtered = filtfilt(b, a, bp_signal);

% Plot filtered data
figure;
plot(time, bp_signal, 'b', time, bp_filtered, 'r');
legend('Raw Signal', 'Filtered Signal');
title('Filtered Blood Pressure Signal');
xlabel('Time (s)');
ylabel('Pressure (mmHg)');

% Feature extraction: systolic and diastolic pressure
[systolic_peaks, systolic_loc] = findpeaks(bp_filtered, 'MinPeakHeight', 130); 
[diastolic_peaks, diastolic_loc] = findpeaks(-bp_filtered, 'MinPeakHeight', -90); 

% Results display
fprintf('Average Systolic Pressure: %.2f mmHg\n', mean(systolic_peaks));
fprintf('Average Diastolic Pressure: %.2f mmHg\n', mean(-diastolic_peaks));

% Plot detected peaks
figure;
plot(time, bp_filtered);
hold on;
plot(time(systolic_loc), systolic_peaks, 'ro'); % Systolic
plot(time(diastolic_loc), -diastolic_peaks, 'go'); % Diastolic
legend('Filtered Signal', 'Systolic Peaks', 'Diastolic Peaks');
title('Blood Pressure Signal with Peaks');
xlabel('Time (s)');
ylabel('Pressure (mmHg)');
