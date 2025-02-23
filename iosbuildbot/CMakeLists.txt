cmake_minimum_required(VERSION 3.15)
project(iosbuildbot LANGUAGES OBJC)
enable_language(OBJC)

add_executable(${PROJECT_NAME}
    main.m
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    iosbuildbot-core
)

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION .
)
