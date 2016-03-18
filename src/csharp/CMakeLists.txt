FIND_PACKAGE (JNI REQUIRED)

include_directories (
  ${CSHARP_INCLUDE_PATH}
  ${CSHARP_INCLUDE_PATH2}
  ${CMAKE_CURRENT_SOURCE_DIR}/..
)

# SWIG treats SWIG_FLAGS as a list and not a string so semicolon seperation is required
set_source_files_properties (mraacsharp.i PROPERTIES SWIG_FLAGS ";-package;mraa;-I${CMAKE_BINARY_DIR}/src")
set_source_files_properties (mraacsharp.i PROPERTIES CPLUSPLUS ON)

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive -DCSHARPCALLBACK")
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DCSHARPCALLBACK")

if (NOT DEFINED ENV{CSHARP_HOME_NATIVE})
  if (NOT DEFINED ENV{CSHARP_HOME})
    message (FATAL_ERROR " - Neither CSHARP_HOME nor CSHARP_HOME_NATIVE are set")
  endif()
  set (CSHARP_HOME_NATIVE $ENV{CSHARP_HOME})
  set (CSHARPC $ENV{CSHARP_HOME}/bin/csharpc)
  set (JAR $ENV{CSHARP_HOME}/bin/jar)
else ()
  set (CSHARPC $ENV{CSHARP_HOME_NATIVE}/bin/csharpc)
  set (JAR $ENV{CSHARP_HOME_NATIVE}/bin/jar)
endif ()

swig_add_module (mraacsharp csharp mraacsharp.i ${mraa_LIB_SRCS})
swig_link_libraries (mraacsharp ${CSHARP_LIBRARIES} ${mraa_LIBS})

add_custom_command (TARGET mraacsharp
  POST_BUILD
  COMMAND cmake -E echo "Compiling csharp.."
  COMMAND cmake -E make_directory ${CMAKE_CURRENT_BINARY_DIR}/mraa
  COMMAND ${CSHARPC} *.csharp -d ${CMAKE_CURRENT_BINARY_DIR}
  COMMAND cmake -E echo "Creating jar"
  COMMAND ${JAR} cvf mraa.jar mraa
)

if (DOXYGEN_FOUND)
  foreach (_file ${DOCFILES})
    add_dependencies (${SWIG_MODULE_mraacsharp_REAL_NAME} ${_file}doc_i)
  endforeach ()
endif ()

mraa_create_install_pkgconfig (mraacsharp.pc ${CMAKE_INSTALL_LIBDIR}/pkgconfig)

install (TARGETS mraacsharp LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
install (FILES ${CMAKE_CURRENT_BINARY_DIR}/mraa.jar DESTINATION ${CMAKE_INSTALL_LIBDIR}/../lib/csharp)
