# Environment-Adaptive ORB-SLAM3 Feature Extraction

Brightness-adaptive ORB feature extraction for improved visual SLAM robustness under varying illumination conditions.

This project modifies the ORB-SLAM3 feature extractor to dynamically adjust FAST detection thresholds and the target number of ORB features based on scene brightness. The adaptive approach increases feature density in darker environments while reducing unnecessary computation in well-lit scenes, with minimal impact on runtime.

---

## Overview

Standard ORB-SLAM3 uses fixed feature extraction parameters across all frames. However, lighting conditions significantly affect keypoint detection quality and tracking stability.

This project introduces a lightweight adaptive module that:

- Computes mean frame brightness in real time
- Normalizes brightness to a 0–1 range
- Dynamically adjusts FAST thresholds
- Scales the ORB feature budget between **85%–115%** of baseline

The adaptive logic is implemented directly inside the ORB extractor and integrates seamlessly with the existing ORB-SLAM3 pipeline.

---

## My Contributions

- Implemented brightness-adaptive FAST threshold scaling
- Added dynamic ORB feature budget adjustment
- Preserved original ORB-SLAM3 architecture and threading model
- Evaluated performance on EuRoC Machine Hall and Vicon Room datasets
- Measured ATE, runtime, CPU usage, and memory overhead

---

## System Architecture

![Architecture](docs/architecture.png)

The adaptive module is inserted before feature extraction and does not modify downstream tracking, mapping, or loop-closing modules.

---

## Key Results

![ATE RMSE](docs/ate_rmse.png)

**Observations:**

- Comparable accuracy on easy sequences
- Improved robustness on challenging lighting conditions (e.g., MH04 difficult)
- Negligible runtime overhead (<1% change)

---

## Upstream Dependency (ORB-SLAM3)

This repository does **not** include the full ORB-SLAM3 source code.

Clone ORB-SLAM3 separately:

git clone https://github.com/UZ-SLAMLab/ORB_SLAM3.git

Then replace the original extractor files with the modified versions from this repo.

Example:

cp src/modified_files/ORBextractor.* ORB_SLAM3/src/

---

## Adaptive Method Details

### Brightness Estimation
Mean grayscale intensity is computed per frame using:

cv::mean(image)

Brightness is normalized to [0,1].

### FAST Threshold Adaptation
FAST thresholds are dynamically mapped between:

- fIniThFAST_MAX
- fIniThFAST_MIN

This adjusts feature detection sensitivity based on illumination.

### Adaptive Feature Budget
The target number of features is scaled:

nfeatures = nOriginalFeatures * featureMultiplier

Where:

featureMultiplier ∈ [0.85 , 1.15]

- Dark scenes → higher multiplier → more features
- Bright scenes → lower multiplier → fewer features

---

## Evaluation

Datasets:

- EuRoC Machine Hall (MH01, MH04, MH05)
- EuRoC Vicon Room (V101, V103)

Metrics:

- Absolute Trajectory Error (ATE)
- Runtime
- CPU usage
- Memory usage

Full analysis available in:

report/Report.pdf

---

## Credits

This work builds upon:

ORB-SLAM3  
https://github.com/UZ-SLAMLab/ORB_SLAM3

Original authors:  
Campos, Elvira, Gómez Rodríguez, Montiel, Tardós

---

## Author

Brayden Currier  
Computer Engineering
