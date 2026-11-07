# Rolling Resistance Analysis

MATLAB analysis of coast-down sensor logs from the ASME / Shell Eco-marathon car. It turns recorded acceleration and position into velocity and a rolling-resistance estimate, and compares runs with the hub alone against runs with the motor installed.

## What it does

1. Loads each run's acceleration and position timetables.
2. Synchronizes them onto one time base (`synchronize`).
3. Smooths the acceleration with a moving mean and integrates it to velocity.
4. Estimates the rolling-resistance force from velocity (vehicle mass 5 kg, g = 9.81 m/s²).
5. Plots velocity and rolling resistance for every run and saves each figure to `plots/`.

## Repository layout

| Path | Contents |
|---|---|
| `src/compute_rr_from_tt.m` | Function: synchronized timetable in, velocity and rolling resistance out |
| `src/run_rr_cases.m` | Script: runs every hub and motor log and saves the plots |
| `data/hub/No Motor.zip` | Two runs without the motor (hub only) |
| `data/motor/Motor .zip` | Six runs with the motor installed |
| `plots/` | Result figures |

## Run it

1. Unzip both archives and put the logs where `src/run_rr_cases.m` loads them:

   | From the archive | To |
   |---|---|
   | `No Motor/hub 1 a.mat` | `data/hub/hub_1_a.mat` |
   | `No Motor/hub 2 b.mat` | `data/hub/hub_2_b.mat` |
   | `Motor /sensorlog_20251114_212931.mat` | `data/motor/sensorlog_20251114_212931.mat` |
   | `Motor /sensorlog_20251114_170352.mat` | `data/motor/sensorlog_20251114_170352.mat` |

   The motor archive also holds four more runs (`1.mat`, `2 F.mat`, `3 B.mat`, `5 B.mat`); add them to `motor_files` in the script to include them.
2. Open MATLAB with the repository root as the current folder.
3. Run:

   ```matlab
   addpath src
   run_rr_cases
   ```

4. Figures open for each run and are saved as `plots/hub_<n>_results.png` and `plots/motor_<n>_results.png`.

## Assumptions and limits

- The first numeric column of each timetable is taken as acceleration.
- Velocity comes from integrating smoothed acceleration, so it drifts over long runs.
- The rolling-resistance model and the 5 kg mass are first-pass values set in `compute_rr_from_tt.m`. Change them there for another vehicle.

## Author

Andres Peña, Electromechanical Lead, ASME / Shell Eco-marathon · [andres.swort.net](https://andres.swort.net)
