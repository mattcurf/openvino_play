# Enumerate all GPU devices and select the one with the largest core count, or default to CPU
# If there are multiple GPU devices with largest core count, then use the MULTI device with
# all of them

from openvino.runtime import Core
core = Core()
core_count = 0
device_name = 'CPU'

for gpu_name in [device for device in core.available_devices if 'GPU' in device]:
  gpu_core_count = core.get_property(gpu_name, 'GPU_EXECUTION_UNITS_COUNT')
  if core_count == gpu_core_count:
    if "MULTI" in device_name:
      device_name = device_name + "," + gpu_name
    else:
      device_name = "MULTI:" + device_name + "," + gpu_name
  if core_count < gpu_core_count:
    core_count = gpu_core_count
    device_name = gpu_name

print(device_name)
