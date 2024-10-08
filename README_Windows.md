# openvino_play for Windows Instructions

This repo demonstrates the setup of all required Intel GPU and NPU user-space drivers for use with OpenVINO 2024.4 and Windows manually using the cmd.exe terminal. (Although Windows 11 supports Intel GPU pass-through when using WSL2 and Docker, there is no associated Docker Desktop support for Intel GPU passthrough for native Windows based containers.) It has been tested on a Intel 13th Gen Intel(R) Core(TM) i9-13900H,  Intel(R) Core(TM) Ultra 5 125H processor, Intel(R) Core(TM) Ultra 7 258V processor, and 13th Gen Intel(R) Core(TM) i7-13700K with Intel(R) ARC A770 Discrete GPU

## Prerequisites
The following software should be installed as prerequisites:
* Windows 11 Home or Pro
* MiniForge3 from https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Windows-x86_64.exe
* Visual Studio 2022 from https://visualstudio.microsoft.com/vs/, and select "Develop C++ applications" option
* OpenVINO 2024.4 from https://storage.openvinotoolkit.org/repositories/openvino/packages/2024.4/windows/w_openvino_toolkit_windows_2024.4.0.16579.c3152d32c9c_x86_64.zip, extract, and copy folder to c:\openvino_2024.4.0
* Intel ARC & Iris XE GPU driver from https://www.intel.com/content/www/us/en/download/785597/intel-arc-iris-xe-graphics-windows.html (or newer)
* Intel NPU driver from https://www.intel.com/content/www/us/en/download/794734/intel-npu-driver-windows.html or newer

## Initialize a MiniForge environment
Launch "Developer Command Prompt for VS2022" and type the following:
```
> \users\%USERNAME%\miniforge3\scripts\activate.bat
> conda create -n ov python=3.10* -y
> conda init
> exit
```

## Setup the OpenVINO environment and execute benchmarks
Launch "Developer Command Prompt for VS2022" and type the following:
```
> \users\%USERNAME%\miniforge3\scripts\activate.bat ov
> \openvino_2024.4.0\setupvars.bat

> cd \openvino_2024.4.0\python
> pip install -r requirements.txt torch torchvision nncf

> cd \openvino_2024.4.0\samples\cpp
> build_samples_msvc.bat

> \Users\%USERNAME%\Documents\Intel\OpenVINO\openvino_cpp_samples_build\intel64\Release\hello_query_device

> cd \Users\%USERNAME%
> git clone https://github.com/mattcurf/openvino_play
> cd openvino_play
> python download_resnet50.py

> \users\%USERNAME%\Documents\Intel\OpenVINO\openvino_cpp_samples_build\intel64\Release\benchmark_app.exe -m model\ir_model\resnet50_fp16.xml -d CPU -hint throughput -niter 10000

> \users\%USERNAME%\Documents\Intel\OpenVINO\openvino_cpp_samples_build\intel64\Release\benchmark_app.exe -m model\ir_model\resnet50_fp16.xml -d GPU -hint throughput -niter 10000

> \users\%USERNAME%\Documents\Intel\OpenVINO\openvino_cpp_samples_build\intel64\Release\benchmark_app.exe -m model\ir_model\resnet50_fp16.xml -d NPU -hint throughput -niter 10000
```
