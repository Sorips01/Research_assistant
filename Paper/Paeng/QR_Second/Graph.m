clear all;
close all;

x=-14:2:14;
LineWidth = 1;
lim_y = 1E-4;

% antennaCount = ["_4x4","_4x8" ,"_8x8", "_8x16","_16x16" ];
antennaCount = ["_8x8", "_8x16","_16x16","_16x32","_32x32" ];

% load mat file
origin_QR = cell(5, 2);
for ii=1:5
    loadName = strcat(pwd, '\result\ISDIC', antennaCount(ii), '_QR.mat');
    load(fullfile(loadName));
    for jj = 1:2    
        if jj == 1
            origin_QR{ii, jj} = result(:,1);
        else
            origin_QR{ii, jj} = result(:,5);
        end
    end
end

proposed_QR_LC = cell(5, 2);
for ii=1:5
    loadName = strcat(pwd, '\result\ISDIC', antennaCount(ii), '_QR.mat');
    load(fullfile(loadName));
    for jj = 1:2    
        if jj == 1
            proposed_QR_LC{ii, jj} = result(:,1);
        else
            proposed_QR_LC{ii, jj} = result(:,5);
        end
    end
end


% Draw
f1 = figure;
for ii=1:5
    for jj=1:2
        semilogy(x, length_normalize(x, origin_QR{ii, jj}'), 'LineWidth', LineWidth);
        hold on;
    end
end

for ii=1:5
    for jj=1:2
        semilogy(x, length_normalize(x, proposed_QR_LC{ii, jj}'), 'LineWidth', LineWidth);
        hold on;
    end
end


% %% iteration 1
% 
% semilogy(x, Original_4x4_iter_1, 'LineWidth', LineWidth);
% hold on;
% semilogy(x, Proposed_4x4_iter_1, 'LineWidth', LineWidth);
% hold on;
% 
% %% iteration 5
% 
% semilogy(x, Original_4x4_iter_5, 'LineWidth', LineWidth);
% hold on;
% semilogy(x, Proposed_4x4_iter_5, 'LineWidth', LineWidth);
% hold on;


xlim([-14 14]);
ylim([lim_y 1]);
ylabel('Average BER');
xlabel('SNR');
legend('Origin QR 8x8 Iter:1','Origin QR 8x8 Iter:5', ...
    'Origin QR 8x16 Iter:1','Origin QR 8x16 Iter:5', ...
   'Origin QR 16x16 Iter:1', 'Origin QR 16x16 Iter:5', ...
  'Origin QR 16x32 Iter:1', 'Origin QR 16x32 Iter:5', ...
  'Origin QR 32x32 Iter:1', 'Origin QR 32x32 Iter:5', ...
  'Proposed QR 8x8 Iter:1','Proposed QR 8x8 Iter:5', ...
    'Proposed QR 8x16 Iter:1','Proposed QR 8x16 Iter:5', ...
   'Proposed QR 16x16 Iter:1', 'Proposed QR 16x16 Iter:5', ...
  'Proposed QR 16x32 Iter:1', 'Proposed QR 16x32 Iter:5', ...
  'Proposed QR 32x32 Iter:1', 'Proposed QR 32x32 Iter:5');

% legend('Proposed QR 8x8 Iter:1','Proposed QR 8x8 Iter:5', ...
%     'Proposed QR 8x16 Iter:1','Proposed QR 8x16 Iter:5', ...
%    'Proposed QR 16x16 Iter:1', 'Proposed QR 16x16 Iter:5', ...
%   'Proposed QR 16x32 Iter:1', 'Proposed QR 16x32 Iter:5', ...
%   'Proposed QR 32x32 Iter:1', 'Proposed QR 32x32 Iter:5');
% 

title('QR Proposed Low Complexity');