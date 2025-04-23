cmake_minimum_required(VERSION 3.16)

project(Sonnenblume_morphen VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)


# Find required Qt packages
find_package(Qt6 REQUIRED COMPONENTS Quick Qml)

# Optional: SerialPort (für später)
find_package(Qt6SerialPort QUIET)

# Create the executable
qt_add_executable(appSonnenblume_morphen
    main.cpp
)

# Wichtig: Automoc aktivieren für Q_OBJECT in main.cpp
set_source_files_properties(main.cpp PROPERTIES SKIP_AUTOMOC OFF)

# QML-Modul hinzufügen
qt_add_qml_module(appSonnenblume_morphen
    URI Sonnenblume_morphen
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES images.qrc
)

# Bibliotheken verlinken
target_link_libraries(appSonnenblume_morphen
    PRIVATE Qt6::Quick Qt6::Qml
)

# Wenn SerialPort gefunden → einbinden + define setzen
if(Qt6SerialPort_FOUND)
    target_link_libraries(appSonnenblume_morphen PRIVATE Qt6::SerialPort)
    target_compile_definitions(appSonnenblume_morphen PRIVATE USE_ARDUINO)
endif()

# Installieren (optional)
include(GNUInstallDirs)
install(TARGETS appSonnenblume_morphen
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
