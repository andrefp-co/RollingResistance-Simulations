# Rolling Resistance Analysis

This MATLAB project computes velocity and rolling resistance from experimental timetables.

## Structure
- `data/` : contains hub (no motor) and motor sensor data.
- `scripts/compute_rr_from_tt_fixed.m` : function to compute rolling resistance.
- `scripts/run_all_rr.m` : script to run all computations and plot results.

## How to Run
1. Open MATLAB.
2. Set current folder to `scripts/`.
3. Run `run_all_rr.m`.
4. Figures will appear for hub (no motor) and motor data.

## Notes
- Assumes the first numeric column of each timetable is acceleration.
- Synchronization is done using MATLAB's `synchronize` function.
