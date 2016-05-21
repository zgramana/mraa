# FIND_PACKAGE (MONO REQUIRED)

include_directories (
  ${CSHARP_INCLUDE_PATH}
  ${CSHARP_INCLUDE_PATH2}
  ${CMAKE_CURRENT_SOURCE_DIR}/..
)

# SWIG treats SWIG_FLAGS as a list and not a string so semicolon seperation is required
set_source_files_properties (mraacsharp.i PROPERTIES SWIG_FLAGS ";-namespace;Mraa;-dllimport;libmraacsharp.so;-I${CMAKE_BINARY_DIR}/src")
set_source_files_properties (mraacsharp.i PROPERTIES CPLUSPLUS ON)

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive -DCSHARPCALLBACK")
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DCSHARPCALLBACK")

set (MONO_PATH_NATIVE /usr)
set (MONO_PATH /usr/lib/mono/4.5)
set (CSHARPC ${MONO_PATH_NATIVE}/bin/mcs)

swig_add_module (mraacsharp csharp mraacsharp.i ${mraa_LIB_SRCS})
swig_link_libraries (mraacsharp ${CSHARP_LIBRARIES} ${mraa_LIBS})

add_custom_command (TARGET mraacsharp
  POST_BUILD
  COMMAND cmake -E echo "Compiling csharp.."  
  COMMAND ${CSHARPC} /noconfig /debug:pdbonly /optimize+ /target:library /define:TRACE /nostdlib /platform:x86 /out:Mraa.dll ${CMAKE_CURRENT_SOURCE_DIR}/Extensions.cs *.cs /reference:$ENV{MONO_PATH}/System.Core.dll /reference:$ENV{MONO_PATH}/mscorlib.dll /warn:4  
)

if (DOXYGEN_FOUND)
  foreach (_file ${DOCFILES})
    add_dependencies (${SWIG_MODULE_mraacsharp_REAL_NAME} ${_file}doc_i)
  endforeach ()
endif ()

mraa_create_install_pkgconfig (mraacsharp.pc ${CMAKE_INSTALL_LIBDIR}/pkgconfig)

install (TARGETS mraacsharp LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
install (FILES ${CMAKE_CURRENT_BINARY_DIR}/Mraa.dll DESTINATION ${CMAKE_INSTALL_LIBDIR}/../lib/csharp)
