# TFLite Flutter Plugin Performance Analysis

This repository evaluates the performance of object detection using different versions of the [TFLite Flutter Plugin](https://github.com/am15h/tflite_flutter_plugin).

Notable performance discrepancies have been observed between the earlier and later versions. This repository enables testing for:

* `tflite_flutter` versions 0.9.5 and 0.10.4
* Flutter versions 3.13.9 and 3.16.9

#### **Crucial Setup Step**

For `tflite_flutter` version 0.9.5, it is necessary to:

* Run `install.sh` on Linux or `install.bat` on Windows to fetch the required TFLite binaries.
  For detailed instructions, refer to [this section](https://github.com/am15h/tflite_flutter_plugin#important-initial-setup).

## Evaluation Protocol

### Testing Conditions

The following conditions were used for testing:

* Compilation was performed on a Windows 10 machine utilizing Java 11.0.12
* The tests were executed on a Pixel 5 device running Android 14

The camera captured a static, near-blank image to standardize the test conditions. 
While not excessively rigorous (external factors like device temperature may affect performance), 
variations of a few milliseconds are considered negligible. 
However, larger discrepancies in performance are deemed significant.

### Experimental Findings

The average times until performance stabilized are documented in milliseconds (ms).

| Evaluation Criterion                        | Inference Time | Pre-processing Time | Total Prediction Time | Total Elapsed Time |
|---------------------------------------------|----------------|---------------------|-----------------------|--------------------|
| `tflite_flutter`: 0.9.5<br/>Flutter: 3.13.9 | 22             | 17                  | 39                    | 51                 |
| `tflite_flutter`: 0.9.5<br/>Flutter: 3.16.9 | 359            | 18                  | 378                   | 387                |
| `tflite_flutter`: 0.10.4<br/>Flutter: 3.13.9| 22             | 15                  | 38                    | 50                 |
| `tflite_flutter`: 0.10.4<br/>Flutter: 3.16.9| 351            | 16                  | 368                   | 376                |

### Inferences

* No variances when comparing `tflite_flutter` versions 0.9.5 to 0.10.4
* A substantial change is evident between Flutter versions 3.13.9 and 3.16.9, with the latter showing an inference time slowdown by a factor of 16, and a total time increase by roughly 7.5 times.

Subsequent Flutter release 3.19.3 appears to sustain the reduced performance noted in 3.16.9, indicating that the observed issue has yet to be resolved.
