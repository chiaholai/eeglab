clear all
clc

subjID = textread('subjlist.txt','%s','delimiter','\t');
nsubj = length(subjID);
script_path = pwd;
cd ..
folder_path = pwd;
ana_path = fullfile(folder_path,'Analysis');

for i = 1:nsubj;    
    
    name_temp = char(subjID(i));

    if strcmp(name_temp(1:2),'YA') 
        ana_fd = 'YoungerAdults';
    elseif strcmp(name_temp(1:2),'OA')
        ana_fd = 'OlderAdults';
    end;
    
    data_path = fullfile(ana_path,ana_fd,'data',char(subjID(i)));
    
    fname_data = [char(subjID(i)) '.set'];
    fname_elist = [char(subjID(i)) '_elist.set'];
    fname_bin = [char(subjID(i)) '_elist_bin.set'];
    fname_AD = [char(subjID(i)) '_elist_bin_AD.set'];
    
    EEG = pop_loadset('filename',fname_data,'filepath',data_path);
    EEG = eeg_checkset( EEG );
    %EEG=pop_chanedit(EEG, 'load',{'C:\\eeglab11_0_5_4b\\RA_analysis\\Chiaho_setupfile.asc' 'filetype' 'asc'});
    %EEG = eeg_checkset( EEG );
    EEG  = pop_editeventlist( EEG , 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'ExportEL', fullfile(data_path,'elist.txt'), 'List', fullfile(script_path,'eventlist_RA.txt'),'SendEL2', 'EEG&Text', 'UpdateEEG', 'off' );
    EEG = pop_overwritevent( EEG, 'codelabel');
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',fname_elist,'filepath',data_path);
    EEG = eeg_checkset( EEG );
    EEG = pop_binlister( EEG , 'BDF', fullfile(script_path,'binlist_RA_20140808.txt'), 'ExportEL', fullfile(data_path,'elist080814.txt'), 'ImportEL', 'no', 'Saveas', 'on', 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Warning', 'on' );
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',fname_bin,'filepath',data_path);
    EEG = pop_epochbin( EEG , [-200.0  1000.0],  'pre');
    EEG = eeg_checkset( EEG );
    EEG = pop_eegchanoperator( EEG, {  ' nch1 = ch1 - ( (ch33+ch43)/2 ) Label FP1'   ' nch2 = ch2 - ( (ch33+ch43)/2 ) Label FPZ'   ' nch3 = ch3 - ( (ch33+ch43)/2 ) Label FP2'   ' nch4 = ch4 - ( (ch33+ch43)/2 ) Label AF3'   ' nch5 = ch5 - ( (ch33+ch43)/2 ) Label AF4'   ' nch6 = ch6 - ( (ch33+ch43)/2 ) Label F7'   ' nch7 = ch7 - ( (ch33+ch43)/2 ) Label F5'   ' nch8 = ch8 - ( (ch33+ch43)/2 ) Label F3'   ' nch9 = ch9 - ( (ch33+ch43)/2 ) Label F1'   ' nch10 = ch10 - ( (ch33+ch43)/2 ) Label FZ'   ' nch11 = ch11 - ( (ch33+ch43)/2 ) Label F2'   ' nch12 = ch12 - ( (ch33+ch43)/2 ) Label F4'   ' nch13 = ch13 - ( (ch33+ch43)/2 ) Label F6'   ' nch14 = ch14 - ( (ch33+ch43)/2 ) Label F8'   ' nch15 = ch15 - ( (ch33+ch43)/2 ) Label FT7'   ' nch16 = ch16 - ( (ch33+ch43)/2 ) Label FC5'   ' nch17 = ch17 - ( (ch33+ch43)/2 ) Label FC3'   ' nch18 = ch18 - ( (ch33+ch43)/2 ) Label FC1'   ' nch19 = ch19 - ( (ch33+ch43)/2 ) Label FCZ'   ' nch20 = ch20 - ( (ch33+ch43)/2 ) Label FC2'   ' nch21 = ch21 - ( (ch33+ch43)/2 ) Label FC4'   ' nch22 = ch22 - ( (ch33+ch43)/2 ) Label FC6'   ' nch23 = ch23 - ( (ch33+ch43)/2 ) Label FT8'   ' nch24 = ch24 - ( (ch33+ch43)/2 ) Label T7'   ' nch25 = ch25 - ( (ch33+ch43)/2 ) Label C5'   ' nch26 = ch26 - ( (ch33+ch43)/2 ) Label C3'   ' nch27 = ch27 - ( (ch33+ch43)/2 ) Label C1'   ' nch28 = ch28 - ( (ch33+ch43)/2 ) Label CZ'   ' nch29 = ch29 - ( (ch33+ch43)/2 ) Label C2'   ' nch30 = ch30 - ( (ch33+ch43)/2 ) Label C4'   ' nch31 = ch31 - ( (ch33+ch43)/2 ) Label C6'   ' nch32 = ch32 - ( (ch33+ch43)/2 ) Label T8'   ' nch33 = ch33 - ( (ch33+ch43)/2 ) Label M1'   ' nch34 = ch34 - ( (ch33+ch43)/2 ) Label TP7'   ' nch35 = ch35 - ( (ch33+ch43)/2 ) Label CP5'   ' nch36 = ch36 - ( (ch33+ch43)/2 ) Label CP3'   ' nch37 = ch37 - ( (ch33+ch43)/2 ) Label CP1'   ' nch38 = ch38 - ( (ch33+ch43)/2 ) Label CPZ'   ' nch39 = ch39 - ( (ch33+ch43)/2 ) Label CP2'   ' nch40 = ch40 - ( (ch33+ch43)/2 ) Label CP4'   ' nch41 = ch41 - ( (ch33+ch43)/2 ) Label CP6'   ' nch42 = ch42 - ( (ch33+ch43)/2 ) Label TP8'   ' nch43 = ch43 - ( (ch33+ch43)/2 ) Label M2'   ' nch44 = ch44 - ( (ch33+ch43)/2 ) Label P7'   ' nch45 = ch45 - ( (ch33+ch43)/2 ) Label P5'   ' nch46 = ch46 - ( (ch33+ch43)/2 ) Label P3'   ' nch47 = ch47 - ( (ch33+ch43)/2 ) Label P1'   ' nch48 = ch48 - ( (ch33+ch43)/2 ) Label PZ'   ' nch49 = ch49 - ( (ch33+ch43)/2 ) Label P2'   ' nch50 = ch50 - ( (ch33+ch43)/2 ) Label P4'   ' nch51 = ch51 - ( (ch33+ch43)/2 ) Label P6'   ' nch52 = ch52 - ( (ch33+ch43)/2 ) Label P8'   ' nch53 = ch53 - ( (ch33+ch43)/2 ) Label PO7'   ' nch54 = ch54 - ( (ch33+ch43)/2 ) Label PO5'   ' nch55 = ch55 - ( (ch33+ch43)/2 ) Label PO3'   ' nch56 = ch56 - ( (ch33+ch43)/2 ) Label POZ'   ' nch57 = ch57 - ( (ch33+ch43)/2 ) Label PO4'   ' nch58 = ch58 - ( (ch33+ch43)/2 ) Label PO6'   ' nch59 = ch59 - ( (ch33+ch43)/2 ) Label PO8'   ' nch60 = ch60 - ( (ch33+ch43)/2 ) Label O9'   ' nch61 = ch61 - ( (ch33+ch43)/2 ) Label O1'   ' nch62 = ch62 - ( (ch33+ch43)/2 ) Label OZ'   ' nch63 = ch63 - ( (ch33+ch43)/2 ) Label O2'   ' nch64 = ch64 - ( (ch33+ch43)/2 ) Label O10'   ' nch65 = ch65 Label HEOG'   ' nch66 = ch66 Label VEOG'   });
    EEG = eeg_checkset( EEG );
    %EEG  = pop_basicfilter( EEG,  1:66 , 'Cutoff',  30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
    %EEG = eeg_checkset( EEG );
    EEG  = pop_artmwppth( EEG , 'Channel',  66, 'Flag', [ 1 2], 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 999], 'Windowsize',  200, 'Windowstep',  100 );
    EEG = eeg_checkset( EEG );
    EEG  = pop_artstep( EEG , 'Channel',  65, 'Flag', [ 1 3], 'Review', 'off', 'Threshold',  100, 'Twindow', [ -200 999], 'Windowsize',  200, 'Windowstep',  50 );
    EEG = eeg_checkset( EEG );
    EEG  = pop_artextval( EEG , 'Channel',  1:64, 'Flag', [ 1 4], 'Review', 'off', 'Threshold', [ -100 100], 'Twindow', [ -200 999] );
    EEG = eeg_checkset( EEG );
    %EEG = pop_chanedit(EEG, 'load',{'/BLPlab/RefAmb/Analysis/YoungerAdults/Chiaho_setupfile.asc' 'filetype' 'asc'});
    EEG = pop_chanedit(EEG, 'lookup','/usr/local/MATLAB/eeglab/plugins/dipfit2.2/standard_BESA/standard-10-5-cap385.elp');
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',fname_AD,'filepath',data_path);
    EEG = eeg_checkset( EEG );
end