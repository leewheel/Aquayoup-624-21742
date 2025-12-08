# Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# Require CMake >= 4.1.2
cmake_minimum_required(VERSION 4.1.2 FATAL_ERROR)

# 全局设置方式
if(MSVC)
    # /utf-8 同时设置源字符集和执行字符集为UTF-8
    # 等价于 /source-charset:utf-8 /execution-charset:utf-8
    add_compile_options(/utf-8)
endif()

# Set project name and languages
project(TrinityCore LANGUAGES C CXX)

# NOTE:
# CMP0005 is removed because modern CMake requires NEW behavior and
# setting it to OLD is not supported in CMake >= 3.x/4.x.
# Only set policies when they exist; prefer NEW behavior for modern CMake.

if(POLICY CMP0043)
  # CMP0043: Ignore COMPILE_DEFINITIONS_<CONFIG> properties
  # Original project set this to OLD; modern CMake behaves differently.
  # Use NEW to match current CMake behavior (and avoid unsupported OLD setting).
  cmake_policy(SET CMP0043 NEW)
endif()

if(POLICY CMP0054)
  # Only interpret if() arguments as variables or keywords when unquoted
  cmake_policy(SET CMP0054 NEW)
endif()

# Some later policies — set NEW if available to get modern behavior
if(POLICY CMP0135)
  cmake_policy(SET CMP0135 NEW)
endif()

# Disable in-source changes/builds
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

# RPATH handling
set(CMAKE_SKIP_BUILD_RPATH 0)
set(CMAKE_BUILD_WITH_INSTALL_RPATH 0)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH 1)

# Macro directory
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/macros")

# Default build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
endif()

include(CheckCXXSourceRuns)
include(CheckIncludeFiles)
include(ConfigureScripts)

# Default build options
include(cmake/options.cmake)

# Disable precompiled headers if requested
if(NOPCH)
  set(USE_COREPCH 0)
  set(USE_SCRIPTPCH 0)
endif()

include(CheckPlatform)
include(GroupSources)
include(AutoCollect)

find_package(PCHSupport)
find_package(MySQL REQUIRED)

if(NOT WITHOUT_GIT)
  find_package(Git QUIET)
endif()

# Generate revision info
include(cmake/genrev.cmake)

# Show configuration summary
include(cmake/showoptions.cmake)

# Add dependencies
add_subdirectory(dep)

# Add core sources
add_subdirectory(src)
