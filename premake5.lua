workspace "HelloWorld"
  configurations { "Debug", "Release" }

project "HelloWorld"
  kind "ConsoleApp"
  language "C++"
  cppdialect "C++20"

  targetdir "bin/%{cfg.buildcfg}"

  files { "**.h", "**.cpp" }

  filter "configurations:Debug"
    defines { "DEBUG" }
    symbols "On"

  filter "configurations:Release"
    defines { "NDEBUG" }
    optimize "On"
