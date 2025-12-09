function RR = compute_rr_from_tt(TT)
% compute_rr_from_tt
% Input: synchronized timetable containing Acceleration and Position
% Output: timetable with Velocity and Rolling Resistance

    % Keep only numeric columns
    numeric_vars = varfun(@isnumeric, TT, 'OutputFormat', 'uniform');
    TT_numeric = TT(:, numeric_vars);

    % Remove missing rows
    TT_numeric = rmmissing(TT_numeric);

    % Extract acceleration (first numeric column)
    a = TT_numeric{:,1};

    % Extract Time vector
    t = TT.Properties.RowTimes;
    t = t(1:height(TT_numeric));

    % Smooth acceleration
    a_f = movmean(a, max(5, round(numel(a)/50)));

    % Time delta
    dt = seconds(mean(diff(t)));

    % Integrate to velocity
    v = cumsum(a_f) * dt;

    % Rolling resistance model
    m = 5; g = 9.81;
    F_rr = m*g*(1 - v./(v+0.1));

    % Return final timetable
    RR = timetable(t, v, F_rr, 'VariableNames', ...
        {'Velocity','RollingResistance'});
end
