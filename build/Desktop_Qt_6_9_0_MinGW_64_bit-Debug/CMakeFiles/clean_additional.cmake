# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appSonne_Test_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appSonne_Test_autogen.dir\\ParseCache.txt"
  "appSonne_Test_autogen"
  )
endif()
