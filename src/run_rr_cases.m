%% RUN ROLLING RESISTANCE CASES

clear; clc;

%% Paths
hub_files = {
    'data/hub/hub_1_a.mat'
    'data/hub/hub_2_b.mat'
};

motor_files = {
    'data/motor/sensorlog_20251114_212931.mat'
    'data/motor/sensorlog_20251114_170352.mat'
};

%% RUN FOR HUB FILES (NO MOTOR)
for i = 1:length(hub_files)
    data = load(hub_files{i});

    AccTT = data.Acceleration;
    PosTT = data.Position;

    % Sync timetables
    TT_sync = synchronize(AccTT, PosTT, 'union');

    % Compute RR
    RR = compute_rr_from_tt(TT_sync);

    % Plot
    fig = figure;
    subplot(2,1,1);
    plot(RR.t, RR.Velocity);
    title(['Hub ' num2str(i) ' Velocity']);

    subplot(2,1,2);
    plot(RR.t, RR.RollingResistance);
    title(['Hub ' num2str(i) ' Rolling Resistance']);

    % Save figure
    saveas(fig, ['plots/hub_' num2str(i) '_results.png']);
end

%% RUN FOR MOTOR FILES (WITH MOTOR)
for i = 1:length(motor_files)
    data = load(motor_files{i});

    % Direct sensorlogs have fields "Acceleration", "Position"
    AccTT = data.Acceleration;
    PosTT = data.Position;

    TT_sync = synchronize(AccTT, PosTT, 'union');
    RR = compute_rr_from_tt(TT_sync);

    fig = figure;
    subplot(2,1,1);
    plot(RR.t, RR.Velocity);
    title(['Motor ' num2str(i) ' Velocity']);

    subplot(2,1,2);
    plot(RR.t, RR.RollingResistance);
    title(['Motor ' num2str(i) ' Rolling Resistance']);

    saveas(fig, ['plots/motor_' num2str(i) '_results.png']);
end
