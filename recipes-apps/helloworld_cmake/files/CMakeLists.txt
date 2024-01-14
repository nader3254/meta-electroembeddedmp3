cmake_minimum_required(VERSION 3.10)

project(HelloWorldCmakeProject)

# Include directories
include_directories(include)

# Define the sources
set(SOURCES
    src/main.cpp
)


# Create the executable
add_executable(helloworld_cmake ${SOURCES})

install(TARGETS helloworld_cmake RUNTIME DESTINATION bin)

# # Specify the installation path
# set(INSTALL_DIR /bin)

# # Install the executable
# install(TARGETS helloworld_cmake DESTINATION ${INSTALL_DIR})

# # Install the headers
# install(DIRECTORY include/ DESTINATION /include)
